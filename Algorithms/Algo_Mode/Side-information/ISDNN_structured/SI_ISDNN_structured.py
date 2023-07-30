import random
import numpy as np
import torch
import torch.nn as nn
from torch.nn import functional as F
import sys
import os
current_path = os.path.dirname(os.path.abspath(__file__))
sys.path.append(current_path)

torch.set_default_dtype(torch.float64)

# **Demodulation**
def demapper(symbols_I, symbols_Q, packetSize, threshold = 3.0):
    Ns = int(packetSize/4)
    bits_I = []
    bits_Q = []
    for i in range(Ns):
        if symbols_I[i] >= 0 and symbols_I[i] <= threshold:
            bits_I.append(1)
            bits_I.append(0)

        if symbols_I[i] > threshold:
            bits_I.append(1)
            bits_I.append(1)

        if symbols_I[i] < 0 and symbols_I[i] >= -threshold:
            bits_I.append(0)
            bits_I.append(1)

        if symbols_I[i] < -threshold:
            bits_I.append(0)
            bits_I.append(0)

        if symbols_Q[i] >= 0 and symbols_Q[i] <= threshold:
            bits_Q.append(1)
            bits_Q.append(0)

        if symbols_Q[i] > threshold:
            bits_Q.append(1)
            bits_Q.append(1)

        if symbols_Q[i] < 0 and symbols_Q[i] >= -threshold:
            bits_Q.append(0)
            bits_Q.append(1)

        if symbols_Q[i] < -threshold:
            bits_Q.append(0)
            bits_Q.append(0)

    bits_I = list(map(int, bits_I))
    bits_Q = list(map(int, bits_Q))

    bitStream = np.zeros(packetSize)

    for i in range(len(bits_I)):            # 0 -> 15
        bitStream[2*i] = bits_I[i]
        bitStream[2*i-1] = bits_Q[i-1]
    return(bitStream)


# **slicer the data**
def slicer(data):
    dataI = data[slice(0, len(data), 2)]
    dataQ = data[slice(1, len(data), 2)]
    return(dataI, dataQ)


# **Modulation**
def mapper_16QAM(QAM16, data):
    map0 = 2*data[slice(0, len(data), 2)] + data[slice(1, len(data), 2)]
    map0 = list(map(int, map0))
    dataMapped = []
    for i in range(len(map0)):
        dataMapped.append(QAM16[map0[i]])
    return(dataMapped)


def calculate_bits(Modulation,NumSubcarriers,NumDataSymb):
    if Modulation=='QPSK':
        Nbpscs=2
    elif Modulation=='16QAM':
        Nbpscs=4
    return NumDataSymb*NumSubcarriers*Nbpscs


# **generate noise**
def AWGN(IFsig, SNR):
    dP = np.zeros(len(IFsig))
    P = 0

    for i in range(len(IFsig)):
        dP[i] = abs(IFsig[i])**2
        P = P + dP[i]

    P = P/len(IFsig)
    gamma = 10**(SNR/10)
    N0 = P/gamma
    n = ((N0/2)**(0.5))*np.random.standard_normal(len(IFsig))
    IF_n = np.zeros((len(IFsig),1))

    for i in range(len(IFsig)):
        IF_n[i,:] = IFsig[i] + n[i]

    return(IF_n)


# Generate channel model
def unstructured_channel(N, K, type):
    if (type == 'gauss'):
        return (np.random.normal(size=(N,K))+1j*np.random.normal(size=(N,K)))/np.sqrt(2)
    
