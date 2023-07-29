function Err = B_TSML(Op, SNR_i, Output_type)

%% Two-step Maximum Likelihood
%
%% Input:
    % + 1. num_sq: number of samples
    % + 2. L: number of channels
    % + 3. M: Channel order
    % + 4. Ch_type: Type of the channel (real, complex,
    % user's input)
    % + 5. Mod_type: Type of modulation (All)
    % + 6. SNR_i: signal noise ratio
    % + 7. Output_type: MSE Channel
%
%% Output:
    % + 1. Err: MSE Channel
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Generate input signal
    %     X <= h^T * s + n
    % Step 3: 
    % Step 4: TSML algorithm
    % Step 5: Compute MSE Channel
    % Step 6: Return 
%
% Ref: Yingbo Hua, "Fast maximum likelihood for blind 
% identification of multiple FIR channels," in IEEE Transactions
% on Signal Processing, vol. 44, no. 3, pp. 661-672, Mar. 1996.
%
%% Require R2006A

% Author: Yingbo Hua

% Adapted for InSI by Do Hai Son, 29-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless communication systems
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


num_sq    = Op{1};     % number of sig sequences
L         = Op{2};     % number of the sensors
M         = Op{3};     % length of the channel 
Ch_type   = Op{4};     % complex
Mod_type  = Op{5};     


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

%% Algorithm TSML
mu      = 0;

[Q,Y]   = cal_Y(sig_rec, M);
[u,v]   = eig(Q);
[k,ord] = sort(diag(v));
h       = u(:,ord(1));
h       = h*exp(-1i*angle(h(1)));
est_can0=h;

x       = zeros(M+1,L);
x(:)    = est_can0;
can0    = x.';
G       = calcG(can0,num_sq);
I       = eye(length(G(:,1)));
W       = pinv(G*G'+mu*I);
Q       = cal_Q(sig_rec,M,W,num_sq);

[u,v]   = eig(Q);
[k,ord] = sort(diag(v));
h       = u(:,ord(1));
fcan    = H(:);
h       = h*h'*fcan;
h_est   = h*exp(-1i*angle(h(1)));

% Compute MSE Channel
Err     = ER_func(H, h_est, Mod_type, Output_type);

end