function Err = SI_Structured (Op, SNR_i)

%% CRB for structured channel model
%
%% Input:
    % + 1. Nt: number of transmit antennas
    % + 2. Nr: number of receive antennas
    % + 3. config: configuration of antenna arrays 
    % + 4. Nr_UCA: number of antennas per UCA (UCyA)
    % + 5. Nr_ULA: number of layers ULA (UCyA)
    % + 6. L: number of paths
    % + 7. K: number of OFDM subcarriers
    % + 8. M: number of pilot symbols per OFDM symbol
    % + 9. method: OP / SB
    % + 10. SNR_i: signal noise ratio
%
%% Output:
    % + 1. Err: CRB
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Return 
%
% Ref: Do Hai Son and Tran Thi Thuy Quynh, "Impact Analysis of 
% Antenna Array Geometry on Performance of Semi-blind Structured
% Channel Estimation for massive MIMO-OFDM systems," in 2023 IEEE
% Statistical Signal Processing Workshop (SSP), Hanoi, Vietnam,
% Jul. 2023, pp. 314-318.
%
%% Require R2006A

% Author: Do Hai Son, Vietnam National University, Hanoi, Vietnam

% Adapted for InSI by Do Hai Son, 30-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless Communications
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


% Initialize variables
Nt  = Op{1};    % number of transmit antennas
Nr  = Op{2};    % number of receive antennas
config = Op{3}; % configuration of antenna arrays 
Nr_UCA = Op{4}; % number of antennas per UCA (UCyA)
Nr_ULA = Op{5}; % number of layers ULA (UCyA)
L   = Op{6};    % number of paths
K   = Op{7};    % number of OFDM subcarriers
M   = Op{8};    % number of pilot symbols per OFDM symbol
method = Op{9}; % OP / SB
F   = dftmtx(K);
FL  = F(:, 1:1);
Pxp = 1;
sigmax2 = 1; 

%% Signal Generation
% we use the Zadoff-Chu sequences
U = 1:2:100;
ZC_p = [];
for u = 1 : Nt
    for k = 1 : K
        ZC(k,u) = sqrt(Pxp) * exp( ( -1i * pi * U(u) * (k-1)^2 ) / K );
    end
    ZC_p = [ZC_p; ZC(:,u)];
end
    
%% Channel generation: In this time, channel effects are fixed.
% Fading, delay, DOA matrix of size(M,Nt), M - the number of multipath
X = [];
for ii = 1 : Nt
    X  = [X diag(ZC(:,ii))*FL];
end

%% Channel generation
gamma       = zeros(L, Nt);      % complex gain
ZOA         = zeros(L, Nt);      % ffset ZOA ray
AOA         = zeros(L, Nt);      % offset AOA ray
    
for nt = 1 : Nt
    gamma(:, nt)   = sqrt(0.5)*(normrnd(0,1,1,L) + 1j*normrnd(0,1,1,L));
    while min(abs(gamma(:, nt)))<0.6
          gamma(:, nt)   = sqrt(0.5)*(normrnd(0,1,1,L) + 1j*normrnd(0,1,1,L));
    end
    
    AOA(:, nt)     = random('unif',0,1,1,L)*pi-pi/2; 
    dist=pdist(vec(AOA(:, nt)),'euclid');
    while min(dist) < pi/18
          AOA(:, nt)=random('unif',0,1,1,L)*pi-pi/2;
          dist=pdist(vec(AOA(:, nt)),'euclid');
    end

    ZOA(:, nt)     = random('unif',0,1,1,L)*pi-pi/2; 
    dist=pdist(vec(ZOA(:, nt)),'euclid');
    while min(dist) < pi/18
          ZOA(:, nt)=random('unif',0,1,1,L)*pi-pi/2;
          dist=pdist(vec(ZOA(:, nt)),'euclid');
    end
end   
    
%% Generate position of elements in arrays
d_ULA_nor   = 0.5;
d_UCA_nor   = 0.5;
R_nor       = 0.5 * d_UCA_nor/sin(pi/Nr_UCA);
ULA_elements_nor    = zeros(3, 1, Nr);
UCyA_elements_nor   = zeros(3, Nr_ULA, Nr_UCA);

