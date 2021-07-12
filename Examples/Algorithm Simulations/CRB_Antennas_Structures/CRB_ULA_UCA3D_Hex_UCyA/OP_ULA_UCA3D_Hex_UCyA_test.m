clear all;
close all;
clc; 


%%
Nt = 2;     % number of transmit antennas
Pxp = 10;   % power of pilot
L   = 4;    % channel order
M   = 2;    % number of multipaths
%=========================================
%OFDM
K  = 64;        % OFDM subcarriers
F  = dftmtx(K);
FL  = F(:,1:L);
%=========================================
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
X = [];
for ii = 1 : Nt
    X        = [X diag(ZC(:,ii))*FL];
end
%=========================================
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
%=========================================
%Derivative Channel
%=========================================
d_nor=0.5;
%ULA
Nr_ULA=64;

dev_h_fading_tmp_ULA=[];
dev_h_delay_tmp_ULA=[];
dev_h_angle_tmp_ULA=[];

dev_h_fading_ULA=[];
dev_h_delay_ULA=[];
dev_h_angle_ULA=[];

for Nr_index_ULA=1:Nr_ULA;
Br_fading_ULA = spec_chan_derive_fading_ULA(fading,delay,DOA_Phi,d_nor,Nr_index_ULA,L,M,Nt);
dev_h_fading_ULA=[dev_h_fading_ULA; transpose(Br_fading_ULA)];

Br_delay_ULA = spec_chan_derive_delay_ULA(fading,delay,DOA_Phi,d_nor,Nr_index_ULA,L,M,Nt);
dev_h_delay_ULA=[dev_h_delay_ULA; transpose(Br_delay_ULA)];

Br_angle_ULA = spec_chan_derive_angle_ULA(fading,delay,DOA_Phi,d_nor,Nr_index_ULA,L,M,Nt);
dev_h_angle_ULA=[dev_h_angle_ULA; transpose(Br_angle_ULA)];
end

%% Derivation of $h$ w.r.t. (bar{h},tau,alpha) %% channel specular parameters
G_ULA = [dev_h_fading_ULA,dev_h_delay_ULA,dev_h_angle_ULA]; 

%=========================================
%UCA3D
Nr_UCA3D=64;
R_nor_UCA3D=0.5*d_nor/sin(pi/Nr_UCA3D);

dev_h_fading_tmp_UCA3D=[];
dev_h_delay_tmp_UCA3D=[];
dev_h_angle_tmp_UCA3D=[];

dev_h_fading_UCA3D=[];
dev_h_delay_UCA3D=[];
dev_h_angle_Phi_UCA3D=[];
dev_h_angle_Theta_UCA3D=[];


for Nr_index_UCA3D=1:Nr_UCA3D;
Br_fading_UCA3D = spec_chan_derive_fading_UCA3D(fading,delay,DOA_Phi,DOA_Theta,R_nor_UCA3D,Nr_index_UCA3D,Nr_UCA3D,L,M,Nt);
dev_h_fading_UCA3D=[dev_h_fading_UCA3D; transpose(Br_fading_UCA3D)];

Br_delay_UCA3D = spec_chan_derive_delay_UCA3D(fading,delay,DOA_Phi,DOA_Theta,R_nor_UCA3D,Nr_index_UCA3D,Nr_UCA3D,L,M,Nt);
dev_h_delay_UCA3D=[dev_h_delay_UCA3D; transpose(Br_delay_UCA3D)];

Br_angle_Phi_UCA3D = spec_chan_derive_angle_Phi_UCA3D(fading,delay,DOA_Phi,DOA_Theta,R_nor_UCA3D,Nr_index_UCA3D,Nr_UCA3D,L,M,Nt);
dev_h_angle_Phi_UCA3D=[dev_h_angle_Phi_UCA3D; transpose(Br_angle_Phi_UCA3D)];

Br_angle_Theta_UCA3D = spec_chan_derive_angle_Theta_UCA3D(fading,delay,DOA_Phi,DOA_Theta,R_nor_UCA3D,Nr_index_UCA3D,Nr_UCA3D,L,M,Nt);
dev_h_angle_Theta_UCA3D=[dev_h_angle_Theta_UCA3D; transpose(Br_angle_Theta_UCA3D)];

end

%% Derivation of $h$ w.r.t. (bar{h},tau,alpha) %% channel specular parameters
G_UCA3D = [dev_h_fading_UCA3D,dev_h_delay_UCA3D,dev_h_angle_Phi_UCA3D,dev_h_angle_Theta_UCA3D];

%=========================================
%Hex
Nr_UCA_Hex = 8; % number of receive antennas of UCA
Nr_ring = 8;  % number of rings
d_ring_nor=0.5;
d_UCA_nor=0.5;

