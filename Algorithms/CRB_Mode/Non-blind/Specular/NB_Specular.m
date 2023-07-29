function Err = NB_Specular (Op, SNR_i)

%% Specular / Parametric
%
%% Input:
    % + 1. Nt: number of transmit antennas
    % + 2. Nr: number of receive antennas
    % + 3. L: channel order
    % + 4. M: number of multi-paths
    % + 5. K: OFDM subcarriers
    % + 6. ratio: Pilot/Data Power ratio
    % + 7. SNR_i: signal noise ratio
%
%% Output:
    % + 1. Err: CRB
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Return 
%
% Ref: O. Rekik, A. Mokraoui, T. T. Thuy Quynh, T. -T. Le and 
% K. Abed-Meraim, "Side Information Effect on Semi-Blind Channel
% Identification for MIMO-OFDM Communications Systems," in 55th
% Asilomar Conference on Signals, Systems, and Computers,
% Pacific Grove, CA, USA, 2021, pp. 443-448.
%
%% Require R2006A

% Author: Le Trung Thanh, Vietnam National University, Hanoi, Vietnam

% Adapted for InSI by Do Hai Son, 29-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless communication systems
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


% Initialize variables
Nt  = Op{1};    % number of transmit antennas
Nr  = Op{2};    % number of receive antennas
L   = Op{3};    % channel order
M   = Op{4};    % Number of multipaths 
K   = Op{5};    % OFDM subcarriers
ratio = Op{6};  % Pilot/Data Power ratio
F  = dftmtx(K);
FL  = F(:,1:L);


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
fading = rand(M,Nt)+1i*rand(M,Nt);
delay  = 0.1+(0.15-0.1)*rand(M,Nt)*0.01;
DOA    = (-0.5+(0.5-(-0.5))*rand(M,Nt))*pi;
d_nor=1/2;

dev_h_fading=[];
dev_h_delay=[];
dev_h_angle=[];

for Nr_index=1:Nr
    Br_fading = SEMI_spec_chan_derive_fading_ULA(fading,delay,DOA,d_nor,Nr_index,L,M,Nt);
    dev_h_fading=[dev_h_fading; transpose(Br_fading)];

    Br_delay = SEMI_spec_chan_derive_delay_ULA(fading,delay,DOA,d_nor,Nr_index,L,M,Nt);
    dev_h_delay=[dev_h_delay; transpose(Br_delay)];

    Br_angle = SEMI_spec_chan_derive_angle_ULA(fading,delay,DOA,d_nor,Nr_index,L,M,Nt);
    dev_h_angle=[dev_h_angle; transpose(Br_angle)];

end

%% Derivation of $h$ w.r.t. (bar{h},tau,alpha) 
% channel specular parameters

G = [dev_h_fading,dev_h_delay,dev_h_angle]; 
%% ------------------------------------------------------------------------

X = [];
for ii = 1 : Nt
    X        = [X diag(ZC(:,ii))*FL];
end

% Generate channel
H = Generate_channel(0, L, 3, Nt, Nr, fading, delay, DOA);
    
    
%% CRB     
%LAMBDA
LAMBDA  = [];
for jj = 1 : Nt
    lambda_j =[];
    for r = 1 : Nr
        h_rj       = transpose(H(r,:,jj));
        lambda_rj  = diag(FL*h_rj);
        lambda_j   = [lambda_j; lambda_rj];
    end
    LAMBDA = [LAMBDA lambda_j];
end

% Partial derivative of LAMBDA w.r.t. h_i
partial_LAMBDA  = cell(1,L);
for ll = 1 : L
    partial_LAMBDA_ll = [];
    for jj = 1 : Nt
        lambda_jj =[];
        for r = 1 : Nr
            lambda_rj_ll = diag(FL(:,ll));
            lambda_jj    = [lambda_jj; lambda_rj_ll];
        end
    partial_LAMBDA_ll = [partial_LAMBDA_ll lambda_jj];
    end
    partial_LAMBDA{1, ll} =  partial_LAMBDA_ll;
end


N_total = 4;
N_pilot = 2;
N_data  = N_total-N_pilot;


sigmav2 = 10^(-SNR_i/10);

% Only Pilot    
X_nga=kron(eye(Nr),X);

% Only Pilot Normal
Iop      = X_nga'*X_nga / sigmav2;
Iop_fp   = N_total * Iop;

% Only Pilot Specular
Iop_spec = G*G'*Iop_fp*G*G';
Err      = abs(trace(pinv(Iop_spec)));

end