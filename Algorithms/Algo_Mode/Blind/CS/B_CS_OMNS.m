function Err = B_CS_OMNS(Op, SNR_i, Output_type)

%% OMNS Channel Subspace
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

%% Algorithm CS OMNS
tmp     = H.';
can     = tmp(:);
can     = can*exp(-1i*angle(can(1)));

p       = 1;
tmp     = p*M;
N       = [];
step    = 1;

while ((step)>=1 && step<=(L-p))
    N_new = ceil((tmp+1)/(L-(p+step-1)));  % ... A deteminer la taille de Taux
    tmp = N_new + tmp - 1;
    N   = [N N_new];

    if step == 1
        R = EstimateCov(sig_rec,num_sq,L,N_new);
        [a, sigma, b] = svd(R);
        %clear R;
        Mat_ins = b(:,L*N);
        %clear a sigma b;
        step    = step + 1;
    else
        %...Calcule de taille de Matrice a inserer
        vv      = reshape(Mat_ins,N(step-1),L*(step-1));
        vvv     = [vv; zeros(N_new-N(step-1),L*(step-1))];
        vvvv    = reshape(vvv,L*N_new,(step-1));

        [Taux_N, Taux_N_v] = calcH_tst(H,p,vvvv,N);
        %... test
        R = EstimateCov(sig_rec, num_sq, L, N_new) + Taux_N_v*Taux_N_v';
        [a, sigma, b] = svd(R);
        clear R;
        Mat_ins = b(:,L*N_new);
        %clear a sigma b;
        Mat_ins = [vvvv Mat_ins];
    	step    = step + 1;
    end		%end of step
end			%end of while

%----------------------------------------------------
%... calcul des produits < vec bruit | mat base >
%
last_N  = length(N);
A       = Mat_ins';
% ... Forme quadratidue
D_fin   = [];
for index_out = 1:L
    D   = zeros((L-p)*(M+N(last_N)),(M+N(last_N)));
    for index = 1: N(last_N)
        block = A(:, ((index_out-1)*N(last_N))+index);
        D = kron(diag(ones(N(last_N)+M+1-index,1),-index+1),block) + D;
    end 	%end of index

    D_tmp = D(:,1:(M+1));
    D_fin = [D_fin D_tmp];
end	%end of index out

[U, Sigma, V] = svd(D_fin' * D_fin);

%... ranger des valeurs
%... pour p = 1
est_can_tmp = reshape(U(:,L*(M+1)),M+1,L);
est_can_1   = est_can_tmp;
est_can     = est_can_1(:);
% to get rid from the constante matrix
%

h_est   = est_can * pinv(est_can) * can;

% Compute MSE Channel
Err     = ER_func(H, h_est, Mod_type, Output_type);

end