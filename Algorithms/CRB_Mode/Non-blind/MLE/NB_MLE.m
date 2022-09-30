function [SNR, Err] = NB_MLE (Op, Monte, SNR)

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
[H_matrix,h,y_p,X_Matrix_Pilot] = Generate_System(L_tr,N_r,N_t,N,K);

CP        = X_Matrix_Pilot(:, end-L_pt+1 : end);
X_Block   = [CP X_Matrix_Pilot];

X_p = [];
for n = L_pt+1 : L_pt+N
    x_hat_n = [] ;
    for ii  = L_pt-1 : -1 : 0
        x_hat_n = [x_hat_n; X_Block(:,n-ii)];
    end
    X_p = [X_p x_hat_n];
end
XXX_p = kron(transpose(X_p), eye(N_r));


MSE = zeros(1,length(SIGMA));
for k = 1 : length(SIGMA)
    sigma_k = SIGMA(k);
    y_n     = y_p + sigma_k * randn(length(y_p),1);
    h_pt    = pinv(XXX_p) * y_p;
    h_MLE   = pinv(XXX_p) * y_n;
 
    MSE(k)  = norm(h_MLE - h_pt);
end

Err = MSE;

end