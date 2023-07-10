import os, sys, ast
os.environ["KMP_DUPLICATE_LIB_OK"]="TRUE"
import numpy as np
import torch
from torch import nn, optim
from multiprocessing import Process, Manager
from tqdm import tqdm
import time, copy
import matplotlib.pyplot as plt


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


def most_stable_part(data, window, step=1):
    if len(data) < window:
        return data
    variances = [np.var(data[i:i + window]) for i in range(0, len(data) - window + 1, step)]
    min_start_point = np.argmin(variances)
    return data[min_start_point:min_start_point + window]


##
## Implementation of the neural divergence estimator for one dimensional data
##
## :param      x_pool:      the data of the first distribution
## :type       x_pool:      numpy array, shape of data_dim x num_of_sample
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
    # Create a model if not specified
    if get_model is None:
        d = x_pool.shape[1]
        if (int(d * sr) < 1):
            raise Exception("The number of units in the hidden layer must be greater than zero!")
        # model = nn.Sequential(
        #     nn.LazyLinear(int(d * sr)),
        #     nn.ReLU(),
        #     nn.LazyLinear(1))
        model = nn.Sequential(
            nn.Linear(d, int(d * sr)),
            nn.ReLU(),
            nn.Linear(int(d * sr), 1))
    else:
        model = get_model()

    # Create an optimizer
    opt = optim.Adam(model.parameters(), lr=lr)
    # Calculate batch_size if necessary
    batch_size = int(max(100, x_pool.shape[0] // 10 if batch_size is None else batch_size))
    batch_size = min(batch_size, x_pool.shape[0])

    estimates = []    # Store losses
    window = 6
    start = 0
    end = batch_size

    x_pool = torch.tensor(x_pool, dtype=TENSOR_TYPE, requires_grad=False)
    y_pool = torch.tensor(y_pool, dtype=TENSOR_TYPE, requires_grad=False)
    # Train the statistics network to estimate the KL divergence
    for epoch in tqdm(range(max_epochs)) if debug else range(max_epochs):
        x_pool = x_pool[torch.randperm(x_pool.size()[0])]
        y_pool = y_pool[torch.randperm(y_pool.size()[0])]
        # SGD learn a whole epoch
        opt.zero_grad()
        for start in range(0, x_pool.shape[0], batch_size):
            end = min(x_pool.shape[0], start + batch_size)
            x = x_pool[start:end]
            y = y_pool[start:end]
            # Evaluate gradients
            loss_value = loss(model, x, y)
            loss_value.backward()
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
            # Recreate the model, start from a new random point
            # model = nn.Sequential(
            #     nn.LazyLinear(int(d * sr)),
            #     nn.ReLU(),
            #     nn.LazyLinear(1))

            # model = reinitialize_weight(model)
            if get_model is None:
                model = nn.Sequential(
                    nn.Linear(d, int(d * sr)),
                    nn.ReLU(),
                    nn.Linear(int(d * sr), 1))
            else:
                model = get_model()
            opt = optim.Adam(model.parameters(), lr=lr)

        # Begin new epoch
        start = 0
        end = batch_size

    if debug:
        plt.plot(estimates)
        plt.show()
    if epoch == max_epochs - 1:
        if debug:
            pass
            # print("Lim reached!", -np.min(estimates[-window:]))
        # estimates = most_stable_part(estimates, window=10)

    return max(-np.min(estimates), 0.0)


def DivergenceApproximateWithTag(x_pool, y_pool, tag, _return=None, **kwargs):
    estimate = DivergenceApproximate(x_pool, y_pool, **kwargs)
    if _return is not None:
        _return.append((estimate, tag))
    else:
        return estimate, tag


def ParrallelDivergenceEstimator(origin, perturbations, num_workers, log=False, **kwargs):

    estimates = []
    workers = []
    manager = Manager()
    returns = manager.list()
    kwargs['debug'] = False

    for i, perturbation in enumerate(perturbations):
        while True:
            if len(returns) + num_workers > len(workers):
                workers.append(Process(target=DivergenceApproximateWithTag, args=(origin, perturbation, i, returns), kwargs=kwargs))
                workers[-1].daemon = True
                workers[-1].start()
                break
            else:
                time.sleep(3)
            if log:
                print(f'\rEstimated={len(returns)}', end='')
    while len(returns) < len(workers):
        if log:
            print(f'\rEstimated={len(returns)}', end='')
        time.sleep(3)

    for estimate, pos in returns:
        estimates.insert(pos, estimate)
    return estimates


def GLM_generate_observation(theta):
    z = np.random.normal(scale=1, size=theta.shape)
    x = theta + z
    return x


if __name__ == "__main__":
    # # Load args
    args = sys.argv
    timestamp_id = args[1]
    data_size = int(args[2])
    delta_arr = [float(args[3])] * 10
    epochs = int(args[4])
    lr = float(args[5])
    sigma_square = 1/float(args[6])
    i_sigma = 0

    BCRB_arr = []
    FINE_BIM_arr = []
    FINE_BCRB_arr = []
    size_multi = []

    d = 1 # have not derived ground truth for d > 1
    BCRB_arr.append(sigma_square / (sigma_square + 1)) # ground truth

    sigma = np.sqrt(sigma_square)
    theta = np.random.normal(scale=sigma, size=(d, data_size))    
    x = GLM_generate_observation(theta)

    train_settings = {
        "max_epochs": epochs,
        "batch_size": None,
        "sr": 5,
        "lr": lr,
        "minor": 1e-4,
        "get_model": None,
        "debug": False
    }
    trials = 1

    n_theta = np.zeros(d)
    for m in range(d):
        print("Diagon #", m + 1, "/", d, flush=True)
        delta = np.zeros(d)
        delta[m] = delta_arr[i_sigma]

        theta_shifted = np.copy(theta) + np.expand_dims(delta, axis=1)
        origin = np.vstack((x, theta)).T
        shifted = np.vstack((x, theta_shifted)).T

        estimate = []
        for _ in (range(trials)):
            estimate.append(2 * DivergenceApproximate(origin, shifted, **train_settings))
        n_theta[m] = np.max(estimate)

    B_diag = n_theta / (delta ** 2)
    BIM = np.diag(B_diag)

    # non-diagonal, no need for d=1
    for i in range(d - 1):
        for j in range(i + 1, d):
            print("Entry", i, '-', j, flush=True)
            delta = np.zeros(d)
            delta[i] = delta_arr[i_sigma]
            delta[j] = delta_arr[i_sigma]

            theta_shifted = np.copy(theta) + np.expand_dims(delta, axis=1)
            x_prime = GLM_generate_observation(theta_shifted)

            origin = np.vstack((x, theta)).T
            shifted = np.vstack((x_prime, theta_shifted)).T


            estimate = []
            for _ in range(trials):
                estimate.append(2 * DivergenceApproximate(origin, shifted, **train_settings))
            n_theta = np.max(estimate)
            BIM[i, j] = (n_theta - (delta_arr[i_sigma] ** 2) * (B_diag[i] + B_diag[j]) ) / (2 * delta_arr[i_sigma] ** 2)
            BIM[j, i] = BIM[i, j]

    FINE_BIM_arr.append(BIM)
    FINE_BCRB = np.linalg.inv(BIM)

    FINE_BCRB_arr.append(np.abs(np.trace(FINE_BCRB)))

    ## Save result to .txt file for MATLAB
    dir_path = os.path.dirname(os.path.realpath(__file__))
    file_name = 'result_' + timestamp_id + '.txt'
    file_path = os.path.join(dir_path, file_name)
    
    print('True')

    with open(file_path, 'a') as result:
        result.write('\n')
        result.write(str(sigma_square))
        result.write('\n')
        result.write(str(FINE_BCRB_arr))