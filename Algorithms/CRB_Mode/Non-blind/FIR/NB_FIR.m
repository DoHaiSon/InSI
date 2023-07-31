function Err = NB_FIR (Op, SNR_i)

%% Finite Impulse Response
%
%% Input:
    % + 1. Nt: number of transmit antennas
    % + 2. Nr: number of receive antennas
    % + 3. L: channel order
    % + 4. K: OFDM subcarriers
    % + 5. ratio: Pilot/Data Power ratio
    % + 6. SNR_i: signal noise ratio
%
%% Output:
    % + 1. Err: CRB
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Return 
%
% Ref: S. M. Kay, Fundamentals of Statistical Signal Processing: 
% Estimation Theory. USA: Prentice-Hall, Inc., 1993.
%
%% Require R2006A

% Author: Le Trung Thanh, Vietnam National University, Hanoi, Vietnam

% Adapted for InSI by Do Hai Son, 29-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless Communications
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


% Initialize variables
Nt  = Op{1};    % number of transmit antennas
Nr  = Op{2};    % number of receive antennas
L   = Op{3};    % channel order
K   = Op{4};    % OFDM subcarriers
ratio = Op{5};  % Pilot/Data Power ratio
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
X = [];
for ii = 1 : Nt
    X        = [X diag(ZC(:,ii))*FL];
end
    
    
%% CRB 
N_total = 4;
N_pilot = 2;
N_data  = N_total-N_pilot;

sigmav2 = 10^(-SNR_i/10);

% Only Pilot    
X_nga=kron(eye(Nr),X);

% Only Pilot Normal
Iop      = X_nga'*X_nga / sigmav2;
Iop_fp   = N_total * Iop;
Err      = abs(trace(pinv(Iop_fp)));

end