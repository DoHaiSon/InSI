function Err = SB_MRE_rc(Op, SNR_i, Output_type)

%% Semi-Blind Mutually Referenced Filters reduce cost
%
%% Input:
    % + 1. num_sq: number of sample data
    % + 2. Nt: number of transmit antennas
    % + 3. Nr: number of receive antennas
    % + 4. ChL: length of the channel
    % + 5. Ch_type: type of the channel (real, complex, specular,
    % user' input
    % + 6. Mod_type: type of modulation (All)
    % + 7. N: window size
    % + 8. N_p: number of pilot symbols
    % + 9. lambda: Ratio between SB and B-MRE 
    % + 10. SNR_i: signal noise ratio
    % + 11. Output_type: SER / BER / MSE Signal
%
%% Output:
    % + 1. Err: SER / BER / MSE Signal
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Return 
%
% Ref: Do Hai Son, Karim Abed-Meraim, Tran Trong Duy, Nguyen Linh
% Trung, and Tran Thi Thuy Quynh, "On the Semi-Blind Mutually 
% Referenced Equalizers for MIMO Systems," in 2023 Asia Pacific
% Signal and Information Processing Association Annual Summit and
% Conference (APSIPA ASC), Nov. 2023.
%
%% Require R2006A

% Author: Do Hai Son, Vietnam National University, Hanoi, Vietnam

% Adapted for InSI by Do Hai Son, 29-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless Communications
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


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


% Generate input signal
modulation = {'Bin', 'QPSK', 'QAM4', 'QAM16', 'QAM64', 'QAM128', 'QAM256'};

% Generate channel
for tx = 1:Nt
    H(tx, :, :) = Generate_channel(Nr, M, Ch_type);
end 

% Generate signals
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

sig_rec = sig_rec(M+1:num_sq + M, :);                               % num_sq x Nr

sig_rec_i = awgn(sig_rec, SNR_i);

%% MRE
X       = [];
for ii  = 1:Nr
  x     = sig_rec_i(:, ii);
  mat   = hankel(x(1:N), x(N:num_sq));
  mat   = mat(N:-1:1, :);
  X     = [X; mat];
end

%% ----------------------------------------------------------------
%% Blind MRE program: 2 filters
X_n     = X(:, 1: num_sq - N - K + 2);
X_n_k   = X(:, K: num_sq - N + 1);
A_rc    = kron([eye(Nt), zeros(Nt, Nt)], X_n') - ...
    kron([zeros(Nt, Nt), eye(Nt)], X_n_k');
Q_rc    = A_rc' * A_rc; 

%% Son's Semi-Blind program 
X_SB    = X(:, 1:N_p - N + 1);                                      % N_tN x (N_p - N + 1)
S_rc    = [];                                                       % N_tP x (N_p - N + 1)
for i   = N:N_p                                                     % S = [S_{1}(N-1), ..., S_{1}(N_p-1); S_{N_t}(N-1), ..., S_{N_t}(N_p-1)]
    S_rc_k = [sig_src(:, i+M) sig_src(:, i+M-K+1)];
    S_rc   = [S_rc, S_rc_k(:)];
end

%% J(G_rc)
A       = kron(eye(2*Nt), X_SB');                         % 2N_t(N_p - N + 1) x 2N_tN_rN
s_bar   = S_rc';                                          
s_bar   = s_bar(:);                                       % 2N_t(N_p - N + 1) x 1
g_rc    = pinv(A' * A + lambda * Q_rc) * A' * s_bar;      % 2N_rNN_t x 1

% Reshape G
G_rc    = reshape(g_rc, [Nr*N, Nt, 2]);                   % N_rN x N_t x 2

% Select the delay-th Equalizer
delay_rc    = 2;
idelay      = delay_rc * (K - 1) - K + 2;   % 0 or (K-1)-th delay

% Equalization
s_hat_sb_rc = G_rc(:, :, delay_rc)' * X;

s_rc        = sig_src(:, K-idelay+1:num_sq+M-idelay+1);
data_src    = data(:, K-idelay+1:num_sq+M-idelay+1);

% Compute Error rate / MSE Signal
ER_SNR_i = 0;
for tx  = 1:Nt
    ER_SNR_i     = ER_SNR_i + ER_func(data_src(tx,:), s_hat_sb_rc(tx, :), Mod_type, Output_type, s_rc(tx, :));
end

% Return
Err = ER_SNR_i;

end