function [SNR, Err] = NB_ZF(Op, Monte, SNR, Output_type)

%% Zero forcing
%
%% Ref: https://www.sharetechnote.com/html/Communication_ChannelModel_ZF.html
%
%% Input:
    % + 1. num_sq: number of sample data
    % + 2. Nt: number of transmit antennas
    % + 3. Nr: number of receive antennas
    % + 4. ChL: length of the channel
    % + 5. Ch_type: type of the channel (real, complex, specular, user' input
    % + 6. Mod_type: type of modulation (Bin, QPSK, 4-QAM)
    % + 7. Monte: simulation times
    % + 8. SNR: range of the SNR
    % + 9. Ouput_type: MSE Sig, Error rate
%
%% Output:
    % 1. SNR: range of the SNR
    % 2. SER: Symbol error rate / MSE H_est
%
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
%% Last Modified by Son 15-May-2023 17:00:13 


% Initialize variables
num_sq    = Op{1};     % number of sig sequences
Nt        = Op{2};     % number of transmit antennas
Nr        = Op{3};     % number of receive antennas
M         = Op{4};     % length of the channel
Ch_type   = Op{5};     % complex
Mod_type  = Op{6};     
Monte     = Monte;
SNR       = SNR;
Output_type = Output_type;

% Generate input signal
modulation = {'Bin', 'QPSK', 'QAM4', 'QAM16', 'QAM64', 'QAM128', 'QAM256'};

% ZF algorithm
ER_f    = [];
for Monte_i = 1:Monte
    %% Generate channel
    % assumption i.i.d channels
    for tx = 1:Nt
        H(tx, :, :) = Generate_channel(Nr, M, Ch_type);
    end
    
    H_toep = [];
    for tx = 1:Nt
        h_toep = [];
        Ch = squeeze(H(tx, :, :));
        for rx = 1:Nr
            padding      = zeros(1, num_sq);
            padding(1,1) = Ch(rx, 1);
            h            = [Ch(rx, :), zeros(1, num_sq - 1)];
            h_toep       = [h_toep; toeplitz(padding, h)];
        end
        H_toep           = cat(2, H_toep, h_toep);
    end

    %% Generate signals
    for tx = 1:Nt
        [sig_src(tx,:), data(tx,:)] = eval(strcat(modulation{Mod_type}, '(num_sq + M)'));
    end
    
    S_shape= Nt * (num_sq + M);
    X_zf   = H_toep * reshape(sig_src, [S_shape, 1]);

    ER_SNR     = [];
    for snr_i  = SNR
        X_zf_i = awgn(X_zf, snr_i);
        
        % Equalization
        s_hat  = pinv(H_toep' *H_toep) * H_toep' * X_zf_i;
        s_hat  = reshape(s_hat, [Nt, num_sq + M]);
        
        % Compute Error rate / MSE Signal
        ER_SNR_i = 0;
        for i = 1:Nt
            ER_SNR_i = ER_SNR_i + ER_func(data(tx,:), s_hat(tx, :), Mod_type, Output_type, sig_src(tx, :));
        end
        ER_SNR(end + 1) = ER_SNR_i;
    end
    ER_f   = [ER_f; ER_SNR];
end

% Return
if Monte ~= 1
    Err = mean(ER_f);
else
    Err = ER_f;
end