function [SNR, Err] = SB_MLE (Op, Monte, SNR)

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

% CMA algorithm
Err_f = [];
for Monte_i = 1:Monte
    %% Generate system 
    [H_matrix,h,y_p,X_Matrix_Pilot] = Generate_System(L_tr,N_r,N_t,N,K);
    
    %% Pilot
    X_Matrix        =  randn(N_t,N*K) + 1i*randn(N_t,N*K);
    CP              = X_Matrix(:,end - L_tr + 1 : end);
    X_Plot_Block    = [CP X_Matrix];
    
    X = [];
    for n = L_tr + 1 : L_tr + N 
        x_hat_n = [] ;
        for ii = L_tr - 1 : -1 : 0
            x_hat_n = [x_hat_n; X_Plot_Block(:,n-ii)];
        end
        X = [X x_hat_n];
    end
    
    Y = H_matrix * X;
    
    
    X_tilde = [];
    for n = L_pt + 1 : L_pt + N 
        x_hat_n = [] ;
        for ii = L_pt - 1 : -1 : 0
            x_hat_n = [x_hat_n; X_Plot_Block(:,n-ii)];
        end
        X_tilde = [X_tilde x_hat_n];
    end
    
    
    
    
    MSE = zeros(1,length(SIGMA));
    
    for k = 1 : length(SIGMA)
        sigma_k = SIGMA(k);
        Y_n     = Y + sigma_k * randn(size(Y));
        H_pt    = Y * pinv(X_tilde) ;
        H_MLE   = Y_n * pinv(X_tilde);
     
        MSE(k)  = norm(H_MLE - H_pt);
    end

    Err_f = [Err_f; MSE];
end

% Return
if Monte ~= 1
    Err = mean(Err_f);
else
    Err = Err_f;
end

end