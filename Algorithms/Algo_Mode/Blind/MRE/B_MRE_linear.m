function [SNR, Err] = B_MRE_linear(Op, Monte, SNR, Output_type)

%% Linear Mutually Referenced Filters
%
%% Input:
    % + 1. num_sq: number of samples
    % + 2. L: number of channels
    % + 3. M: Channel order
    % + 4. Ch_type: Type of the channel (real, complex, specular,
    % user's input)
    % + 5. Mod_type: Type of modulation (Bin, QPSK, 4-QAM)
    % + 6. N: Window size
    % + 7. Monte: Simulation times
    % + 8. SNR: Range of the SNR
    % + 9. Ouput_type: SER / BER / MSE Signal
%
%% Output:
    % + 1. SNR: Range of the SNR
    % + 2. Err: Error rate
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Generate input signal
    %     X <= h^T * s + n
    % Step 3:
    % Step 4: MRE algorithm
    % Step 5: Compute Error rate
    %     Demodulate Y
    %     Compute SER / BER / MSE Sig
    % Step 6: Return 
%
% Ref: D. Gesbert, P. Duhamel and S. Mayrargue, "On-line blind 
% multichannel equalization based on mutually referenced 
% filters," in IEEE Transactions on Signal Processing, vol. 45, 
% no. 9, pp. 2307-2317, Sept. 1997.
%
%% Require R2006A

% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 08-Jun-2023 17:00:00.

num_sq    = Op{1};     % number of sig sequences
L         = Op{2};     % number of the sensors
M         = Op{3};     % length of the channel
Ch_type   = Op{4};     % complex
Mod_type  = Op{5};     
N         = Op{6};     % number of measurements
K         = M + N;     % rank of H
Monte     = Monte;
SNR       = SNR;       % Signal to noise ratio (dB)
Output_type = Output_type;

% Generate input signal
modulation = {'Bin', 'QPSK', 'QAM4', 'QAM16', 'QAM64', 'QAM128', 'QAM256'};

res_b     = [];
for monte = 1:Monte
    err_b = [];

    %% Generate channel
    H         = Generate_channel(L, M, Ch_type);
    
    %% Generate signals
    [sig_src, data] = eval(strcat(modulation{Mod_type}, '(num_sq + M)'));
    
    % Signal rec
    sig_rec = [];
    for l = 1:L
        sig_rec(:, l) = conv( H(l,:).', sig_src ) ;
    end
    sig_rec = sig_rec(M+1:num_sq + M, :);

    for snr_i = SNR

        sig_rec_i = awgn(sig_rec, snr_i);

        %% MRE
        Vt      = zeros(K, L*N);
        X       = [];
        for ii  = 1:L
          x     = sig_rec_i(:, ii);
          mat   = hankel(x(1:N), x(N:num_sq));
          mat   = mat(N:-1:1, :);
          X     = [X; mat];
        end
        
        %% ----------------------------------------------------------------
        %% Batch Implementations
        % MRE error function: 
        R_0     = zeros(L*N, L*N);
        R_1     = zeros(L*N, L*N);
        for i   = 1:num_sq - N
            X_n     = X(:, i);
            X_n_1   = X(:, i+1);
            R_0     = R_0 + (X_n * X_n');
            R_1     = R_1 + (X_n_1 * X_n');
        end
        R_0 = R_0 ./ (num_sq - N);
        R_1 = R_1 ./ (num_sq - N);
    
        % Create R
        R = kron(diag(-1*ones(K-1,1), -1), R_1);
        R = R + R';
        b_diag = 2 * eye(K);
        b_diag(1,1) = 1;
        b_diag(K,K) = 1;
        R = R + kron(b_diag, R_0);
    
        %% C2-MRE method
        % V_opt
        U       = zeros(L*N*K, 1);
        U(1)    = 1;
        
        V       = (inv(R) * U) / (U' * inv(R) * U);
    
        % Reshape V
        V_b     = reshape(V, [L*N, K]);
        
        %% ----------------------------------------------------------------
        %% Select the Equalizer has min norm
        for ii  = 1:K
          x_b(ii)   = norm(V_b(:,ii));
        end
        [~, ind_b]  = min(x_b);
        
        % Equalization
        est_src_b   = conj(X' * V_b(:, ind_b));
        sig_src_b   = sig_src(K-ind_b+1:num_sq+M-ind_b+1);
        data_src    = data(K-ind_b+1:num_sq+M-ind_b+1);  

        % Compute Error rate / MSE Signal
        ER_SNR      = ER_func(data_src, est_src_b, Mod_type, Output_type, sig_src_b);

        err_b   = [err_b , ER_SNR];
    end
    
    res_b   = [res_b;  err_b];
end

% Return
if Monte ~= 1
    Err = mean(res_b);
else
    Err = res_b;
end