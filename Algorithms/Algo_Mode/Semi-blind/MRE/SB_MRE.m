function [SNR, Err] = SB_MRE(Op, Monte, SNR, Output_type)

%% SEMI-BLIND CHANNEL ESTIMATION USING MRE ALGORITHM
%
%% Ref: 
%
%% Input:
    % + 1. num_sq: number of sample data
    % + 2. Nt: number of transmit antennas
    % + 3. Nr: number of receive antennas
    % + 4. ChL: length of the channel
    % + 5. Ch_type: type of the channel (real, complex, specular, user' input
    % + 6. Mod_type: type of modulation (Bin, QPSK, 4-QAM)
    % + 7. N: window size
    % + 8. N_p: number of pilot symbols
    % + 9. lambda: Ratio between SB and B-MRE 
    % + 10. Monte: simulation times
    % + 11. SNR: range of the SNR
    % + 12. Ouput_type: MSE Sig, MSE Ch, Error rate
%
%% Output:
    % + SNR: range of the SNR
    % + SER: Symbol error rate
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Return 
%
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 15-May-2023 16:52:13 


% Initialize variables
num_sq    = Op{1};     % number of sig sequences
Nt        = Op{2};     % number of transmit antennas
Nr        = Op{3};     % number of receive antennas
M         = Op{4};     % length of the channel
Ch_type   = Op{5};     % complex
Mod_type  = Op{6};     
N         = Op{7};     % number of measurements
N_p       = Op{8};     % Number of pilot symbols (N_p >= N)
lambda    = Op{9};     % Ratio between pilot and blind parts
K         = M + N;     % rank of H
Monte     = Monte;
SNR       = SNR;       % Signal to noise ratio (dB)
Output_type = Output_type;

% Generate input signal
modulation = {'Bin', 'QPSK', 'QAM4', 'QAM16', 'QAM64', 'QAM128', 'QAM256'};

ER_f      = [];
for monte = 1:Monte
    %% Generate channel
    for tx = 1:Nt
        H(tx, :, :)         = Generate_channel(Nr, M, Ch_type);
    end 

    %% Generate signals
    for tx = 1:Nt
        [sig_src(tx,:), data(tx,:)] = eval(strcat(modulation{Mod_type}, '(num_sq + M)'));
    end

    % Signal rec
    sig_rec = zeros(num_sq + 2*M, Nr);
    for tx = 1:Nt
        y = [];
        for rx = 1:Nr
            y(:, rx) = conv( squeeze(H(tx, rx, :)).', sig_src(tx, :) ) ;
        end
        sig_rec = sig_rec + y;
    end

    sig_rec = sig_rec(M+1:num_sq + M, :);                               % samp_size x Nr

    ER_SNR = [];
    for snr_i = SNR
        sig_rec_i = awgn(sig_rec, snr_i);
        
        %% MRE
        X       = [];
        for ii  = 1:Nr
          x     = sig_rec_i(:, ii);
          mat   = hankel(x(1:N), x(N:num_sq));
          mat   = mat(N:-1:1, :);
          X     = [X; mat];
        end
        
        %% ----------------------------------------------------------------
        %% Blind MRE program
        X_n     = X(:, 1:num_sq-N);
        X_n_1   = X(:, 2:num_sq-N+1);
        A       = kron([eye((K-1)*Nt), zeros((K-1)*Nt, Nt)], X_n') - ...
            kron([zeros((K-1)*Nt, Nt), eye((K-1)*Nt)], X_n_1');
        Q       = A' * A;                                                   % N_rN KN_t x NrN KN_t

        %% Son's Semi-Blind program 
        X_SB    = X(:, 1:N_p - N + 1);                                      % N_tN x (N_p - N + 1)
        S_SB    = [];                                                       % N_tK x (N_p - N + 1)
        for i   = N:N_p                                                     % S = [S_{1}(N-1), ..., S_{1}(N_p-1); S_{N_t}(N-1), ..., S_{N_t}(N_p-1)]
            S_k = sig_src(:, i+M:-1:i+M-K+1);
            S_SB= [S_SB, S_k(:)];
        end
    
        %% J(G)                         
        A       = kron(eye(K*Nt), X_SB');                                   % KN_t(N_p - N + 1) x KN_tN_rN
        s_bar   = S_SB';                                          
        s_bar   = s_bar(:);                                                 % KN_t(N_p - N + 1) x 1
        
        g       = inv(A' * A + lambda * Q) * A' * s_bar;                    % KN_rNN_t x 1
        
        % Reshape G
        G       = reshape(g, [Nr*N, Nt, K]);                                % N_rN x N_t x K

        % Select the delay-th Equalizer
        delay       = round(K/2);

        % Equalization
        s_hat_sb    = G(:, :, delay)'    * X;

        s           = sig_src(:, K-delay+1:num_sq+M-delay+1);
        data_src    = data(:, K-delay+1:num_sq+M-delay+1);
        
        % Compute Error rate / MSE Signal
        ER_SNR_i = 0;
        for tx  = 1:Nt
            ER_SNR_i     = ER_SNR_i + ER_func(data_src(tx,:), s_hat_sb(tx, :), Mod_type, Output_type, s(tx, :));
        end

        ER_SNR(end+1)  = ER_SNR_i;
    end
    ER_f = [ER_f; ER_SNR];
end

% Return
if Monte ~= 1
    Err = mean(ER_f);
else
    Err = ER_f;
end

end