if config == 1    %% ULA
    for Nr_index=1:Nr
        ULA_elements_nor(1, 1, Nr_index) = (Nr_index-1) * d_UCA_nor;
        ULA_elements_nor(2, 1, Nr_index) = 0;
        ULA_elements_nor(3, 1, Nr_index) = 0;
    end

    %% Derivative
    dev_h_gamma_ULA     = [];
    dev_h_gamma_H_ULA   = [];
    dev_h_ZOA_ULA       = [];
    dev_h_AOA_ULA       = [];

    for Nr_index=1:Nr
        Br_gamma                = SI_Structured_derive_gamma(   gamma, AOA, ZOA, ULA_elements_nor(:, 1, Nr_index), L, Nt);
        dev_h_gamma_ULA         = [dev_h_gamma_ULA; transpose(Br_gamma)];

        Br_gamma_H              = SI_Structured_derive_gamma_H( gamma, AOA, ZOA, ULA_elements_nor(:, 1, Nr_index), L, Nt);
        dev_h_gamma_H_ULA       = [dev_h_gamma_H_ULA; transpose(Br_gamma_H)];
        
        Br_angle_ZOA            = SI_Structured_derive_ZOA(     gamma, AOA, ZOA, ULA_elements_nor(:, 1, Nr_index), L, Nt);
        dev_h_ZOA_ULA           = [dev_h_ZOA_ULA; transpose(Br_angle_ZOA)];

        Br_angle_AOA            = SI_Structured_derive_AOA(     gamma, AOA, ZOA, ULA_elements_nor(:, 1, Nr_index), L, Nt);
        dev_h_AOA_ULA           = [dev_h_AOA_ULA; transpose(Br_angle_AOA)];
    end

    %% Derivation of $h$ w.r.t. (bar{h},tau,alpha) %% channel specular parameters
    G_ULA   = [dev_h_gamma_ULA,  dev_h_gamma_H_ULA,  dev_h_ZOA_ULA,  dev_h_AOA_ULA]; 

    %% Partial lambda
    [H_ULA,  h_true_ULA,  LAMBDA_ULA,  partial_LAMBDA_ULA]  = SI_Structured_partial_LAMBDA_ULA ( gamma, AOA, ZOA, ULA_elements_nor,  Nt, Nr, L, FL);

else   %% UCyA
    for Nr_ULA_index=1:Nr_ULA
        for Nr_UCA_index=1:Nr_UCA
            UCyA_elements_nor(1, Nr_ULA_index, Nr_UCA_index) = R_nor * sin((Nr_UCA_index-1)*(2*pi/Nr_UCA)) ;         % x
            UCyA_elements_nor(2, Nr_ULA_index, Nr_UCA_index) = R_nor * cos((Nr_UCA_index-1)*(2*pi/Nr_UCA)) ;         % y
            UCyA_elements_nor(3, Nr_ULA_index, Nr_UCA_index) = (Nr_ULA_index-1) * d_ULA_nor;                         % z
        end
    end

    %% Derivative
    dev_h_gamma_UCyA    = [];
    dev_h_gamma_H_UCyA  = [];
    dev_h_ZOA_UCyA      = [];
    dev_h_AOA_UCyA      = [];

    for Nr_ULA_index=1:Nr_ULA
        for Nr_UCA_index=1:Nr_UCA
            Br_gamma            = SI_Structured_derive_gamma(   gamma, AOA, ZOA, UCyA_elements_nor(:, Nr_ULA_index, Nr_UCA_index), L, Nt);
            dev_h_gamma_UCyA    = [dev_h_gamma_UCyA; transpose(Br_gamma)];

            Br_gamma_H          = SI_Structured_derive_gamma_H( gamma, AOA, ZOA, UCyA_elements_nor(:, Nr_ULA_index, Nr_UCA_index), L, Nt);
            dev_h_gamma_H_UCyA  = [dev_h_gamma_H_UCyA; transpose(Br_gamma_H)];

            Br_angle_ZOA        = SI_Structured_derive_ZOA(     gamma, AOA, ZOA, UCyA_elements_nor(:, Nr_ULA_index, Nr_UCA_index), L, Nt);
            dev_h_ZOA_UCyA      = [dev_h_ZOA_UCyA; transpose(Br_angle_ZOA)];

            Br_angle_AOA        = SI_Structured_derive_AOA(     gamma, AOA, ZOA, UCyA_elements_nor(:, Nr_ULA_index, Nr_UCA_index), L, Nt);
            dev_h_AOA_UCyA      = [dev_h_AOA_UCyA; transpose(Br_angle_AOA)];
        end
    end

    %% Derivation of $h$ w.r.t. (bar{h},tau,alpha) %% channel specular parameters
    G_UCyA  = [dev_h_gamma_UCyA, dev_h_gamma_H_UCyA, dev_h_ZOA_UCyA, dev_h_AOA_UCyA]; 

    %% Partial lambda
    [H_UCyA, h_true_UCyA, LAMBDA_UCyA, partial_LAMBDA_UCyA] = SI_Structured_partial_LAMBDA_UCyA( gamma, AOA, ZOA, UCyA_elements_nor, Nt, Nr_UCA, Nr_ULA, L, FL );
