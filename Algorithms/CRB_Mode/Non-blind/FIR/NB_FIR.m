function [SNR, Err] = NB_FIR (Op, Monte, SNR)

%% Finite Impulse Response
%
%% Input:
    % + 1. Nt: number of transmit antennas
    % + 2. Nr: number of receive antennas
    % + 3. L: channel order
    % + 4. K: OFDM subcarriers
    % + 5. ratio: Pilot/Data Power ratio
    % + 6. Monte: simulation times
    % + 7. SNR: range of the SNR
%
%% Output:
    % + SNR: range of the SNR
    % + Err: CRB
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Return 
%
% Ref:

% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 08-Jun-2023 16:52:13 


% Initialize variables
Nt  = Op{1};    % number of transmit antennas
Nr  = Op{2};    % number of receive antennas
L   = Op{3};    % channel order
K   = Op{4};    % OFDM subcarriers
ratio = Op{5};  % Pilot/Data Power ratio

Monte   = Monte;
SNR     = SNR;

F  = dftmtx(K);
FL  = F(:,1:L);
sigmax2=1;

Err_f = [];
for Monte_i = 1:Monte
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
    Err_SNR = [];
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
        Err_SNR(snr_i) = abs(trace(pinv(Iop_fp)));
    end
    Err_f = [Err_f; Err_SNR];
end

% Return
if Monte ~= 1
    Err = mean(Err_f);
else
    Err = Err_f;
end

end