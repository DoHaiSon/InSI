function [SNR, Err] = NB_ZF(Op, Monte, SNR, Output_type)

% Zero forcing
% Ref: https://www.sharetechnote.com/html/Communication_ChannelModel_ZF.html
%% Input:
    % N: number of sample data
    % Pilot_L: number of pilot symbols
    % ChL: length of the channel
    % Ch_type: type of the channel (real, complex, specular, user' input
    % Mod_type: type of modulation (Bin, QPSK, 4-QAM)
    % Monte: simulation times
    % SNR: range of the SNR
    % Ouput_type: MSE Sig, MSE Ch, Error rate
%% Output:
    % SNR: range of the SNR
    % SER: Symbol error rate
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Generate input signal
    %     X <= h^T * s + n
    % Step 3: Estimate channel
    %     H_est <= Y_pilot ./ X_pilot
    % Step 4: Equalization
    %     X <= Y ./ H_est
    % Step 5: Compute Symbol Error rate
    %     Demodulate Y
    %     Compate elements in two array init data and Demodulated signal
    % Step 6: Return 
%% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
%% Last Modified by Son 29-Sept-2022 12:52:13 


% Initialize variables
N       = Op{1};         % number of sample data
Pilot_L = Op{2};
ChL     = Op{3};         % length of the channel
Ch_type = Op{4};         % complex
Mod_type= Op{5};
Monte   = Monte;
SNR     = SNR;
Output_type = Output_type;

% Generate input signal
modulation = {'Bin', 'QPSK', 'QAM4'};

% CMA algorithm
SER_f = [];
for Monte_i = 1:Monte
    [sig, data]  = eval(strcat(modulation{Mod_type}, '(N)'));
    Pilot      = Gen_Pilot(Pilot_L);
    sig        = cat(1, sig, Pilot);
    Ch         = Generate_channel(1, ChL, Ch_type);
    x          = filter(Ch, 1, sig);
    
    SER_SNR    = [];
    for SNR_i  = 1:length(SNR)
        X      = awgn(x, SNR(SNR_i));              % received noisy signal
        
        H_est  = X(1:Pilot_L) ./ Pilot;
        
        Y = [];
        for k =  1 : floor(N / Pilot_L) 
            Y = cat(1, Y, X((k-1) * Pilot_L + 1 : k * Pilot_L) ./ H_est);
        end
        
        % Compute Symbol Error rate
        SER_SNR(end + 1) = SER_func(Y, data, 1, Mod_type);
    end
    SER_f = [SER_f; SER_SNR];
end

% Return
if Monte ~= 1
    Err = mean(SER_f);
else
    Err = SER_f;
end