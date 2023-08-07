function Err = Demo_CRB_Only_Pilot(Op, SNR_i, ~)

%% Only Pilots
%
%% Input:
    % + 1. Nt: number of transmit antennas
    % + 2. Nr: number of receive antennas
    % + 3. N: length of the channel
    % + 4. Ch_type: type of the channel (real, complex,
    % user' input
    % + 5. Mod_type: type of modulation (All)
    % + 6. Np: number of pilot symbols
    % + 7. SNR_i: signal noise ratio
%
%% Output:
    % + 1. Err: CRB
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Return 
%
% Ref: Ouahbi Rekik, Karim Abed-Meraim, Mohamed Nait-Meziane,
% Anissa Mokraoui, and Nguyen Linh Trung, "Maximum likelihood 
% based identification for nonlinear multichannel communications 
% systems," Signal Processing, vol. 189, p. 108297, Dec. 2021.
%
%% Require R2006A

% Author: Ouahbi Rekik, L2TI, UR 3043, Université Sorbonne Paris Nord, France

% Adapted for InSI by Do Hai Son, 1-Aug-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless Communications
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


Nt        = Op{1};     % number of transmit antennas
Nr        = Op{2};     % number of receive antennas
N         = Op{3};     % length of the channel
Ch_type   = Op{4};     % complex
Mod_type  = Op{5};
Np        = Op{6};     % number of pilot OFDM symbol
Nd        = Op{7};     % number of data OFDM symbol
PxpdBm    = 13;        % power / symbol ~ 23dBm
PxddBm    = [10 8.8431 20.7062 20.3648]; % power / symbol ~ 20dBm
Pxp       = 10^(PxpdBm/10);
Pxd       = 10.^(PxddBm/10);
K         = 64;
Kp        = 8;         % number of Xp samples
Kd        = K-Kp;      % number of Xd samples
w         = dftmtx(K);
sigmas2   = Pxd;
sigmas    = sqrt(sigmas2);

%% ====== channel generation ========================
H = [];
for nt=1:Nt
    if Ch_type == 2
        H = cat(3, H, Generate_channel(Nr, N - 1, Ch_type) * sqrt(2));
    else
        H = cat(3, H, Generate_channel(Nr, N - 1, Ch_type));
    end
end

h=[];
for ii=1:Nt
    h=[h; transpose(reshape(transpose(H(:,:,ii)),1,Nr*N))];
end
hmod2=(h'*h);

% matrice de permutation h_bar=Pv*h
Pvv=zeros(Nt*Nr);
for r=1:Nr
    for t=1:Nt
        x1=(r-1)*Nt+t;
        y1=(t-1)*Nr+r;
        Pvv(x1,y1)=1;
    end
end
Pv=kron(Pvv,eye(N));
h_bar=Pv*h; % (pour l'estimation OP inv(XX')..)

%% ======= Data generation ============
modulation = {'Bin', 'QPSK', 'QAM4', 'QAM16', 'QAM64', 'QAM128', 'QAM256'};

[sig_src, data] = eval(strcat(modulation{Mod_type}, '(K * Nd * Nt)'));

xd=reshape(sig_src,K,Nd,Nt);

%--- Les ces possibles pour le vecteur data
% ================ Nt=2 =====================
for id=1:Np
    xd(1:8:64,id,1)=xd(1:8:64,id,1);
    xd(1:8:64,id,2)=((-1)^(id))*xd(1:8:64,id,2);
end

xd_p=xd(1:8:64,1:Np,:);
xd_d=[xd(2:8,1:Np,:);xd(10:16,1:Np,:);xd(18:24,1:Np,:);xd(26:32,1:Np,:);xd(34:40,1:Np,:);xd(42:48,1:Np,:);xd(50:56,1:Np,:);xd(58:64,1:Np,:)];

wp=w(1:8:64,:);
wd=[w(2:8,:);w(10:16,:);w(18:24,:);w(26:32,:);w(34:40,:);w(42:48,:);w(50:56,:);w(58:64,:)];

% CRB Comb pour EM_OP
Xp=[];Xd=[];Xtt_tild=[];
for id=1:Np
    Xp_tmp=sqrt(Pxp)*[diag(xd_p(:,id,1))*wp(:,1:N) diag(xd_p(:,id,2))*wp(:,1:N)]; %Nt=2
    Xp=[Xp;kron(eye(Nr),Xp_tmp)];
    Xd_tmp=sigmas(1)*[diag(xd_d(:,id,1))*wd(:,1:N) diag(xd_d(:,id,2))*wd(:,1:N)]; %Nt=2
    Xd=[Xd;kron(eye(Nr),Xd_tmp)];
    Xtt_tmp=sigmas(1)*[diag(xd(:,id,1))*w(:,1:N) diag(xd(:,id,2))*w(:,1:N)];%Nt=2
    Xtt_tild=[Xtt_tild;kron(eye(Nr),Xtt_tmp)];
end

yp_sans_bruit=Xp*h_bar;
ytt_sans_bruit=Xtt_tild*h_bar;

Prp=sum(yp_sans_bruit'*yp_sans_bruit)/(Kp*Np*Nr);
Prptt=sum(ytt_sans_bruit'*ytt_sans_bruit)/(K*Np*Nr);
Prp=Prptt;

sigmav2=10^((10*log10(Prp)-SNR_i)/10);

%===== CRB OP =======
CRB_OP = abs(trace(sigmav2*inv(Xp'*Xp))); % CRB pour h_bar
CRB_OP = CRB_OP / hmod2;

% Return
Err      = CRB_OP;

end