def Generate_channel(N, K, d_H, array_type, elements_nor, type, Nr_ULA, Nr_UCA):
    if (type == 'gauss'):

        H = (np.random.normal(size=(N,K))+1j*np.random.normal(size=(N,K)))/np.sqrt(2)
        H_oG = np.zeros((N, K), dtype=complex)
        Gamma = []
        Zoa = []
        Aoa = []

        Steering = np.zeros((N, K, d_H), dtype=complex)

        for nt in range (K):
            zoa = np.random.uniform(-np.pi / 2, np.pi / 2, d_H)
            aoa = np.random.uniform(-np.pi / 2, np.pi / 2, d_H)
            
            Zoa.append(zoa)
            Aoa.append(aoa)

        Zoa = np.array(Zoa)
        Aoa = np.array(Aoa)

        if array_type == 'ULA':
            for nr in range (N):
                for nn in range (K):
                    h = 0
                    for jj in range(d_H): 
                        r_x = np.sin(Zoa[nn,jj]) * np.cos(Aoa[nn,jj])
                        r_y = np.sin(Zoa[nn,jj]) * np.sin(Aoa[nn,jj])
                        r_z = np.cos(Zoa[nn,jj])
                        
                        Steering[nr, nn, jj] = np.exp(-1j*2*np.pi * (elements_nor[0, 0, nr]*r_x 
                                                                    + elements_nor[1, 0, nr]*r_y 
                                                                    + elements_nor[2, 0, nr]*r_z))
                    
                    H_oG[nr, nn] = np.divide(H[nr, nn],  Steering[nr, nn, 0]) 

        else:
            r = -1
            for Nr_ULA_index in range (Nr_ULA):
                for Nr_UCA_index in range (Nr_UCA):
                    r=r+1
                    for nn in range (K):
                        h = 0
                        for jj in range(d_H): 
                            r_x = np.sin(Zoa[nn,jj]) * np.cos(Aoa[nn,jj])
                            r_y = np.sin(Zoa[nn,jj]) * np.sin(Aoa[nn,jj])
                            r_z = np.cos(Zoa[nn,jj])
                                                                        
                            Steering[r, nn, jj] = np.exp(-1j*2*np.pi *(elements_nor[0, Nr_ULA_index, Nr_UCA_index]*r_x 
                                                                        + elements_nor[1, Nr_ULA_index, Nr_UCA_index]*r_y 
                                                                        + elements_nor[2, Nr_ULA_index, Nr_UCA_index]*r_z))
                        
                        H_oG[r, nn] = np.divide(H[r, nn],  Steering[r, nn, 0]) 

        return H, H_oG, Gamma, Steering
    

# **Generate Dataset**
def Gen_dataset(mode, array_type, snr, imperfect, N_samp):    
    DataSet_s   = []  # x dataset after modulation
    DataSet_x   = []  # y dataset
    DataSet_H   = []
    DataSet_Steering = []

    NumSubcarriers = 1
    Modulation = '16QAM'
    QAM16 = [-1, -0.333, 0.333, 1]
    NumDataSymb = 1
    N_type = 'gauss'

    d_H = 1
    d_ULA_nor  = 0.5
    d_UCA_nor  = 0.5
    Nr_UCA = 16
    Nr_ULA = 4
    N = Nr_UCA * Nr_ULA
    K = 8

    if array_type == 'ULA':
        elements_nor = np.zeros((3, 1, N), dtype=float)
        for Nr_index in range (N):
            elements_nor[0, 0, Nr_index] = (Nr_index-1) * d_UCA_nor
            elements_nor[1, 0, Nr_index] = 0
            elements_nor[2, 0, Nr_index] = 0
    else:
        elements_nor = np.zeros((3, Nr_ULA, Nr_UCA), dtype=float)

        R_nor = 0.5 * d_UCA_nor / np.sin(np.pi/Nr_UCA)

        for Nr_ULA_index in range (Nr_ULA):
            for Nr_UCA_index in range (Nr_UCA):
                elements_nor[0, Nr_ULA_index, Nr_UCA_index] = R_nor * np.sin((Nr_UCA_index-1)*(2*np.pi/Nr_UCA)) ;         
                elements_nor[1, Nr_ULA_index, Nr_UCA_index] = R_nor * np.cos((Nr_UCA_index-1)*(2*np.pi/Nr_UCA)) ;         
                elements_nor[2, Nr_ULA_index, Nr_UCA_index] = (Nr_ULA_index-1) * d_ULA_nor;    
       
    if mode == 'test':
        for runIdx in range(0, N_samp):    
            H, H_oG, Gamma, Steering = Generate_channel(N, K, d_H, array_type, elements_nor, N_type, Nr_ULA, Nr_UCA)

            coef = (2*np.random.randint(0,2,size=Steering.shape) - 1)
            Steering = Steering + coef * imperfect * Steering
            
            DataSet_Steering.append(np.squeeze(Steering))

            HH = np.concatenate((np.concatenate((H_oG.real, -H_oG.imag), axis=1),
                                np.concatenate((H_oG.imag, H_oG.real), axis=1)), axis=0)
                    
            DataModulatedH = np.zeros((2*K, NumSubcarriers))
            a = calculate_bits(Modulation, NumSubcarriers, NumDataSymb)
            DataRaw = np.zeros((K, a))

            for t in range(K):
                #"data symbol generate"
                NumBits = calculate_bits(Modulation, NumSubcarriers, NumDataSymb)
                bit = np.random.randint(1, 3, NumBits)-1
                DataRaw[t, :] = bit
                I = np.zeros((1, a))
                I[0, :] = DataRaw[t, :]
                (dataI, dataQ) = slicer(I[0])       # 1st, 2nd bit for Re and 3rd, 4th bit for Im

                # Mapper

                mapI = mapper_16QAM(QAM16, dataI)
                mapQ = mapper_16QAM(QAM16, dataQ)
                DataModulatedH[t] = mapI[0]
                DataModulatedH[t+K] = mapQ[0]

            datahH = np.matmul(HH, DataModulatedH)

            # noise
            DatanoiseT = AWGN(datahH, snr)

            x = datahH+DatanoiseT

            DataSet_s.append(DataModulatedH)    # ! I, Q sample distance by K.
            DataSet_x.append(x)                 # ! output sample
            
            # Channel: 
            coef = (2*np.random.randint(0,2,size=H.shape) - 1)
            H = H + coef * imperfect * H
            DataSet_H.append(H)                 # ! Generated channel

    # Shuffle dataset
    random.seed(1)
    temp = list(zip(DataSet_s, DataSet_x, DataSet_H, DataSet_Steering))
    random.shuffle(temp)
    DataSet_s, DataSet_x, DataSet_H, DataSet_Steering = zip(*temp)

    return DataSet_s, DataSet_x, DataSet_H, DataSet_Steering


