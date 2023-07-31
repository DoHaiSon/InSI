function Err = NB_Misspecified (Op, SNR_i, ~)

%% Misspecified Cramer–Rao bound
%
%% Input:
    % + 1. N_t: number of transmit antennas
    % + 2. N_r: number of receive antennas
    % + 3. L_tr: True Channel Order
    % + 4. L_pt: Misspecified Channel Order
    % + 5. K: Number of Unknown data Blocks
    % + 6. SNR_i: signal noise ratio
%
%% Output:
    % + 1. Err: CRB
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Return 
%
% Ref: L. T. Thanh, K. Abed-Meraim and N. L. Trung, "Misspecified
% Cramer–Rao Bounds for Blind Channel Estimation Under Channel
% Order Misspecification," IEEE Transactions on Signal Processing,
% vol. 69, pp. 5372-5385, 2021.
%
%% Require R2006A

% Author: Le Trung Thanh, Vietnam National University, Hanoi, Vietnam

% Adapted for InSI by Do Hai Son, 29-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless Communications
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


% Initialize variables
N_t  = Op{1};    % number of transmit antennas
N_r  = Op{2};    % number of receive antennas
L_tr = Op{3};    % True Channel Order
L_pt = Op{4};    % Misspecified Channel Order
K    = Op{5};    % Number of Unknown data blocks
N    = 30;
SIGMA = 10^(-(SNR_i / 10));

%% Generate system 
[H_matrix,h,y_p,X_matrix] = Generate_System(L_tr,N_r,N_t,N,K);

MCRB = zeros(1,length(SIGMA));

h     = H_matrix(:);
L_h   = L_tr * N_r * N_t;
L_hpt = L_pt * N_r * N_t;

CP        = X_matrix(:, end-L_tr+1 : end);
X_Block   = [CP X_matrix];
X_p = [];
for n = L_tr+1 : L_tr+N
    x_hat_n = [] ;
    for ii  = L_tr-1 : -1 : 0
        x_hat_n = [x_hat_n; X_Block(:,n-ii)];
    end
    X_p = [X_p x_hat_n];
end
XXX_P = kron(transpose(X_p), eye(N_r));

% tilde
CP_tilde            = X_matrix(:,end-L_pt+1 : end);
X_Plot_Block_tilde  = [CP_tilde, X_matrix];

X_P_tilde = [];
for n = L_pt+1 : L_pt+N
    x_hat_n = [] ;
    for ii = L_pt-1 : -1 : 0
        x_hat_n = [x_hat_n; X_Plot_Block_tilde(:,n-ii)];
    end
    X_P_tilde   = [X_P_tilde x_hat_n];
end
XXX_P_tilde     = kron(transpose(X_P_tilde),eye(N_r));


h_pt      = pinv(XXX_P_tilde) * XXX_P * h;
e_p       = XXX_P * h - XXX_P_tilde * h_pt;
e_norm    = norm(e_p); 

        
sigma_k     = SIGMA;
sigma_pt_k  = sigma_k + e_norm^2/(N_r*N);

E_P        = e_p * e_p' +  sigma_k*eye(length(e_p));
Jp_hh      = XXX_P_tilde' * E_P * XXX_P_tilde;
Jp_hchc    = conj(Jp_hh);
Jp_hhc     = XXX_P_tilde' * (e_p * transpose(e_p)) * conj(XXX_P_tilde);
Jp_hch     = Jp_hhc';

FIM_P      = [Jp_hh , Jp_hhc;
              Jp_hch, Jp_hchc];
J_last_col = zeros(size(FIM_P,1),1);
J_OP       = 1/sigma_pt_k^2 * [FIM_P      , J_last_col;
                               J_last_col', N_r*N      ];
NN         = [0, 0; 0, N_r*N];
J_P        = 1/sigma_pt_k^2 * [FIM_P, zeros(2*L_hpt,2);
                               zeros(2,2*L_hpt), NN];

Ap_hh      = XXX_P_tilde' * XXX_P_tilde;
ap         = XXX_P_tilde' * e_p;
FIM_A      = [Ap_hh, zeros(size(Ap_hh));
              zeros(size(Ap_hh)) , conj(Ap_hh)];

A_last_col = [ap;  conj(ap)];
A_OP       = -1/sigma_pt_k *  [FIM_A        , A_last_col;
                               A_last_col' , N_r*N/sigma_pt_k];

A_P        = -1/sigma_pt_k * [FIM_A, zeros(2*L_hpt,1), A_last_col;
                              zeros(1,2*L_hpt+2);
                              A_last_col', 0,  N_r*N/sigma_pt_k];

GMCRB      = pinv(A_OP) * J_OP * pinv(A_OP); 
Err        = abs(trace(GMCRB(1:L_hpt,1:L_hpt) )  );

end