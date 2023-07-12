function Err = B_Fast_SS(Op, SNR_i, Output_type)

%% Fast Subspace
%
%% Input:
    % + 1. Ns: number of samples
    % + 2. Nt: number of TX antennas
    % + 3. Nr: number of RX antennas
    % + 4. N: number of channel's paths 
    % + 5. K: number of OFDM sub carriers
    % + 6. ChType: type of the channel (real, complex, user's
    % input)
    % + 7. Mod: type of modulation (All)
    % + 8. SNR_i: signal noise ratio
    % + 9. Output_type: MSE Channel
%
%% Output:
    % + 1. Err: Error rate
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Generate input signal
    %     X <= h^T * s + n
    % Step 3: 
    % Step 4: Fast Subspace algorithm
    % Step 5: Compute Error rate
    %     Demodulate Y
    %     Compute MSE Channel
    % Step 6: Return 
%
% Ref: Ouahbi Rekik. Bui Minh Tuan, Karim Abed-Meraim, and Nguyen
% Linh Trung, "Fast Subspace-based Blind Channel Identification 
% for MIMO-OFDM Communications Systems," 2023.
%
%% Require R2006A

% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 12-Jul-2023 21:52:00.


Ns         = Op{1};     % number of sig sequences
Nt         = Op{2};     % number of tx
Nr         = Op{3};     % number of rx
N          = Op{4};     % number of paths
K          = Op{5};     % number of sub-carriers
Ch_type    = Op{6};     % complex
Mod_type   = Op{7};     % 4-QAM
w          = dftmtx(K); % DFT matrix
F          = w(1:N,:);  % F(:,k)=ek


% Generate input signal
modulation = {'Bin', 'QPSK', 'QAM4', 'QAM16', 'QAM64', 'QAM128', 'QAM256'};
[sig_src, data] = eval(strcat(modulation{Mod_type}, '(K*Nt*Ns)'));
X          = sig_src.' / sqrt(2);
S          = reshape(X,Nt,Ns,K);  % transmitted signal

% Generate channel
H          = Generate_channel(Nr, Nt*N - 1, Ch_type) * sqrt(2);
vecH       = H(:);
modH       = vecH'*vecH;

% Signal rec
Ysb        = zeros(Nr,Ns,K);  % noiseless received signal
for k = 1:K
    Hk = H*kron(F(:,k),eye(Nt));
    %if mod(k,7)==0
     %  Hk = Hk*0.2;
    %end
    var(k,1) = norm(Hk);
    Ysb(:,:,k) = Hk*S(:,:,k);
end
Prp     = Ysb(:)'*Ysb(:)/numel(Ysb); % data signal average power

%% --------------------------------------------------------------
%% Blind Fast subspace program
sigmav2 = 10^((10*log10(Prp)-SNR_i)/10);
noise   = sqrt(sigmav2)*(randn(Nr,Ns) + 1i*randn(Nr,Ns))/sqrt(2);

Q       = zeros(Nr*Nt*N,Nr*Nt*N);  % minimize h^H * Q * h
Y       = zeros(Nr,Ns,K);  % noisy received signal

for k = 1:1:K
    Y(:,:,k) = Ysb(:,:,k) + noise; % adding noise
    Cyk = zeros(Nr,Nr); % covariance matrix of received signal

    for ns = 1:Ns
       Cyk = Cyk + Y(:,ns,k)*Y(:,ns,k)';
    end
    Cyk = Cyk/Ns;
   
    %... Estimation of noise-eigenvectors for each sub carrier
    [u,s,v] = svd(Cyk);
    Uk      = v(:,Nt+1:Nr); % noise subspace
    
    Q1 = kron(conj(F(:,k))*transpose(F(:,k)),eye(Nt));
    Q = Q + kron(Q1,Uk*Uk');
end

[u2,s2,v2]  = svd(Q);
h_estim     = v2(:,end); % estimated channel vector

%... ambiguity removal
H_estim     = reshape(h_estim, Nr, Nt*N);
H_estim2    = [];
H_2         = []; % to obtain vectors of size Nr*N x Nt from vectors of size Nr x Nt*N

for i=1:N
    H_estim2 = [H_estim2; H_estim(:,(i-1)*Nt+1:i*Nt)]; 
    H_2      = [H_2; H(:,(i-1)*Nt+1:i*Nt)]; 
end

H_estim2    = H_estim2*pinv(H_estim2)*H_2;
h_estim2    = H_estim2(:);
vecH2       = H_2(:);

% Compute MSE Channel
Err         = ER_func(vecH2.', h_estim2, Mod_type, Output_type);

end