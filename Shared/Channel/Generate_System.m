function [H_matrix,h,y_p,X_Matrix_Pilot] = Generate_System(L_tr,N_r,N_t,N,K)

if nargin < 5 
    N_r  = 3;         % Transmit Antena
    N_t  = 2;         % Receive  Antena
    L_tr = 5;         % True Channel Order
    L_pt = 4;         % Misspecified Channel Order
    K    = 2;         % Number of Unknown data Blocks
    N    = 30; 
end
    


%% Generate system
% Generate H
H_matrix = []; % H_matrix = [H(L-1) H(L-2) ... H(0)]
for ii  = 1 : L_tr
    Hii       = randn(N_r,N_t) + i*randn(N_r,N_t);
    H_matrix  = [Hii, H_matrix];
end
h = H_matrix(:);

% Block Toeplitz Matrix T(H_First_Row_Block):
% H_First_Row_Block = [H(0), 0 ,...,0, H(L-1),H(L-2),...,H(1)];
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
ind_toeplitz_outer  = repelem(mod(bsxfun(@minus, 0:N-1, (0:N-1).'), N), N_r, N_t);
ind_toeplitz_inner  = repmat(reshape(1:N_r*N_t, N_r, N_t), N, N);
ind_toeplitz        = ind_toeplitz_outer*N_r*N_t + ind_toeplitz_inner;

H_Toeplipz = H_cell(ind_toeplitz); % for 1 block
HHH        = kron(eye(K),H_Toeplipz); % for K blocks


%% Pilot
X_Matrix_Pilot  = randn(N_t,N) + i*randn(N_t,N);
x_p             = X_Matrix_Pilot(:);
y_p             = H_Toeplipz * x_p;
% Unknown data
X_Matrix_Data   = randn(N_t,N*K) + i*randn(N_t,N*K);
x_d             = X_Matrix_Data(:);
y_d             = HHH * x_d;


end