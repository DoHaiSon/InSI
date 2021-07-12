clear all;
%close all;
clc; 


%% Declear

Nt      = 2;         % number of transmit antennas
Nr      = 64;        % number of receive antennas
L       = 4;         % channel order
M       = 2;         % Number of multipaths (assumption: M  = L)   
Pxp     = 0.3;
K       = 64;        % OFDM subcarriers
Np      = 20;        % Pilot symbols
Ns_data = 34;        % Data symbols
F       = dftmtx(K);
FL      = F(:,1:L);


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
%fading = 0.1+(0.6-0.1)*rand(M,Nt);
fading=[0.8,0.6,0.4,0.2;0.9,0.7,0.5,0.3];
%delay  = 0.1+(0.15-0.1)*rand(M,Nt)*0.01;
delay=[0.1,0.2,0.3,0.4;0.2,0.3,0.4,0.5]*0.001;
%DOA    = (-0.5+(0.5-(-0.5))*rand(M,Nt))*pi;
DOA_Phi=[pi/2,pi/4,pi/6,pi/8;pi/3,pi/5,pi/7,pi/9];
DOA_Theta=[0.3,0.4,0.25,0.6;0.7,0.85,0.43,0.66]*pi;
%DOA_Theta = (0.1+(1-0.1)*rand(M,Nt))*pi;
d_nor=0.5;
R_nor=0.5*d_nor/sin(pi/Nr);

%% Derivative
% w.r.t. fading
%Br_fading = zeros(Nt,M,L);
dev_h_fading_tmp=[];
dev_h_delay_tmp=[];
dev_h_angle_tmp=[];
%dev_h_fading_tmp=cell(Nr,1);

dev_h_fading=[];
dev_h_delay=[];
dev_h_angle_Phi=[];
dev_h_angle_Theta=[];


for Nr_index=1:Nr;
    Br_fading = spec_chan_derive_fading_UCA3D(fading,delay,DOA_Phi,DOA_Theta,R_nor,Nr_index,Nr,L,M,Nt);
    dev_h_fading=[dev_h_fading; transpose(Br_fading)];

    Br_delay = spec_chan_derive_delay_UCA3D(fading,delay,DOA_Phi,DOA_Theta,R_nor,Nr_index,Nr,L,M,Nt);
    dev_h_delay=[dev_h_delay; transpose(Br_delay)];

    Br_angle_Phi = spec_chan_derive_angle_Phi_UCA3D(fading,delay,DOA_Phi,DOA_Theta,R_nor,Nr_index,Nr,L,M,Nt);
    dev_h_angle_Phi=[dev_h_angle_Phi; transpose(Br_angle_Phi)];

    Br_angle_Theta = spec_chan_derive_angle_Theta_UCA3D(fading,delay,DOA_Phi,DOA_Theta,R_nor,Nr_index,Nr,L,M,Nt);
    dev_h_angle_Theta=[dev_h_angle_Theta; transpose(Br_angle_Theta)];
end

%% Derivation of $h$ w.r.t. (bar{h},tau,alpha) %% channel specular parameters
G = [dev_h_fading,dev_h_delay,dev_h_angle_Phi,dev_h_angle_Theta]; 
%% ------------------------------------------------------------------------
 
X = [];
for ii = 1 : Nt
    X  = [X diag(ZC(:,ii))*FL];
end

%% CRB 
% Loop SNR
SNR = -10:5:30;
for snr_i = 1 : length(SNR)
    tic
    fprintf('Working at SNR: %d dB.\n', SNR(snr_i));
    sigmav2 = 10^(-SNR(snr_i)/10);

    %% Perfect Specificiation 
    X_nga=kron(eye(Nr),X);
   
    Iop      = X_nga'*X_nga / sigmav2;
    Iop_spec = ((-1)/(sigmav2)^2)*G*G'* X_nga'*sigmav2*eye(Nr*K)*X_nga*G*G';
    CRB_op(snr_i) = abs(trace(pinv(Iop)));
    CRB_op_spec(snr_i) = abs(trace(pinv(Iop_spec)));
    toc
end

%figure
%semilogy(SNR,CRB_op,'-b>')
%hold on; semilogy(SNR,CRB_op_spec,'-r+')

%semilogy(SNR,CRB_op,'-b')
%hold on; semilogy(SNR,CRB_op_spec,'-r')

semilogy(SNR,CRB_op,'-g')
hold on; semilogy(SNR,CRB_op_spec,'-m')

grid on
ylabel('Normalized CRB')
xlabel('SNR(dB)')
legend('usual OP','spec OP')
title(' ')
%axis([-10 20 1e-4 1e2])
hold on;