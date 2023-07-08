function Err = B_CS_SMNS(Op, SNR_i, Output_type)

%% SMNS Channel Subspace
%
%% Input:
    % + 1. num_sq: number of samples
    % + 2. L: number of channels
    % + 3. M: Channel order
    % + 4. Ch_type: Type of the channel (real, complex, specular,
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

% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 08-Jul-2023 12:30:00.


num_sq    = Op{1};     % number of sig sequences
L         = Op{2};     % number of the sensors
M         = Op{3};     % length of the channel 
Ch_type   = Op{4};     % complex
Mod_type  = Op{5};     
N         = Op{6};     % Window length


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

%% Algorithm CS SMNS
tmp     = H.';
can     = tmp(:);
can     = can*exp(-1i*angle(can(1)));

R       = EstimateCov(sig_rec, num_sq, L, N);

Pi      = zeros(N*L,L);
for ii  = 1:L
    x   = zeros(L*N,1);
    if ii <= (L-1)
        vect_index = [ii,ii+1];
    else
        vect_index = [L,1];
    end
    index_1 = vect_index(1,1);
    index_2 = vect_index(1,2);

    %calculer  R_ii;
    Rii = [R((index_1-1)*N+1:(index_1)*N , (index_1-1)*N+1:(index_1)*N), R( (index_1-1)*N+1:(index_1)*N , (index_2-1)*N+1:(index_2)*N ); ...
        R( (index_2-1)*N+1:(index_2)*N , (index_1-1)*N+1:(index_1)*N), R((index_2-1)*N+1:(index_2)*N , (index_2-1)*N+1:(index_2)*N)];
    
    %faire le svd();
    [u,s,v] = svd(Rii);
    
    %calcul de x then Pi
    x((index_1-1)*N+1:(index_1)*N ,: ) = u(1:N ,2*N);
    x((index_2-1)*N+1:(index_2)*N ,: ) = u(N+1:2*N ,2*N);
    Pi(:,ii) = x;
end

%... algorithme SMNS

%
%... calcul des produits < vec bruit | mat base >
%
BB      = zeros(L, L*(M+1)*(M+N));
icol    = 1:M+N;
for icap=1:L
    Ecap=Pi(N*(icap-1)+1:N*icap,:)';
    for jdec=1:M+1
        B = zeros(L,M+N);
    	B (:,jdec:jdec+N-1)=Ecap;
        BB(:,icol) = B;
        icol=icol+M+N;
    end
end

Q       = zeros(L*(M+1),L*(M+1));
%
%... calcul de la forme quadratique
%
B1      = zeros(L*(M+N),1);
B2      = zeros(L*(M+N),1);

for ii=1:L*(M+1)
    for jj=1:L*(M+1)
        icoli = (ii-1)*(M+N)+1:ii*(M+N);
        icolj = (jj-1)*(M+N)+1:jj*(M+N);
        B1(:) = BB(:,icoli);
        B2(:) = BB(:,icolj);
        Q(ii,jj) = B1'*B2;
    end
end

[u,v]   = eig(Q);
[k,l]   = sort(diag(v));
h_est   = u(:,l(1));
h_est   = h_est*h_est'*can;

% Compute MSE Channel
Err     = ER_func(H, h_est, Mod_type, Output_type);

end