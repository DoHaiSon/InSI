clear all;
close all;
clc; 


%%
tic
Nt = 4;    % number of transmit antennas
Nr = 4;    % number of receive antennas
L   = 4;    % channel order
M   = 2;    % Number of multipaths (assumption: M  = L)   
Pxp = 10;
Pxd = [90 92 88 86];
Pxt = 100;
K  = 64;        % OFDM subcarriers
Np      = 20;      % Pilot symbols
Ns_data = 34;      % Data symbols
F  = dftmtx(K);
FL  = F(:,1:L);


%% Signal Generation
% we use the Zadoff-Chu sequences
U = 1:2:7;
ZC_p = [];
for u = 1 : Nt
    for k = 1 : K
        ZC(k,u) = sqrt(Pxp) * exp( ( -1i * pi * U(u) * (k-1)^2 ) / K );
    end
    ZC_p = [ZC_p; ZC(:,u)];
end

%% Channel generation 
% Fading, delay, DOA matrix of size(M,Nt), M - the number of multipath
%fading = rand(M,Nt)+1i*rand(M,Nt);
%fading = rand(M,Nt);
fading=[0.8,0.6,0.4,0.2;0.9,0.7,0.5,0.3];
%delay  = rand(M,Nt);
delay=[0.1,0.2,0.3,0.4;0.2,0.3,0.4,0.5]*0,1;
%DOA    = pi * rand(M,Nt);
DOA=[pi/2,pi/4,pi/6,pi/8;pi/3,pi/5,pi/7,pi/9];
d_nor=1/2;
%H      = spec_chan(fading,delay,DOA,Nr,L,Nt);  % H(Nr,L,Nt)

%h=[];
%for ii = 1 : Nt
%    h              = [h reshape(transpose(H(:,:,ii)),1,Nr*L)];
%end

%hmod2      = (h*h')^2; 
%% Derivative
% w.r.t. fading
%Br_fading = zeros(Nt,M,L);
dev_h_fading_tmp=[];
%dev_h_fading_tmp=cell(Nr,1);

dev_h_fading=[];
for Nr_index=1:Nr;
Br_fading = spec_chan_derive_fading(fading,delay,DOA,d_nor,Nr_index,L,M,Nt);
dev_h_fading=[dev_h_fading; transpose(Br_fading)];
%dev_h_fading=[dev_h_fading;Br_fading];
end

%% Derivation of $h$ w.r.t. (bar{h},tau,alpha) %% channel specular parameters
%DD = [D_fading D_delay D_AOA_Nt]; % for real parameters
%DD = [D_fading, 1i*D_fading, D_delay, D_AOA_Nt]; % for complex parameters

%G = [dev_h_fading, 1i*dev_h_fading]; 
G = dev_h_fading; 
%% ------------------------------------------------------------------------
 
X = [];
for ii = 1 : Nt
    %X        = [X (F'/sqrt(K))*diag(ZC(:,ii))*FL];
    X        = [X diag(ZC(:,ii))*FL];
end

%% CRB 
% Loop SNR
SNR = -10:5:30;
for snr_i = 1 : length(SNR)
    
    sigmav2 = 10^(-SNR(snr_i)/10);

    %% Perfect Specificiation 
    X_nga=kron(eye(Nr),X);
   
    Iop      = X_nga'*X_nga / sigmav2;
    %Iop_spec = DD' * Iop * DD;
    Iop_spec = ((-1)/(sigmav2)^2)*G*G'* X_nga'*sigmav2*eye(Nr*K)*X_nga*G*G';
    CRB_op(snr_i) = abs(trace(pinv(Iop)));
    CRB_op_spec(snr_i) = abs(trace(pinv(Iop_spec)));
      
   
end

figure
semilogy(SNR,CRB_op,'-b>')
hold on; semilogy(SNR,CRB_op_spec,'-r+')

grid on
ylabel('Normalized CRB')
xlabel('SNR(dB)')
legend('usual','specular')
title(' ')
%axis([-10 20 1e-4 1e2])