R_nor=0.5*d_UCA_nor/sin(pi/Nr_UCA_Hex)+d_ring_nor*(0:1:(Nr_ring-1));

dev_h_fading_tmp_Hex=[];
dev_h_delay_tmp_Hex=[];
dev_h_angle_tmp_Hex=[];

dev_h_fading_Hex=[];
dev_h_delay_Hex=[];
dev_h_angle_Phi_Hex=[];
dev_h_angle_Theta_Hex=[];

for Nr_ring_index=1:Nr_ring
    for Nr_UCA_index_Hex=1:Nr_UCA_Hex
Br_fading_Hex = spec_chan_derive_fading_Hex(fading,delay,DOA_Phi,DOA_Theta,R_nor,Nr_UCA_index_Hex,Nr_ring_index,Nr_UCA_Hex,L,M,Nt);
dev_h_fading_Hex=[dev_h_fading_Hex; transpose(Br_fading_Hex)];

Br_delay_Hex = spec_chan_derive_delay_Hex(fading,delay,DOA_Phi,DOA_Theta,R_nor,Nr_UCA_index_Hex,Nr_ring_index,Nr_UCA_Hex,L,M,Nt);
dev_h_delay_Hex=[dev_h_delay_Hex; transpose(Br_delay_Hex)];

Br_angle_Phi_Hex = spec_chan_derive_angle_Phi_Hex(fading,delay,DOA_Phi,DOA_Theta,R_nor,Nr_UCA_index_Hex,Nr_ring_index,Nr_UCA_Hex,L,M,Nt);
dev_h_angle_Phi_Hex=[dev_h_angle_Phi_Hex; transpose(Br_angle_Phi_Hex)];

Br_angle_Theta_Hex = spec_chan_derive_angle_Theta_Hex(fading,delay,DOA_Phi,DOA_Theta,R_nor,Nr_UCA_index_Hex,Nr_ring_index,Nr_UCA_Hex,L,M,Nt);
dev_h_angle_Theta_Hex=[dev_h_angle_Theta_Hex; transpose(Br_angle_Theta_Hex)];
    end
end

%% Derivation of $h$ w.r.t. (bar{h},tau,alpha) %% channel specular parameters
G_Hex = [dev_h_fading_Hex,dev_h_delay_Hex,dev_h_angle_Phi_Hex,dev_h_angle_Theta_Hex]; 

%=========================================
%UCyA
Nr_UCA_UCyA = 8; % number of receive antennas of UCA
Nr_ULA_UCyA = 8;  % number of receive antennas of UCA

d_ULA_nor_UCyA=0.5;
d_UCA_nor_UCyA=0.5;
R_nor_UCyA=0.5*d_UCA_nor_UCyA/sin(pi/Nr_UCA_UCyA);

dev_h_fading_tmp_UCyA=[];
dev_h_delay_tmp_UCyA=[];
dev_h_angle_tmp_UCyA=[];
%dev_h_fading_tmp=cell(Nr,1);

dev_h_fading_UCyA=[];
dev_h_delay_UCyA=[];
dev_h_angle_Phi_UCyA=[];
dev_h_angle_Theta_UCyA=[];

for Nr_ULA_index_UCyA=1:Nr_ULA_UCyA
    for Nr_UCA_index_UCyA=1:Nr_UCA_UCyA
   
Br_fading_UCyA = spec_chan_derive_fading_UCyA(fading,delay,DOA_Phi,DOA_Theta,R_nor_UCyA,d_ULA_nor_UCyA,Nr_UCA_index_UCyA,Nr_ULA_index_UCyA,Nr_UCA_UCyA,Nr_ULA_UCyA,L,M,Nt);
dev_h_fading_UCyA=[dev_h_fading_UCyA; transpose(Br_fading_UCyA)];

Br_delay_UCyA = spec_chan_derive_delay_UCyA(fading,delay,DOA_Phi,DOA_Theta,R_nor_UCyA,d_ULA_nor_UCyA,Nr_UCA_index_UCyA,Nr_ULA_index_UCyA,Nr_UCA_UCyA,Nr_ULA_UCyA,L,M,Nt);
dev_h_delay_UCyA=[dev_h_delay_UCyA; transpose(Br_delay_UCyA)];

Br_angle_Phi_UCyA = spec_chan_derive_angle_Phi_UCyA(fading,delay,DOA_Phi,DOA_Theta,R_nor_UCyA,d_ULA_nor_UCyA,Nr_UCA_index_UCyA,Nr_ULA_index_UCyA,Nr_UCA_UCyA,Nr_ULA_UCyA,L,M,Nt);
dev_h_angle_Phi_UCyA=[dev_h_angle_Phi_UCyA; transpose(Br_angle_Phi_UCyA)];