end

%% CRB 
N_total = K;
N_pilot = M;
N_data  = N_total-N_pilot;

sigmav2 = 10^(-SNR_i/10);

% Only Pilot    
X_nga   = kron(eye(Nr), X);

% Only Pilot Normal
Iop     = X_nga' * X_nga / sigmav2;
Iop_full= N_pilot * Iop;

if config == 1    %% ULA
    if method == 1  %% OP
        Iop_spec_ULA            = G_ULA*G_ULA'*Iop_full*G_ULA*G_ULA';
        try
            % Return
            Err  = abs(trace(pinv(Iop_spec_ULA)));
        catch ME
            disp(ME);
        end
    else            %% SB
        LAMBDA   = LAMBDA_ULA;
        partial_LAMBDA = partial_LAMBDA_ULA;
        Cyy      = sigmax2  * LAMBDA  * LAMBDA'   + sigmav2 * eye(K*Nr);
        Cyy_inv  = pinv(Cyy);   
        
        partial_Cyy_hii = sigmax2 * LAMBDA * partial_LAMBDA';
        % Slepian-Bangs Formula
        I_D      = trace(Cyy_inv * partial_Cyy_hii * Cyy_inv * partial_Cyy_hii);
        I_D      = I_D';

        I_D      = triu(repmat(I_D, Nr*Nt, Nr*Nt));
        I_SB     = N_data*I_D+N_pilot*Iop;
        
        I_SB_spec               = G_ULA*G_ULA'*I_SB*G_ULA*G_ULA';
        CRB_SB_spec_i           = pinv(I_SB_spec);

        % Return
        Err  = abs(trace(CRB_SB_spec_i));  
    end
else              %% UCyA
    if method == 1  %% OP
        Iop_spec_UCyA           = G_UCyA*G_UCyA'*Iop_full*G_UCyA*G_UCyA';
        try
            % Return
            Err = abs(trace(pinv(Iop_spec_UCyA)));
        catch ME
            disp(ME);
        end
    else            %% SB
        LAMBDA   = LAMBDA_UCyA;
        partial_LAMBDA = partial_LAMBDA_UCyA;
        Cyy      = sigmax2  * LAMBDA  * LAMBDA'   + sigmav2 * eye(K*Nr);
        Cyy_inv  = pinv(Cyy);   
        
        partial_Cyy_hii = sigmax2 * LAMBDA * partial_LAMBDA';
        % Slepian-Bangs Formula
        I_D      = trace(Cyy_inv * partial_Cyy_hii * Cyy_inv * partial_Cyy_hii);
        I_D      = I_D';

        I_D      = triu(repmat(I_D, Nr*Nt, Nr*Nt));
        I_SB     = N_data*I_D+N_pilot*Iop;

        I_SB_spec               = G_UCyA*G_UCyA'*I_SB*G_UCyA*G_UCyA';
        CRB_SB_spec_i           = pinv(I_SB_spec);

        % Return
        Err = abs(trace(CRB_SB_spec_i));
    end

end

end