import os, sys
os.environ["KMP_DUPLICATE_LIB_OK"]="TRUE"
# directory reach
current_path = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.join(current_path, '../../../../Shared/Modulation'))   # Join parent path to import library
import numpy as np
from math import ceil
import torch
from torch import nn, optim
from tqdm import tqdm
from ModulationPy import PSKModem, QAMModem

TENSOR_TYPE = torch.float64

if torch.cuda.is_available():
    torch.set_default_tensor_type(torch.cuda.FloatTensor if TENSOR_TYPE is torch.float32 else torch.cuda.DoubleTensor)
else:
    torch.set_default_tensor_type(torch.FloatTensor if TENSOR_TYPE is torch.float32 else torch.DoubleTensor)


def Donsker_Varadhan_loss(_model, x, y):
    T_x = _model(x)
    T_y = _model(y)
    return -(torch.mean(T_x) - torch.log(torch.mean(torch.exp(T_y))))


def KL_f_divergence_loss(_model, x, y):
    T_x = _model(x)
    T_y = _model(y)
    return -(torch.mean(T_x) - torch.mean(torch.exp(T_y - 1)))


def chi_square_loss(_model, x, y):
    T_x = _model(x)
    T_y = _model(y)
    return -(2 * torch.mean(T_x) - torch.mean(torch.square(T_y)) - 1) / 2


def init_weights(linear):
    if type(linear) == nn.Linear:
        torch.nn.init.xavier_normal_(linear.weight)
        linear.bias.fill_(0.0)


def reinitialize_weight(model):
    with torch.no_grad():
        model.apply(init_weights)


# :param d: size of input vector
# :param sr: hidden layer scale, #hidden_units / d
def get_default_model(d, sr):
    no_hidden = max(int(d * sr), 1)
    return nn.Sequential(
        nn.Linear(d, no_hidden),
        nn.ReLU(),
        nn.Linear(no_hidden, 1))


##
## Implementation of the neural divergence estimator for one dimensional data
##
## :param      x_pool:      the data of the first distribution
## :type       x_pool:      numpy array, shape = num_of_sample x data_dim
## :param      y_pool:      The y pool
## :type       y_pool:      same as x_pool
## :param      batch_size:  batch size (array for dynamic batch size)
## :type       batch_size:  use all data available by default
## :param      model:       the model
## :type       model:       specify a model or the function would build a single-hidden layer model using 
## :param      sr:          scale size of the single hidden layer
## :type       sr:          float, hidden_units = int(sr * data_dim)
## :param      lr:          learning rate
## :type       lr:          float
## :param      max_epochs:  The maximum epochs
## :type       max_epochs:  int
## :param      debug:       debug mode enable
## :type       debug:       bool
## :param      minor:       the limit of slope to detect convergence
## :type       minor:       float
##
## :returns:   the estimated KL-divergence
## :rtype:     float
##
def DivergenceApproximate(x_pool, y_pool, batch_size=None, get_model=None, sr=1, lr=1e-2, max_epochs=200, debug=False, minor=5e-3, loss=Donsker_Varadhan_loss):
    no_samples, d = x_pool.shape
    # Create a model and an optimizer
    model = get_model() if get_model is not None else get_default_model(d, sr)
    opt = optim.Adam(model.parameters(), lr=lr)
    # Calculate batch_size if necessary
    batch_size = int(max(100, no_samples if batch_size is None else batch_size)) # default whole data
    batch_size = ceil(no_samples / ceil(max(no_samples / batch_size, 1)))

    estimates = []    # Store losses
    window = 6
    start = 0
    end = batch_size

    # Turn off grads for data, hughe performance gain
    x_pool = torch.tensor(x_pool, dtype=TENSOR_TYPE, requires_grad=False)
    y_pool = torch.tensor(y_pool, dtype=TENSOR_TYPE, requires_grad=False)
    # Train the statistics network to estimate the KL divergence
    for epoch in tqdm(range(max_epochs)) if debug else range(max_epochs):
        x_pool = x_pool[torch.randperm(x_pool.size()[0])]
        y_pool = y_pool[torch.randperm(y_pool.size()[0])]
        # SGD learn a whole epoch
        opt.zero_grad()
        for start in range(0, no_samples, batch_size):
            end = min(no_samples, start + batch_size)
            x = x_pool[start:end]
            y = y_pool[start:end]
            # Evaluate gradients
            loss_value = loss(model, x, y)
            loss_value.backward()
#             torch.nn.utils.clip_grad_norm_(model.parameters(), max_norm=0.9) #gradient clip
            # Apply them
            opt.step()

        # Calculate and store the loss
        epoch_loss = 0.0
        with torch.no_grad():
            epoch_loss = loss(model, x_pool, y_pool)
        estimates.append(epoch_loss.cpu())

        # Check if diverge
        if np.isnan(estimates[-1]):
            start = -1  # Recreate the model, start from a new random point
            estimates[-1] = 0.0
        # Check stop condition
        elif epoch >= window and estimates[-1] != 0:
            std = np.std(estimates[-window:])
            if std / np.abs(estimates[-1]) < minor:
                # If converge to a negative value, try again
                if estimates[-1] > 0:
                    if debug:
                        print("Converge to a negative value.")
                    start = -1  # Recreate the model, start from a new random point
                else:
                    # Done
                    break

        if start == -1:
            model = get_model() if get_model is not None else get_default_model(d, sr)
            opt = optim.Adam(model.parameters(), lr=lr)
        # Begin new epoch
        start = 0
        end = batch_size

    if epoch == max_epochs - 1:
        if debug:
            pass
            # print("Lim reached!", -np.min(estimates[-window:]))
        # estimates = most_stable_part(estimates, window=10)

    return max(-np.min(estimates), 0.0)


