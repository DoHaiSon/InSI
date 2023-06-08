function [SNR, Err] = B_CR_Unbiased(Op, Monte, SNR, Output_type)

%% Unbiased Cross-relations
%
%% Input:
    % + 1. num_sq: number of samples
    % + 2. L: number of channels
    % + 3. M: Channel order
    % + 4. Ch_type: Type of the channel (real, complex, specular,
    % user's input)
    % + 5. Mod_type: Type of modulation (All)
    % + 6. Monte: Simulation times
    % + 7. SNR: Range of the SNR
    % + 8. Ouput_type: MSE Channel
%
%% Output:
    % + 1. SNR: Range of the SNR
    % + 2. Err: MSE Channel
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Generate input signal
    %     X <= h^T * s + n
    % Step 3: 
    % Step 4: CR algorithm
    % Step 5: Compute MSE Channel
    % Step 6: Return 
%
% Ref: 
%
%% Require R2006A

% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 08-Jun-2023 16:13:00.

num_sq    = Op{1};     % number of sig sequences
L         = Op{2};     % number of the sensors
M         = Op{3};     % length of the channel 
Ch_type   = Op{4};     % complex
Mod_type  = Op{5};     

Monte     = Monte;
SNR       = SNR;       % Signal to noise ratio (dB)
Output_type = Output_type;

% Generate input signal
modulation = {'Bin', 'QPSK', 'QAM4', 'QAM16', 'QAM64', 'QAM128', 'QAM256'};

res_b     = [];
for monte = 1:Monte
%     fprintf('------------------------------------------------------------\nExperience No %d \n', monte); 

    %% Generate channel
    H         = Generate_channel(L, M, Ch_type);
    H         = H / norm(H, 'fro');
    
    %% Generate signals
    [sig, data] = eval(strcat(modulation{Mod_type}, '(num_sq + M)'));
    
    % Signal rec
    sig_rec_noiseless = [];
    for l = 1:L
        sig_rec_noiseless(:, l) = conv( H(l,:).', sig ) ;
    end
    sig_rec_noiseless = sig_rec_noiseless(M+1:num_sq + M, :);

    err_b = [];
    for snr_i = SNR
%         fprintf('Working at SNR: %d dB\n', snr_i);
        sig_rec = awgn(sig_rec_noiseless, snr_i);

        %% Algorithm CR unbiased
        [T,q]   = size(sig_rec);
        % Calcul de la forme quadratique Q
        Q       = cal_YUMCR(sig_rec, M);

        [u,s,v] = svd(Q);
        h1      = u(:, q*(M+1));  %% for Y2
        h       = h1 * exp(-1i*angle(h1(1)));
        h_est   = h  / norm(h,'fro');

        % Compute MSE Channel
        ER_SNR  = ER_func(H, h_est, Mod_type, Output_type);

        err_b   = [err_b, ER_SNR];
    end
    
    res_b   = [res_b;  err_b];
end

% Return
if Monte ~= 1
    Err = mean(res_b);
else
    Err = res_b;
end