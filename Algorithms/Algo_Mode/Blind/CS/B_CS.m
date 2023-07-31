function Err = B_CS(Op, SNR_i, Output_type)

%% Channel Subspace
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
Nb        = N * L - (M + N + 1);


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
R       = EstimateCov(sig_rec, num_sq, L, N);

%
%... extraction des vecteurs propres bruit
%
[E, sigma] = exteigvnoise(R,Nb);
%alpha=sqrt(trace(R-sigma*eye(L*N))/N);
%
%... calcul des produits < vec bruit | mat base >
% 
BB      = zeros(Nb, L*(M+1)*(M+N));
icol    = 1:M+N;
for icap=1:L
    Ecap = E(N*(icap-1)+1:N*icap,:)';
    for jdec=1:M+1
        B = zeros(Nb,M+N);
        B(:,jdec:jdec+N-1) = Ecap;
        BB(:,icol) = B;
        icol = icol+M+N;
    end
end
Q       = zeros(L*(M+1),L*(M+1));

% Calculate quadratic form
B1      = zeros(Nb*(M+N),1);
B2      = zeros(Nb*(M+N),1);
for ii  = 1:L*(M+1)
   for jj=1:L*(M+1)
       icoli = (ii-1)*(M+N)+1:ii*(M+N);
       icolj = (jj-1)*(M+N)+1:jj*(M+N);
       B1(:) = BB(:,icoli);
       B2(:) = BB(:,icolj);
       Q(ii,jj) = B1'*B2;
   end
end

[u,v] = eig(Q);
[k,l] = sort(diag(v));
h_est = u(:,l(1));
h_est = h_est*exp(-1i*angle(h_est(1,1)));

% Compute MSE Channel
Err   = ER_func(H, h_est, Mod_type, Output_type);

end