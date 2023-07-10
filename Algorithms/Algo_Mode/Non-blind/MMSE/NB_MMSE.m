function Err = NB_MMSE(Op, SNR_i, Output_type)

%% Minimum Mean Square Error
%
%% Input:
    % + 1. num_sq: number of sample data
    % + 2. Nt: number of transmit antennas
    % + 3. Nr: number of receive antennas
    % + 4. ChL: length of the channel
    % + 5. Ch_type: type of the channel (real, complex, specular,
    % user's input
    % + 6. Mod_type: type of modulation (All)
    % + 7. SNR_i: signal noise ratio
    % + 8. Output_type: SER / BER / MSE Signal
%
%% Output:
    % 1. Err: SER / BER / MSE Signal
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Generate input signal
    %     X <= h^T * s + n
    % Step 3: Estimate channel
    %     H_est <= Y_pilot ./ X_pilot
    % Step 4: Equalization
    %     X <= Y ./ H_est
    % Step 5: Compute Compute Error rate
    %     Demodulate Y
    %     Compute SER / BER / MSE Signal
    % Step 6: Return 
%
% Ref: https://www.sharetechnote.com/html/Communication_ChannelModel_ZF.html

% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 08-Jun-2023 18:00:13 


% Initialize variables
num_sq    = Op{1};     % number of sig sequences
Nt        = Op{2};     % number of transmit antennas
Nr        = Op{3};     % number of receive antennas
M         = Op{4};     % length of the channel
Ch_type   = Op{5};     % complex
Mod_type  = Op{6};     


% Generate input signal
modulation = {'Bin', 'QPSK', 'QAM4', 'QAM16', 'QAM64', 'QAM128', 'QAM256'};

% Generate channel
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

% Generate signals
for tx = 1:Nt
    [sig_src(tx,:), data(tx,:)] = eval(strcat(modulation{Mod_type}, '(num_sq + M)'));
end
    
S_shape= Nt * (num_sq + M);
X_mmse = H_toep * reshape(sig_src, [S_shape, 1]);

    
X_mmse_i = awgn(X_mmse, SNR_i);

% Equalization
eye_shape = size(H_toep);

s_hat   = pinv(H_toep' * H_toep + (10^(-SNR_i/10) * eye(eye_shape(2)))) * H_toep' * X_mmse_i;
s_hat   = reshape(s_hat, [Nt, num_sq + M]);

% Compute Error rate / MSE Signal
ER_SNR_i = 0;
for i = 1:Nt
    ER_SNR_i = ER_SNR_i + ER_func(data(tx,:), s_hat(tx, :), Mod_type, Output_type, sig_src(tx, :));
end

% Return
Err = ER_SNR_i;

end