function Err = Demo_Estimator_SB_Fast_SS(Op, SNR_i, Output_type)

%% Semi-blind Fast Subspace
%
%% Input:
    % + 1. Ns: number of samples
    % + 2. Nt: number of TX antennas
    % + 3. Nr: number of RX antennas
    % + 4. N: number of channel's paths 
    % + 5. K: number of OFDM sub carriers
    % + 6. Np: number of pilot symbols
    % + 7. Ch_type: type of the channel (real, complex, user's
    % input)
    % + 8. Mod: type of modulation (All)
    % + 9. SNR_i: signal noise ratio
    % + 10. Output_type: MSE Channel
%
%% Output:
    % + 1. Err: MSE Channel
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Generate input signal
    %     X <= h^T * s + n
    % Step 3: 
    % Step 4: SB-Fast Subspace algorithm
    % Step 5: Compute Error rate
    %     Demodulate Y
    %     Compute MSE Channel
    % Step 6: Return 
%
% Ref: Ouahbi Rekik, Bui Minh Tuan, Karim Abed-Meraim, and Nguyen
% Linh Trung, "Fast Subspace-based Blind and Semi-Blind Channel 
% Estimation for MIMO-OFDM Systems," 2023.
%
%% Require R2006A

% Author: Ouahbi Rekik

% Adapted for InSI by Do Hai Son, 25-Aug-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless Communications
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


Ns         = Op{1};     % number of sig sequences
Nt         = Op{2};     % number of tx
Nr         = Op{3};     % number of rx
N          = Op{4};     % number of paths
K          = Op{5};     % number of sub-carriers
Np         = Op{6};     % number of pilot symbols
Ch_type    = Op{7};     % complex
Mod_type   = Op{8};     % 4-QAM
alpha      = 100;
w          = dftmtx(K); % DFT matrix
wcp        = [w(end-N+1:end,:); w];    %addition of cyclic prefix
F          = w(1:N,:);  % F(:,k)=ek
G          = 45;        % length of each window
NG         = K - G +1;  % number of partition of one OFDM symbol


% Generate input signal
modulation = {'Bin', 'QPSK', 'QAM4', 'QAM16', 'QAM64', 'QAM128', 'QAM256'};
[sig_src, data] = eval(strcat(modulation{Mod_type}, '(K*Nt*Ns)'));
X          = sig_src.' / sqrt(2);
S          = reshape(X,Nt,Ns,K);  % transmitted signal
psymb      = S(:,1:N*Np,:); %pilot symbols 
psymb      = reshape(psymb,K,N*Nt*Np); %Tx Pilot symbols 

% Generate channel
H          = Generate_channel(Nr, Nt*N - 1, Ch_type) * sqrt(2);
vecH       = H(:);
modH       = vecH'*vecH;

% Signal rec
Ysb        = zeros(Nr,Ns,K);  % noiseless received signal
for k = 1:K
    Hk     = H * kron(F(:,k),eye(Nt));
    Ysb(:,:,k) = Hk * S(:,:,k);
end
Prp     = Ysb(:)'*Ysb(:)/numel(Ysb); % data signal average power

%% --------------------------------------------------------------
%% Semi-blind Fast subspace program
sigmav2 = 10^((10*log10(Prp) - SNR_i)/10);
noise1  = sqrt(sigmav2)*(randn(Nr*K,1)+1i*randn(Nr*K,1))/sqrt(2);
noise   = sqrt(sigmav2)*(randn(Nr,Ns)+1i*randn(Nr,Ns))/sqrt(2);

for np = 1:Np
    X1 = kron(eye(Nr),psymb(:,((np-1)*Nt*N+1:np*Nt*N)));
    X_telda(:,((np-1)*K*Nr+1:np*K*Nr)) = X1.'; % x telda containing Tx pilot symbols
    Y1 = X1*vecH + noise1; %Eqn 5 of the reference used
    Y_telda(1,((np-1)*K*Nr+1:np*K*Nr)) = Y1.'; % y telda containing Rx pilot symbols
end 
Yp_telda = Y_telda.';
Xp_telda = X_telda.';

Yk      = zeros(Nr,Ns,K);
Ryy     = zeros(Nr,Nr);
Q       = zeros(Nr*Nt*N,Nr*Nt*N);
c       = 1;

for k = 1:K
    Yk(:,:,k) = Ysb(:,:,k) + noise;
    for ns = 1:Ns 
       Ry = Yk(:,ns,k)*Yk(:,ns,k)';
       Ryy = Ryy +Ry;
    end
    Ryy =Ryy/Ns;
    [s v d1] = svd(Ryy);
    Ukn = d1(:,Nt+1:Nr);
    Qk = kron(conj(F(:,k))*transpose(F(:,k)),eye(Nt));
    Q = Q + kron(Qk,Ukn*Ukn');
end
h_estiSB    = (Xp_telda'*Xp_telda+alpha*Q)\Xp_telda'*Yp_telda;

H_estSB      = reshape(h_estiSB,Nr,Nt*N);
H_estSB2     = [];  
H_SB2        = []; % to obtain vectors of size Nr*N x Nt from vectors of size Nr x Nt*N

for i=1:N
    H_estSB2 = [H_estSB2; H_estSB(:,(i-1)*Nt+1:i*Nt)]; 
    H_SB2    = [H_SB2; H(:,(i-1)*Nt+1:i*Nt)]; 
end
H_estSB2     = H_estSB2*pinv(H_estSB2)*H_SB2;
h_estSB2     = H_estSB2(:);
vecHSB2      = H_SB2(:);  

% Compute MSE Channel
Err         = ER_func(vecHSB2.', h_estSB2, Mod_type, Output_type);

end