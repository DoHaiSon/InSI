function [SNR, Err] = NB_Normal (Op, Monte, SNR)

% Initialize variables
Nt  = Op{1};    % number of transmit antennas
Nr  = Op{2};    % number of receive antennas
L   = Op{3};    % channel order
M   = Op{4};    % Number of multipaths 
K   = Op{5};    % OFDM subcarriers
ratio = Op{6};  % Pilot/Data Power ratio

Monte   = Monte;
SNR     = SNR;

F  = dftmtx(K);
FL  = F(:,1:L);
sigmax2=1;

%% Signal Generation
% we use the Zadoff-Chu sequences
U = 1:2:7;
ZC_p = [];
for u = 1 : Nt
    for k = 1 : K
        ZC(k,u) = ratio * exp( ( -1i * pi * U(u) * (k-1)^2 ) / K );
    end
    ZC_p = [ZC_p; ZC(:,u)];
end

%% Channel generation: In this time, channel effects are fixed.
% Fading, delay, DOA matrix of size(M,Nt), M - the number of multipath
X = [];
for ii = 1 : Nt
    X        = [X diag(ZC(:,ii))*FL];
end


%% CRB 
% Loop SNR
N_total = 4;
N_pilot = 2;
N_data  = N_total-N_pilot;
%============================================
for snr_i = 1 : length(SNR)
    sigmav2 = 10^(-SNR(snr_i)/10);
%============================================
    %Only Pilot    
    X_nga=kron(eye(Nr),X);
%============================================
    %Only Pilot Normal
    Iop      = X_nga'*X_nga / sigmav2;
    Iop_fp   = N_total * Iop;
    Err(snr_i) = abs(trace(pinv(Iop_fp)));
end