def log(*args, level=0, debug_level=0, **kwargs):
    if level <= debug_level:
        print(*args, **kwargs)

def aggregate(data, mode):
    if mode == 'max':
        return np.max(data)
    elif mode == 'median':
        return np.median(data)
    elif mode == 'mean':
        return np.mean(data)
    else:
        raise RuntimeError("Not supported aggregation mode")

def FINE_BCRB(theta, x, mag_delta=0.15, trial=1, mode='max', train_settings=None, return_BIM=False):
    if train_settings is None:
        train_settings = {
            "max_epochs": 2000,
            "batch_size": 5e5,
            "sr": 5,
            "lr": 1e-4,
            "minor": 1e-5,
            "get_model": None,
            "debug": False
        }
    d = theta.shape[1]
    delta_fix = [mag_delta] * d
    origin = np.hstack((x, theta))
    n_theta = np.zeros(d)
    delta_diag = np.zeros(d)
    for m in range(d):
        log("Diagon #", m + 1, "/", d, flush=True, level=1, debug_level=train_settings['debug'])
        delta = np.zeros(d)
        delta[m] = delta_diag[m] = delta_fix[m]
        theta_shifted = np.copy(theta) + np.expand_dims(delta, axis=0)

        shifted = np.hstack((x, theta_shifted))
        estimate = [(2 * DivergenceApproximate(origin, shifted, **train_settings)) for _ in range(trial)]
        n_theta = aggregate(estimate, mode)

    B_diag = n_theta / (delta_diag ** 2)
    BIM = np.diag(B_diag)

    for i in range(d - 1):
        for j in range(i + 1, d):
            log("Entry", i, '-', j, flush=True, level=1, debug_level=train_settings['debug'])
            delta = np.zeros(d)
            delta[i] = delta_fix[i]
            delta[j] = delta_fix[j]
            theta_shifted = np.copy(theta) + np.expand_dims(delta, axis=0)

            shifted = np.hstack((x, theta_shifted))
            estimate = [(2 * DivergenceApproximate(origin, shifted, **train_settings)) for _ in range(trial)]
            n_theta = aggregate(estimate, mode)
            BIM[i, j] = (n_theta - (delta[i] ** 2) * (B_diag[i] + B_diag[j]) ) / (2 * delta[i] ** 2) # del_i = del_j
            BIM[j, i] = BIM[i, j]

    FINE_BCRB = np.linalg.inv(BIM) if np.linalg.matrix_rank(BIM) == BIM.shape[0] else None

    return (FINE_BCRB, BIM) if return_BIM else FINE_BCRB


if __name__ == "__main__":
    # # Load args
    args = sys.argv
    timestamp_id = args[1]
    K = int(args[2])
    data_size = int(float(args[3]))
    mod = int(args[4])
    sigma_w = float(args[5])
    epochs = int(args[6])
    lr = float(args[7])
    SNR = float(args[8])

    train_settings = {
        "max_epochs": epochs,
        "batch_size": None,
        "sr": 5,
        "lr": lr,
        "minor": 1e-4,
        "get_model": None,
        "debug": False
    }

    FINE_settings = {
        'mag_delta': 0.1,
        'trial': 1,
        'mode': 'median',
        'train_settings': train_settings
    }

    sigma_n = 1 / np.sqrt(10 ** (SNR / 10))

    # Generate input symbols
    # a = np.random.binomial(n=1, p=0.5, size=(K, data_size))
    # a = np.where(a, a, -1).astype(np.float32)
    modem = PSKModem(2, bin_input=False)
    a = np.random.randint(0, 2, 100)

    if mod == 1:
        syms = np.random.randint(0, 2, K * data_size)
        modem = PSKModem(2, bin_input=False, gray_map=False)
    elif mod == 2:
        syms = np.random.randint(0, 4, K * data_size)
        PSKModem(4, np.pi/4, bin_input=False, gray_map=False)
    elif mod == 3:
        syms = np.random.randint(0, 4, K * data_size)
        modem = QAMModem(4, bin_input=False, gray_map=False)
    else:
        syms = np.random.randint(0, 16, K * data_size)
        modem = QAMModem(16, bin_input=False, gray_map=False)

    a = modem.modulate(syms)
    a = np.reshape(a, (K, data_size))

    # Generate noise
    n = np.random.normal(scale=sigma_n / np.sqrt(2), size=(K, data_size)) + 1j * np.random.normal(scale=sigma_n / np.sqrt(2), size=(K, data_size))
    
    # Generate Wiener phase offset
    theta = np.random.normal(scale=sigma_w, size=(K, data_size))

    for k in range(1, K):
        theta[k, :] += theta[k - 1, :]

    # Evaluate receive signal
    y = a * np.exp(-1j * theta) + n

    observation = np.vstack((y.real, y.imag)).T

    BCRB = FINE_BCRB(observation, theta.T, **FINE_settings)
    FINE_BCRB_ = np.abs(np.trace(BCRB) / K)

    ## Save result to .txt file for MATLAB
    dir_path = os.path.dirname(os.path.realpath(__file__))
    file_name = 'result_' + timestamp_id + '.txt'
    file_path = os.path.join(dir_path, file_name)
    
    print('True')

    with open(file_path, 'a') as result:
        result.write('\n')
        result.write(str(SNR))
        result.write('\n')
        result.write(str(FINE_BCRB_))