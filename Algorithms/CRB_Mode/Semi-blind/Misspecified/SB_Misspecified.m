function Err = SB_Misspecified (Op, SNR_i)

%% Semi-Blind Misspecified Cramer–Rao bound
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
% Order Misspecification," in IEEE Transactions on Signal
% Processing, vol. 69, pp. 5372-5385, 2021.

% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 10-Jul-2023 11:07:13 


% Initialize variables
N_t  = Op{1};    % number of transmit antennas
N_r  = Op{2};    % number of receive antennas
L_tr = Op{3};    % True Channel Order
L_pt = Op{4};    % Misspecified Channel Order
K    = Op{5};    % Number of Unknown data Blocks
N    = 30;
SIGMA  = 10^(-(SNR_i / 10));


%% Generate system 
[H_matrix,h,y_p,X_matrix] = Generate_System(L_tr,N_r,N_t,N,K);

h = H_matrix(:);
L_hpt = L_pt * N_r * N_t;

%% True
H_First_Row_Block   = cell(1,N); 
for ii = 1:N
    H_First_Row_Block{1,ii} = zeros(N_r,N_t);
end
H_First_Row_Block{1,1} = H_matrix(:,end-N_t+1:end); %H0
for ll = 1 : L_tr - 1
    H_First_Row_Block{1, N - L_tr + ll + 1} = H_matrix(:,N_t*(ll-1)+1:N_t*ll);
end

% Construsting H_Toeplipz
H_cell = zeros(N_r,N_t,N);
for ii = 1:N
    H_cell(:,:,ii) = H_First_Row_Block{1,ii};
