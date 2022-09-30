function [SNR, Err] = NB_Misspecified (Op, Monte, SNR)

% Initialize variables
N_t  = Op{1};    % number of transmit antennas
N_r  = Op{2};    % number of receive antennas
L_tr = Op{3};    % True Channel Order
L_pt = Op{4};    % Misspecified Channel Order
K    = Op{5};    % Number of Unknown data Blocks
N    = 30;

Monte   = Monte;
SNR     = SNR;

SIGMA  = 10.^(-(SNR / 10));

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


for k = 1 : length(SIGMA)
    
    sigma_k     = SIGMA(k);
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
    
    GMCRB    = pinv(A_OP) * J_OP * pinv(A_OP); 
    MCRB(k)  = abs(trace(GMCRB(1:L_hpt,1:L_hpt) )  );
end

Err = MCRB;

end