def Input_ISDNN(mode, DataSet_s, DataSet_x, DataSet_H, DataSet_Steering, N_samp):
    s = []        # ! s_in    , np.diag(np.diag()) return a diag matrix instead of diag components.
    s_true = []   # ! generated s
    H = []
    x = []
    v = []        # ! vector errors
    steering = [] # ! Steering vector: ZoA and AoA

    if mode == 'train':
        n_sample = N_samp * len(SNR)
    else:
        n_sample = N_samp
        
    for i in range (n_sample):
        s_true.append(torch.tensor(DataSet_s[i]))
        H.append(torch.tensor(DataSet_H[i]))
        x.append(torch.tensor(DataSet_x[i]))
        v.append(torch.rand([16,1]))
        steering.append(torch.tensor(DataSet_Steering[i]))

    s_true = torch.stack(s_true, dim=0)
    H = torch.stack(H, dim=0)
    v = torch.stack(v, dim=0)
    x = torch.stack(x, dim=0)
    steering = torch.stack(steering, dim=0)
    
    Beta = torch.div(H, steering)

    tmp = []
    tmp_1 = []
    Di = []
    s = []
    for i in range(n_sample):
        tmp.append(torch.cat((torch.cat((Beta[i].real, -Beta[i].imag), axis=1),
                            torch.cat((Beta[i].imag, Beta[i].real), axis=1)), axis=0))
        tmp_1.append(torch.t(tmp[i]))
        Di.append(torch.linalg.inv(torch.diag(torch.diag(torch.matmul(tmp_1[i], tmp[i])))))
        s.append(torch.matmul(Di[i], torch.matmul(tmp_1[i], x[i])))

    Beta = torch.stack(tmp, dim=0)
    Bt   = torch.stack(tmp_1, dim=0)
    Di   = torch.stack(Di, dim=0)
    s    = torch.stack(s, dim=0)

    Btx  = torch.bmm(Bt, x)
    BtB  = torch.bmm(Bt, Beta)

    return s_true, Di, s, v, Btx, BtB


# ISDNN Model
class xv(nn.Module):
    def __init__(self):
        super(xv, self).__init__()

        self.alpha1 = torch.nn.parameter.Parameter(torch.rand(1))
        self.alpha2 = torch.nn.parameter.Parameter(torch.tensor([0.5]))

    def forward(self, Di, s, v, Btx, BtB):

        BtBs = torch.bmm(BtB, s)

        z    = s + torch.bmm(Di, torch.sub(Btx, BtBs)) + self.alpha1*v

        v    = torch.bmm(Di, torch.sub(Btx, BtBs))

        s    = torch.add((1 - self.alpha2) * z, self.alpha2*s)

        return s, v