end
ind_outer     = repelem(mod(bsxfun(@minus, 0:N-1, (0:N-1).'), N), N_r, N_t);
ind_inner     = repmat(reshape(1:N_r*N_t, N_r, N_t), N, N);
ind_toeplipz  = ind_outer*N_r*N_t + ind_inner;
H_Toeplipz    = H_cell(ind_toeplipz);    % for 1 block

%% Generate Unknown Data X (w.r.t columns)
%% Known Pilot Block
X_MatriX_Pilot  = X_matrix; 
CP              = X_MatriX_Pilot(:,end - L_tr + 1 : end);
X_Plot_Block    = [CP X_MatriX_Pilot];

X_P = [];
% removing CP
for n = L_tr + 1 : L_tr + N 
    x_hat_n = [] ;
    for ii = L_tr - 1 : -1 : 0
        x_hat_n = [x_hat_n; X_Plot_Block(:,n-ii)];
    end
    X_P = [X_P x_hat_n];
end
XXX_P = kron(transpose(X_P), eye(N_r));

% MCRB
%% X_P_tilde
CP_tilde            = X_MatriX_Pilot(:,end-L_pt+1 : end);
X_Plot_Block_tilde  = [CP_tilde, X_MatriX_Pilot];

X_P_tilde = [];
for n = L_pt + 1 : L_pt + N
    x_hat_n = [] ;
    for ii = L_pt - 1 : -1 : 0
        x_hat_n = [x_hat_n; X_Plot_Block_tilde(:,n-ii)];
    end
    X_P_tilde   = [X_P_tilde x_hat_n];
end
XXX_P_tilde     = kron(transpose(X_P_tilde),eye(N_r));

%% Pseudotrue Parameters

%h_pt = pinv(XXX_P_tilde) * XXX_P * h;

if L_pt > L_tr
    h_pt = zeros(L_pt*N_t*N_r,1);
    h_pt(1:L_tr*N_t*N_r) = h;
else
    h_pt = h(1:L_pt*N_t*N_r);
end
e_p       = XXX_P * h - XXX_P_tilde * h_pt;
e_norm    = norm(e_p); 

% H_Toeplipz_tilde
H_matrix_tilde = [];
for ii = 1 : L_pt
    h_ii = h_pt((ii-1)*N_r*N_t + 1 : ii*N_r*N_t);
    H_ii = reshape(h_ii,[N_r, N_t]);
    H_matrix_tilde = [H_matrix_tilde H_ii]; 
end
% hpt = H_matrix_tilde(:);
% Block Toeplitz Matrix T(h): H_First_Row_Block = [H(0), 0 ,...,0, H(L-1),H(L-2),...,H(1)];
H_First_Row_Block_tilde   = cell(1,N); 
for ii = 1:N
    H_First_Row_Block_tilde{1,ii} = zeros(N_r,N_t);
end

H_First_Row_Block_tilde{1,1} = H_matrix_tilde(:,end-N_t+1:end); %H0
for ell = 1 : L_pt - 1
    H_First_Row_Block_tilde{1, N-L_tr+ell+1} = H_matrix_tilde(:,N_t*(ell-1)+1:N_t*ell);
end
% Construsting H_Toeplipz
H_cell_tilde  = zeros(N_r,N_t,N);
for ii = 1:N
    H_cell_tilde(:,:,ii) = H_First_Row_Block_tilde{1,ii};
end

H_Toeplipz_tilde  = H_cell_tilde (ind_toeplipz);
    
              
%% Pilot Block
sigma_k     = SIGMA;  
sigma_pt_k  = sigma_k + e_norm^2/(N_r*N);

E_P        = e_p * e_p' +  sigma_k*eye(length(e_p));
Jp_hh      = XXX_P_tilde' * E_P * XXX_P_tilde;
Jp_hchc    = conj(Jp_hh);
Jp_hhc     = XXX_P_tilde' * (e_p * transpose(e_p)) * conj(XXX_P_tilde);
Jp_hch     = Jp_hhc';

FIM_P      = [Jp_hh , Jp_hhc; 
              Jp_hch, Jp_hchc];

NN         = [0, 0; 0, N_r*N];
J_P        = 1/sigma_pt_k^2 * [FIM_P, zeros(2*L_hpt,2);
                               zeros(2,2*L_hpt), NN];   
                        
Ap_hh      = XXX_P_tilde' * XXX_P_tilde;
ap         = XXX_P_tilde' * e_p;
FIM_A      = [Ap_hh, zeros(size(Ap_hh));
              zeros(size(Ap_hh)) , conj(Ap_hh)];
          
A_last_col = [ap;  conj(ap)];
                           
A_P        = -1/sigma_pt_k * [FIM_A, zeros(2*L_hpt,1), A_last_col;
                              zeros(1,2*L_hpt+2);
                              A_last_col', 0,  N_r*N/sigma_pt_k];
                           
%% Unknown Data Blocks
sigma_x  = 1;
C_y      = sigma_x * H_Toeplipz * H_Toeplipz' + sigma_k * eye(N_r*N);
R_y      = sigma_x * H_Toeplipz_tilde * H_Toeplipz_tilde' + sigma_k * eye(N_r*N);
R_y_inv  = R_y^(-1);

%% Partial derivative of H_Toeplipz w.r.t. h_i

partial_H_Toeplipz          = cell(1,L_hpt);
partial_H_First_Row_Block   = cell(1,N);

for n = 1:N
    partial_H_First_Row_Block{1,n} = zeros(N_r,N_t);
end
index = 1;
for ll = 1 : L_pt - 1
    for jj = 1 : N_t
        for ii = 1 : N_r
            Matrix = zeros(N_r,N_t);
            Matrix(ii,jj) = 1;
            partial_H_First_Row_Block{1, N - L_pt + ll + 1} = Matrix;
            % Construsting H_Toeplipz
            partial_H_cell = zeros(N_r,N_t,N);
            for kk = 1 : N
                partial_H_cell(:,:,kk) = partial_H_First_Row_Block{1,kk};
            end
            partial_H_Toeplipz{index} = partial_H_cell(ind_toeplipz);
            index  = index + 1;
            partial_H_First_Row_Block{1, N - L_pt + ll + 1} = zeros(N_r,N_t);
        end
    end
    
end
for ll = 1 %H0
    for jj = 1 : N_t
        for ii = 1 : N_r
            Matrix        = zeros(N_r,N_t);
            Matrix(ii,jj) = 1;
            partial_H_First_Row_Block{1,1} = Matrix;
            partial_H_cell                 = zeros(N_r,N_t,N);
            for kk = 1 : N
                partial_H_cell(:,:,kk) = partial_H_First_Row_Block{1,kk};
            end
            partial_H_Toeplipz{index}  = partial_H_cell(ind_toeplipz);
            index  = index + 1;
            partial_H_First_Row_Block{1,1} = zeros(N_r,N_t);
        end
    end
end


%% Partial derivative of C_y w.r.t. theta_i
partial_Ry_sigma_x =  H_Toeplipz_tilde *  H_Toeplipz_tilde';
partial_Ry_sigma_n =  eye(N_r*N);

% Compute FIM_S [h, conj(h), sigma_x, sigma_n]

J_D = zeros(2*L_hpt + 2);
A_D = zeros(2*L_hpt + 2);

% FIM_{hi,hj}
for ii = 1 : L_hpt
    partial_Ry_h_i       = sigma_x * conj(H_Toeplipz_tilde) * (partial_H_Toeplipz{ii})';
    partial_Ry_h_i_conj  = conj(partial_Ry_h_i);
    
    for jj = 1 : L_hpt
        partial_Ry_h_j        = sigma_x * conj(H_Toeplipz_tilde) * (partial_H_Toeplipz{jj})';
        
        J1 = trace(R_y_inv * partial_Ry_h_i_conj * R_y_inv *C_y * R_y_inv * partial_Ry_h_j * R_y_inv * C_y);
        J2 = trace(R_y_inv * partial_Ry_h_i_conj * (R_y_inv *C_y - eye(N_r*N))) * trace(R_y_inv * partial_Ry_h_j * (R_y_inv *C_y - eye(N_r*N)));
        J_D(ii,jj) = J1 + J2;
        J_D(jj,ii) = conj(J_D(ii,jj));
        
        A1 = - trace(R_y_inv * partial_Ry_h_i_conj * R_y_inv * partial_Ry_h_j * R_y_inv * C_y);
        A2 = + trace(R_y_inv * partial_H_Toeplipz{jj} * partial_H_Toeplipz{ii}' * (R_y_inv *C_y - eye(N_r*N)));
        A3 = - trace(R_y_inv * partial_Ry_h_i_conj *  R_y_inv * partial_Ry_h_j * (R_y_inv *C_y - eye(N_r*N)) );
        A_D(ii,jj) = A1 + A2 + A3;
        A_D(jj,ii) = conj(A_D(ii,jj));
    end
end
% FIM_{hi^*,hj^*}
J_D(L_hpt+1:2*L_hpt,L_hpt+1:2*L_hpt) = (J_D(1:L_hpt,1:L_hpt))';
A_D(L_hpt+1:2*L_hpt,L_hpt+1:2*L_hpt) = (A_D(1:L_hpt,1:L_hpt))';

% FIM_{hi,hj^*} &  FIM_{hi^*,hj}
for ii = L_hpt + 1 : 2*L_hpt
    partial_Ry_h_i = sigma_x  * conj(H_Toeplipz_tilde) * (partial_H_Toeplipz{ii-L_hpt})';
    for jj = 1 : L_hpt
        partial_Ry_h_j        = sigma_x  * conj(H_Toeplipz_tilde) * (partial_H_Toeplipz{jj})';
        partial_Ry_h_j_conj   = conj(partial_Ry_h_j);
        
        J1 = trace(R_y_inv * partial_Ry_h_i * R_y_inv *C_y * R_y_inv * partial_Ry_h_j_conj * R_y_inv * C_y);
        J2 = trace(R_y_inv * partial_Ry_h_i * (R_y_inv *C_y - eye(N_r*N))) * trace(R_y_inv * partial_Ry_h_j_conj * (R_y_inv *C_y - eye(N_r*N)));
        J_D(ii,jj) = J1 + J2;
        J_D(jj,ii) = conj(J_D(ii,jj));
        
        A1 = - trace(R_y_inv * partial_Ry_h_i * R_y_inv * partial_Ry_h_j_conj * R_y_inv * C_y);
        A2 = + trace(R_y_inv * partial_H_Toeplipz{jj} * partial_H_Toeplipz{ii-L_hpt}' * (R_y_inv *C_y - eye(N_r*N)));
        A3 = - trace(R_y_inv * partial_Ry_h_i *  R_y_inv * partial_Ry_h_j_conj * (R_y_inv *C_y - eye(N_r*N)) );
        A_D(ii,jj) = A1 + A2 + A3;
        A_D(jj,ii) = conj(A_D(ii,jj));
        
    end
end


% FIM_{hi,sigma_x} &&  FIM_{sigma_x,hi}
for ii = 2*L_hpt + 1
    for l = 1 : L_hpt
        partial_Ry_h_l       = sigma_x * conj(H_Toeplipz_tilde) * (partial_H_Toeplipz{l})';
        partial_Ry_h_l_conj  = conj(partial_Ry_h_l);
        
        J1 = trace(R_y_inv * partial_Ry_sigma_x * R_y_inv *C_y * R_y_inv * partial_Ry_h_l * R_y_inv * C_y);
        J2 = trace(R_y_inv * partial_Ry_sigma_x * (R_y_inv *C_y - eye(N_r*N))) * trace(R_y_inv * partial_Ry_h_l_conj * (R_y_inv *C_y - eye(N_r*N)));
        J_D(ii,l) = J1 + J2;
        J_D(l,ii) = conj(J_D(ii,l));
        
        A1 = - trace(R_y_inv * partial_Ry_sigma_x * R_y_inv * partial_Ry_h_l * R_y_inv * C_y);
        A2 = + trace(R_y_inv * partial_Ry_h_l * (R_y_inv *C_y - eye(N_r*N)));
        A3 = - trace(R_y_inv * partial_Ry_sigma_x *  R_y_inv * partial_Ry_h_l * (R_y_inv *C_y - eye(N_r*N)) );
        A_D(ii,l) = A1 + A2 + A3;
        A_D(l,ii) = conj(A_D(ii,l));
        
        
        J1 = trace(R_y_inv * partial_Ry_sigma_x * R_y_inv *C_y * R_y_inv * partial_Ry_h_l * R_y_inv * C_y);
        J2 = trace(R_y_inv * partial_Ry_sigma_x * (R_y_inv *C_y - eye(N_r*N))) * trace(R_y_inv * partial_Ry_h_l * (R_y_inv *C_y - eye(N_r*N)));
        J_D(ii,l) = J1 + J2;
        J_D(l,ii) = conj(J_D(ii,l));
        
        A1 = - trace(R_y_inv * partial_Ry_sigma_x * R_y_inv * partial_Ry_h_l * R_y_inv * C_y);
        A2 = + trace(R_y_inv * partial_Ry_h_l * (R_y_inv *C_y - eye(N_r*N)));
        A3 = - trace(R_y_inv * partial_Ry_sigma_x *  R_y_inv * partial_Ry_h_l * (R_y_inv *C_y - eye(N_r*N)) );
        A_D(ii,l+L_hpt) = A1 + A2 + A3;
        A_D(l+L_hpt,ii) = conj(A_D(ii,l+L_hpt));
    end
end

% FIM_{hi,sigma_n} &&  FIM_{sigma_n,hi}
for ii = 2*L_hpt + 2
    for l = 1 : L_hpt
        partial_Ry_h_l = sigma_x * H_Toeplipz_tilde * transpose(partial_H_Toeplipz{l});
                  
        J1 = trace(R_y_inv * partial_Ry_sigma_n * R_y_inv *C_y * R_y_inv * partial_Ry_h_l * R_y_inv * C_y);
        J2 = trace(R_y_inv * partial_Ry_sigma_n * (R_y_inv *C_y - eye(N_r*N))) * trace(R_y_inv * partial_Ry_h_l * (R_y_inv *C_y - eye(N_r*N)));
        J_D(ii,l) = J1 + J2;
        J_D(l,ii) = conj(J_D(ii,l));
        
        A1 = - trace(R_y_inv * partial_Ry_sigma_n * R_y_inv * partial_Ry_h_l * R_y_inv * C_y);
        A2 = 0;
        A3 = - trace(R_y_inv * partial_Ry_sigma_n *  R_y_inv * partial_Ry_h_l * (R_y_inv *C_y - eye(N_r*N)) );
        A_D(ii,l) = A1 + A2 + A3;
        A_D(l,ii) = conj(A_D(ii,l));
        
        
        J1 = trace(R_y_inv * partial_Ry_sigma_n * R_y_inv *C_y * R_y_inv * partial_Ry_h_l * R_y_inv * C_y);
        J2 = trace(R_y_inv * partial_Ry_sigma_n * (R_y_inv *C_y - eye(N_r*N))) * trace(R_y_inv * partial_Ry_h_l * (R_y_inv *C_y - eye(N_r*N)));
        J_D(ii,l) = J1 + J2;
        J_D(l,ii) = conj(J_D(ii,l));
        
        A1 = - trace(R_y_inv * partial_Ry_sigma_n * R_y_inv * partial_Ry_h_l * R_y_inv * C_y);
        A2 = 0;
        A3 = - trace(R_y_inv * partial_Ry_sigma_n *  R_y_inv * partial_Ry_h_l * (R_y_inv *C_y - eye(N_r*N)) );
        A_D(ii,l+L_hpt) = A1 + A2 + A3;
        A_D(l+L_hpt,ii) = conj(A_D(ii,l+L_hpt));           
    end
    
end
% FIM_{sigma_n} &&  FIM_{sigma_x}
J1 = trace(R_y_inv * partial_Ry_sigma_x * R_y_inv *C_y * R_y_inv * partial_Ry_sigma_x * R_y_inv * C_y);
J2 = trace(R_y_inv * partial_Ry_sigma_x * (R_y_inv *C_y - eye(N_r*N))) * trace(R_y_inv * partial_Ry_sigma_x * (R_y_inv *C_y - eye(N_r*N)));
A1 = - trace(R_y_inv * partial_Ry_sigma_x * R_y_inv * partial_Ry_sigma_x * R_y_inv * C_y);
A2 = 0;
A3 = - trace(R_y_inv * partial_Ry_sigma_x *  R_y_inv * partial_Ry_sigma_x * (R_y_inv *C_y - eye(N_r*N)) );
J_D(2*L_hpt+ 1, 2*L_hpt+1) = J1 + J2;
A_D(2*L_hpt+ 1, 2*L_hpt+1) = A1 + A2 + A3;

J1 = trace(R_y_inv * partial_Ry_sigma_n * R_y_inv *C_y * R_y_inv * partial_Ry_sigma_n * R_y_inv * C_y);
J2 = trace(R_y_inv * partial_Ry_sigma_n * (R_y_inv *C_y - eye(N_r*N))) * trace(R_y_inv * partial_Ry_sigma_n * (R_y_inv *C_y - eye(N_r*N)));
A1 = - trace(R_y_inv * partial_Ry_sigma_n * R_y_inv * partial_Ry_sigma_n * R_y_inv * C_y);
A2 = 0;
A3 = - trace(R_y_inv * partial_Ry_sigma_n *  R_y_inv * partial_Ry_sigma_n * (R_y_inv *C_y - eye(N_r*N)) );
J_D(2*L_hpt+ 2, 2*L_hpt+2) = J1 + J2;
A_D(2*L_hpt+ 2, 2*L_hpt+2) = A1 + A2 + A3;

J1 = trace(R_y_inv * partial_Ry_sigma_x * R_y_inv *C_y * R_y_inv * partial_Ry_sigma_n * R_y_inv * C_y);
J2 = trace(R_y_inv * partial_Ry_sigma_x * (R_y_inv *C_y - eye(N_r*N))) * trace(R_y_inv * partial_Ry_sigma_n * (R_y_inv *C_y - eye(N_r*N)));
A1 = - trace(R_y_inv * partial_Ry_sigma_x * R_y_inv * partial_Ry_sigma_n * R_y_inv * C_y);
A2 = 0;
A3 = - trace(R_y_inv * partial_Ry_sigma_x *  R_y_inv * partial_Ry_sigma_n * (R_y_inv *C_y - eye(N_r*N)) );
J_D(2*L_hpt+ 2, 2*L_hpt+1) = J1 + J2;
A_D(2*L_hpt+ 2, 2*L_hpt+1) = A1 + A2 + A3;


J1 = trace(R_y_inv * partial_Ry_sigma_n * R_y_inv *C_y * R_y_inv * partial_Ry_sigma_n * R_y_inv * C_y);
J2 = trace(R_y_inv * partial_Ry_sigma_n * (R_y_inv *C_y - eye(N_r*N))) * trace(R_y_inv * partial_Ry_sigma_n * (R_y_inv *C_y - eye(N_r*N)));
A1 = - trace(R_y_inv * partial_Ry_sigma_n * R_y_inv * partial_Ry_sigma_n * R_y_inv * C_y);
A2 = 0;
A3 = - trace(R_y_inv * partial_Ry_sigma_n *  R_y_inv * partial_Ry_sigma_n * (R_y_inv *C_y - eye(N_r*N)) );
J_D(2*L_hpt+ 1, 2*L_hpt+2) = J1 + J2;
A_D(2*L_hpt+ 1, 2*L_hpt+2) = A1 + A2 + A3;
 
%% Combine
A_SB  =  A_P + K*A_D;
J_SB  =  J_P + K*J_D;

%%
GMCRB_SB     = pinv(A_SB) * J_SB * pinv(J_SB);

% Return
Err = abs(trace(GMCRB_SB(1:L_hpt,1:L_hpt) ) ) ;

end