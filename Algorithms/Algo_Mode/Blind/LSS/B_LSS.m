function Err = B_LSS(Op, SNR_i, Output_type)

%% Least Squares Smoothing
%
%% Input:
    % + 1. num_sq: number of samples
    % + 2. L: number of channels
    % + 3. M: Channel order
    % + 4. Ch_type: Type of the channel (real, complex, specular,
    % user's input)
    % + 5. Mod_type: Type of modulation (All)
    % + 6. SNR_i: signal noise ratio
    % + 7. Output_type: MSE Channel
%
%% Output:
    % + 1. Err: Error rate
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Generate input signal
    %     X <= h^T * s + n
    % Step 3: 
    % Step 4: LSS algorithm
    % Step 5: Compute MSE Channel
    % Step 6: Return 
%
% Ref: Lang Tong and Qing Zhao, "Joint order detection and blind 
% channel estimation by least squares smoothing," in IEEE
% Transactions on Signal Processing, vol. 47, no. 9,
% pp. 2345-2355, Sept. 1999.
%
%% Require R2006A

% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 10-Jul-2023 10:05:00.


num_sq    = Op{1};     % number of sig sequences
L         = Op{2};     % number of the sensors
M         = Op{3};     % length of the channel 
Ch_type   = Op{4};     % complex
Mod_type  = Op{5};     
N         = M;         % Window length


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

%% Algorithm LSS
d       = M;
% Formation de la Matrice Y Zd (Zdp,Zdf)
Y       = [];
Zdf     = [];
Zdp     = [];
cs      = 2*d+3*N-2;
for ii  = d+2*N-1:-1:d+N-1
    x1  = sig_rec(ii:num_sq+ii-cs,:);
    x1  = x1.';
    Y   = [Y;x1];
end

for ii  = cs:-1:d+2*N
    x2  = sig_rec(ii:num_sq+ii-cs,:);
    x2  = x2.';
    Zdf = [Zdf;x2];
end

for ii  = 2*N-2:-1:1
    x3  = sig_rec(ii:num_sq+ii-cs,:);
    x3  = x3.';
    Zdp = [Zdp;x3];
end

Zd      = [Zdf; Zdp];
[Q1,Q2,Qt] = svd(Zd);
Q       = Qt(:,1:3*N+2*M+d-3);

Ed      = Y-(Y*Q*Q');
[Ue,Q3,Q4] = svd(Ed);
h_est   = Ue(:,1);

h       = reshape(h_est,L,M+1);
h       = h(:,M+1:-1:1);
h       = h.';
h_est_1 = h(:);

% Compute MSE Channel
Err     = ER_func(H, h_est_1, Mod_type, Output_type);

end