Br_angle_Theta_UCyA = spec_chan_derive_angle_Theta_UCyA(fading,delay,DOA_Phi,DOA_Theta,R_nor_UCyA,d_ULA_nor_UCyA,Nr_UCA_index_UCyA,Nr_ULA_index_UCyA,Nr_UCA_UCyA,Nr_ULA_UCyA,L,M,Nt);
dev_h_angle_Theta_UCyA=[dev_h_angle_Theta_UCyA; transpose(Br_angle_Theta_UCyA)];
   
    end
end

%% Derivation of $h$ w.r.t. (bar{h},tau,alpha) %% channel specular parameters
G_UCyA = [dev_h_fading_UCyA,dev_h_delay_UCyA,dev_h_angle_Phi_UCyA,dev_h_angle_Theta_UCyA]; 
%=========================================
%=========================================
%% CRB 
% Loop SNR
SNR = -10:5:30;
for snr_i = 1 : length(SNR)
    sigmav2 = 10^(-SNR(snr_i)/10);
    %% Perfect Specificiation 
%=========================================
%ULA
    X_nga_ULA=kron(eye(Nr_ULA),X);
    Iop_ULA      = X_nga_ULA'*X_nga_ULA/sigmav2;
    Iop_spec_ULA = ((-1)/(sigmav2)^2)*G_ULA*G_ULA'* X_nga_ULA'*sigmav2*eye(Nr_ULA*K)*X_nga_ULA*G_ULA*G_ULA';
    CRB_op_ULA(snr_i) = abs(trace(pinv(Iop_ULA)));
    CRB_op_spec_ULA(snr_i) = abs(trace(pinv(Iop_spec_ULA)));

%UCA3D
    X_nga_UCA3D=kron(eye(Nr_UCA3D),X);
    Iop_UCA3D      = X_nga_UCA3D'*X_nga_UCA3D/sigmav2;
    Iop_spec_UCA3D = ((-1)/(sigmav2)^2)*G_UCA3D*G_UCA3D'* X_nga_UCA3D'*sigmav2*eye(Nr_UCA3D*K)*X_nga_UCA3D*G_UCA3D*G_UCA3D';
    CRB_op_UCA3D(snr_i) = abs(trace(pinv(Iop_UCA3D)));
    CRB_op_spec_UCA3D(snr_i) = abs(trace(pinv(Iop_spec_UCA3D)));
      
%Hex
    X_nga_Hex=kron(eye(Nr_ring*Nr_UCA_Hex),X);
    Iop_Hex      = X_nga_Hex'*X_nga_Hex / sigmav2;
    Iop_spec_Hex = ((-1)/(sigmav2)^2)*G_Hex*G_Hex'* X_nga_Hex'*sigmav2*eye(Nr_ring*Nr_UCA_Hex*K)*X_nga_Hex*G_Hex*G_Hex';
    CRB_op_Hex(snr_i) = abs(trace(pinv(Iop_Hex)));
    CRB_op_spec_Hex(snr_i) = abs(trace(pinv(Iop_spec_Hex)));
      
%UCyA   
    X_nga_UCyA=kron(eye(Nr_UCA_UCyA*Nr_ULA_UCyA),X);
    Iop_UCyA      = X_nga_UCyA'*X_nga_UCyA / sigmav2;
    Iop_spec_UCyA = ((-1)/(sigmav2)^2)*G_UCyA*G_UCyA'* X_nga_UCyA'*sigmav2*eye(Nr_UCA_UCyA*Nr_ULA_UCyA*K)*X_nga_UCyA*G_UCyA*G_UCyA';
    CRB_op_UCyA(snr_i) = abs(trace(pinv(Iop_UCyA)));
    CRB_op_spec_UCyA(snr_i) = abs(trace(pinv(Iop_spec_UCyA)));
    
end
%=========================================
%Figure
semilogy(SNR,CRB_op_ULA,'-b')
hold on; 
semilogy(SNR,CRB_op_spec_ULA,'-r')
hold on; 

semilogy(SNR,CRB_op_UCA3D,'-g')
hold on; 
semilogy(SNR,CRB_op_spec_UCA3D,'-m')
hold on; 

semilogy(SNR,CRB_op_Hex,'-b>')
hold on; 
semilogy(SNR,CRB_op_spec_Hex,'-r+')
hold on; 

semilogy(SNR,CRB_op_UCyA,'-g>')
hold on; 
semilogy(SNR,CRB_op_spec_UCyA,'-m+')
hold on; 


grid on
ylabel('Normalized CRB')
xlabel('SNR(dB)')
legend('usual OP ULA','spec OP ULA','usual OP UCA3D','spec OP UCA3D','usual OP Hex','spec OP Hex','usual OP UCyA','spec OP UCyA')
title(' ')
hold on;