class model_driven(nn.Module):
    def __init__(self):
        super(model_driven, self).__init__()
        self.fc1 = torch.nn.Linear(1,1)
        self.fc2 = torch.nn.Linear(1,1)
        self.fc3 = torch.nn.Linear(1,1)
        self.fc4 = torch.nn.Linear(1,1)
        self.fc5 = torch.nn.Linear(1,1)
        self.fc6 = torch.nn.Linear(1,1)
        self.fc7 = torch.nn.Linear(1,1)
        self.fc8 = torch.nn.Linear(1,1)

        self.mod1=xv()
        self.mod2=xv()
        self.mod3=xv()
        self.mod4=xv()
    
    def forward(self, Di, s, v, Btx, BtB):


        v=self.fc1(v)
        v=self.fc2(v)

        s,v=self.mod1(Di, s, v, Btx, BtB)
        s=torch.tanh(s)

        v=self.fc3(v)
        v=self.fc4(v)
        s,v=self.mod2(Di, s, v, Btx, BtB)
        s=torch.tanh(s)

        v=self.fc5(v)
        v=self.fc6(v)
        s,v=self.mod3(Di, s, v, Btx, BtB)
        s=torch.tanh(s)

        v=self.fc7(v)
        v=self.fc8(v)
        s,v=self.mod4(Di, s, v, Btx, BtB)
        
        return s,v
    

# Define the model, optimizer, and loss function
def def_model():
    model = model_driven()
    loss = nn.MSELoss()
    optimizer = torch.optim.Adam(model.parameters(), lr=0.0001)

    record_file = '0_co.txt'
    return model, loss, optimizer, record_file


# Training function
def training_bit(mode, s_true, N_samp):
    s_true_real   = s_true[:, :8, :]
    s_true_img    = s_true[:, 8:, :]

    ddem = []

    if mode == 'train':
        n_sample = N_samp * len(SNR)
    else:
        n_sample = N_samp
    
    for i in range (n_sample):
        data_ex_dem=demapper(s_true_real[i], s_true_img[i], 32, threshold = 0.7)
        ddem.append(data_ex_dem)

    if mode == 'train':
        exact=np.reshape(ddem, N_samp * len(SNR)*32) #32    
    else:
        exact=np.reshape(ddem, N_samp*32) #32    
    return exact


# Function to test the model
def test(exact, Di, s, v, Btx, BtB, N_test): 
    # Load the model that we saved at the end of the training loop 
    model = model_driven()
    model.load_state_dict(torch.load(os.path.join(current_path, 'Params', 'ISDNN_structured_trained.pth'))) 
     
    BER = 0 
    dem_T=[]
 
    with torch.no_grad(): 
        s_T, v_T = model(Di, s, v, Btx, BtB)

        s_T_real      = s_T[:, :8, :]
        s_T_img       = s_T[:, 8:, :]
        
        for i in range (N_test):
            data_demod      = demapper(s_T_real[i], s_T_img[i], 32, threshold = 0.7)
            dem_T.append(data_demod)
            
        result=np.reshape(dem_T, N_test*32)
                
        BER = sum(result != exact) / np.shape(exact)[0]

        print('BER', format(BER, '.7f'))

        return BER

if __name__ == "__main__":
    # # Load args
    args = sys.argv
    timestamp_id = args[1]
    data_size = int(args[2])
    config = args[3]
    SNR = float(args[4])
    Err_rate = float(args[5])


    Dataset_s, Dataset_x, Dataset_H, Dataset_Steering = Gen_dataset('test', config, SNR, Err_rate, data_size)
    s_true, Di, s, v, Btx, BtB = Input_ISDNN('test', Dataset_s, Dataset_x, Dataset_H, Dataset_Steering, data_size)
    exact = training_bit('test', s_true, data_size)
    
    BER = test(exact, Di, s, v, Btx, BtB, data_size)

    ## Save result to .txt file for MATLAB
    dir_path = os.path.dirname(os.path.realpath(__file__))
    file_name = 'result_' + timestamp_id + '.txt'
    file_path = os.path.join(dir_path, file_name)

    print('True')

    with open(file_path, 'a') as result:
        result.write('\n')
        result.write(str(SNR))
        result.write('\n')
        result.write(str(BER))