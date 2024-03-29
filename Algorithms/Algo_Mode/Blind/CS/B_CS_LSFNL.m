function Err = B_CS_LSFNL(Op, SNR_i, Output_type)

%% LSFNL Channel Subspace
%
%% Input:
    % + 1. num_sq: number of samples
    % + 2. L: number of channels
    % + 3. M: Channel order
    % + 4. Ch_type: Type of the channel (real, complex,
    % user's input)
    % + 5. Mod_type: Type of modulation (All)
    % + 6. N: Window length
    % + 7. SNR_i: signal noise ratio
    % + 8. Output_type: MSE Channel
%
%% Output:
    % + 1. Err: MSE Channel
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Generate input signal
    %     X <= h^T * s + n
    % Step 3: 
    % Step 4: CS algorithm
    % Step 5: Compute MSE Channel
    % Step 6: Return 
%
% Ref: 
%
%% Require R2006A

% Author: 

% Adapted for InSI by Do Hai Son, 29-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless Communications
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


num_sq    = Op{1};     % number of sig sequences
L         = Op{2};     % number of the sensors
M         = Op{3};     % length of the channel 
Ch_type   = Op{4};     % complex
Mod_type  = Op{5};     
N         = Op{6};     % Window length


% Generate input signal
modulation = {'Bin', 'QPSK', 'QAM4', 'QAM16', 'QAM64', 'QAM128', 'QAM256'};
[sig, data] = eval(strcat(modulation{Mod_type}, '(num_sq + M)'));

% Generate channel
H         = Generate_channel(L, M, Ch_type);
H         = H / norm(H, 'fro');   

% Signal rec
sig_rec_noiseless = [];
for l = 1:L
    sig_rec_noiseless(:, l) = conv( H(l,:).', sig ) ;
end
sig_rec_noiseless = sig_rec_noiseless(M+1:num_sq + M, :);

sig_rec = awgn(sig_rec_noiseless, SNR_i);

%% Algorithm CS
M_1     = M+1;
M_est   = M_1; 		            % over-estimated channel length
T0      = N+M_est;
L_1     = M_est - M_1 + 2;	    % L derniers vecteurs propres
delay   = 0;                    % Delay in order to obtain better perf
IT_nb   = 2;

%::::: estimation des statistiques
[R_est X_N] = EstimateCov_modif(sig_rec,num_sq,L,N);
[U_est Sigma V_est] = svd(R_est);
R_est_inv = U_est*pinv(Sigma)*U_est';
U_n     = U_est(:,M_est+N+1:L*N);

%::: calcul de w0
U_s     = U_est(:,1:M_est+N);
tmp     = U_s*Sigma(1:N+M_est,1:N+M_est);
U1      = tmp(L*(delay+1)+1:end,:);
Q1      = U1'*U1;
[u_q1,s_q1,v_q1] = svd(Q1);
w_tild  = u_q1(:,end);
%::: fin de calcul de w0

noise_proj = U_n * U_n';
D       = zeros(L*N*(M_est+N),L*(M_est+N));
for i = 0: N-1
    block = noise_proj(:,i*L+1:(i+1)*L);
    D   = kron(diag(ones(N+M_est-i,1),-i),block) + D;
end
D_fin   = D(:,1:L*M_est);
[U, Sigma_1, V] = svd(D_fin'*D_fin);

%::: constituer U_L en block
U_L     = U(:,L*M_est-L_1+1:L*M_est);
U_block = [];
for i = 1:M_est
    U_res = U_L((i-1)*L+1:i*L,1:L_1);
    U_block = [U_block U_res];
end
tmp     = sig_rec(T0-1:-1:T0-N,:);
tmp     = tmp.';
X_n     = tmp(:);
X_bar_N = X_n;
for ii  = 1:M_est-1
    tmp = sig_rec(T0-1-ii:-1:T0-N-ii,:);
    tmp = tmp.';
    X_bar_N = [X_bar_N, tmp(:)];
end
xn_Obs  = [];
X_bar_N_Obs = [];
for obs_nb = T0:num_sq
    X_n = [sig_rec(obs_nb,:).'; X_n(1:L*(N-1),1)];
    X_bar_N = [X_n X_bar_N(:,1:M_est-1)];
    X_bar_N_Obs = [X_bar_N_Obs ; X_bar_N.'];
    xn  = sig_rec(obs_nb-delay,:).';
    xn_Obs = [xn_Obs ; xn ];
end     %end of Obs_nb

%::: calcul de v0
Y_n_block = X_bar_N_Obs*U_s*w_tild;
Q_n_Obs = [];
for ii  = 1:num_sq-T0+1
    Q_n = 0;
    Y_n = Y_n_block((ii-1)*M_est+1:ii*M_est,:) ;
    for i = 1:M_est
        Q_i = U_L((i-1)*L+1:i*L,1:L_1)*Y_n(i);
        Q_n = Q_n + Q_i;
    end %end of i pour choisir le U_i

    Q_n_Obs = [Q_n_Obs;Q_n];
end
v       = pinv(Q_n_Obs)*xn_Obs;
%::: end de calcul de v0 pour delay=0

%::: calcul de A_obs
h_est   = U_block*kron(eye(M_est,M_est),v);
A_Obs   = [];
for ii = 1:num_sq-T0+1
    A_N_Obs = h_est*X_bar_N_Obs((ii-1)*M_est+1:ii*M_est,:)*U_s;
    A_Obs = [A_Obs; A_N_Obs];
end

%::: calcul de xn_Obs avec delay considere.
delay   = M_est-1;%M_est-1; %M_est; %M-1;%       %nouveau valeur de delay
xn_Obs_1= [];
for obs_nb = T0:num_sq
    xn_1 = sig_rec(obs_nb-delay,:).';
    xn_Obs_1 = [xn_Obs_1 ; xn_1 ];
end     %end of Obs_nb

%:::: algorithm newton
for it_nb   = 1:IT_nb
    grad_w  = -2* A_Obs.'* (xn_Obs_1-A_Obs*w_tild);
    grad_v  = -2*Q_n_Obs.'*(xn_Obs_1- Q_n_Obs*v);
    hess_w  = 2*A_Obs.'*A_Obs;
    hess_v  = 2*Q_n_Obs.'*Q_n_Obs;
    mu_v    = 0.9;
    mu_w    = 0.9;
    v       = v - mu_v*pinv(hess_v)*grad_v;
    w_tild  = w_tild  - mu_w*pinv(hess_w)*grad_w;
    cout_w(it_nb) = (xn_Obs_1-A_Obs*w_tild)'*(xn_Obs_1-A_Obs*w_tild);
    cout_v(it_nb) = (xn_Obs_1- Q_n_Obs*v)'*(xn_Obs_1- Q_n_Obs*v);
    Y_n_block = X_bar_N_Obs*U_s*w_tild;
    Q_n_Obs = [];
    for ii  = 1:num_sq-T0+1
        Q_n = 0;
        Y_n = Y_n_block((ii-1)*M_est+1:ii*M_est,:) ;
        for i = 1:M_est
            Q_i = U_L((i-1)*L+1:i*L,1:L_1)*Y_n(i);
            Q_n = Q_n + Q_i;
        end %end of i pour choisir le U_i
        Q_n_Obs = [Q_n_Obs;Q_n];

    end  % end pour choisir block Y
    h_est = U_block*kron(eye(M_est,M_est),v);
end

h_est   = h_est.';
h_est   = h_est(:);

% Compute MSE Channel
Err     = ER_func(H, h_est, Mod_type, Output_type);

end