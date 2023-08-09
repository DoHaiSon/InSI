function Err = SB_EM_Nonlinear_MIMO(Op, SNR_i, Output_type)

%% Semi-blind Expectation-Maximization for Non-linear MIMO communications
%
%% Input:
    % + 1. Ns: number of sample data
    % + 2. Nt: number of transmit antennas
    % + 3. Nr: number of receive antennas
    % + 4. M: length of the channel
    % + 5. Ch_type: type of the channel (real, complex,
    % user's input)
    % + 6. Mod_type: type of modulation (All)
    % + 7. Threshold: threshold of EM algorithm
    % + 8. Np: number of pilot symbols
    % + 9. N_iter_max: number of maximum iterations EM 
    % + 10. SNR_i: signal noise ratio
    % + 11. Output_type: SER / BER / MSE Channel
%
%% Output:
    % + 1. Err: SER / BER / MSE Channel
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


% Initialize variables
Ns        = Op{1};     % number of sig sequences
Nt        = Op{2};     % number of transmit antennas
Nr        = Op{3};     % number of receive antennas
M         = Op{4};     % length of the channel
Ch_type   = Op{5};     % complex
Mod_type  = Op{6};     
threshold = Op{7};     % threshold of EM algorithm
Np        = Op{8};     % number of pilot symbols 
N_iter_max= Op{9};     % number of maximum iterations EM 
Np_init   = Np;


% Generate input signal
modulation = {'Bin', 'QPSK', 'QAM4', 'QAM16', 'QAM64', 'QAM128', 'QAM256'};

% Generate channel
if Ch_type == 2
    channels_mat = Generate_channel(Nr, Nt * 2*(M+1) - 1, Ch_type) * sqrt(2);
else
    channels_mat = Generate_channel(Nr, Nt * 2*(M+1) - 1, Ch_type);
end
channels_vec = reshape(channels_mat, [], 1); % vectorize channel matrix

% Generate signals
[sig_src, data] = eval(strcat(modulation{Mod_type}, '(1000)'));
alphabet = unique(sig_src);
P = length(alphabet);
average_energy_per_symb = norm(alphabet)^2/P; % or: 2/3*(P-1);
alphabet = alphabet/sqrt(average_energy_per_symb); % normalization

%% transitions, predecessors, successors
trans1 = SB_EM_cal_trans(alphabet, Nt*(M+1));
trans2 = trans1.^2;                % quadratic model
trans  = [trans1; trans2];
nbr_etats    = P^(Nt*M); %number of states
successors   = zeros(nbr_etats,P^Nt);
predecessors = zeros(nbr_etats,P^Nt);
tableau = zeros(P^(Nt*(M+1)),2); % tableau(:,1)-->predecesseurs (i) ,tableau(:,2)-->successeurs (j)

for i=1:nbr_etats
    predecessors(i,:) = SB_EM_PredecessorsMIMO( i ,P, M, Nt );
    [itransPred,~]    = SB_EM_FindTransitionsPredMIMO(predecessors(i,:),i,M, P, Nt );
    tableau(itransPred,2) = i; 
    
    successors(i,:)   = SB_EM_SuccessorsMIMO( i ,P, M, Nt );
    [itransSuccess,~] = SB_EM_FindTransitionsSuccessMIMO(i,successors(i,:),M, P, Nt );
    tableau(itransSuccess,1) = i;
end

%% Transmitted signal
S = [];
D = [];

for i = 1:Nt
    [sig_src, data] = eval(strcat(modulation{Mod_type}, '(Ns + M)'));
    S = [S; sig_src.'];
    D = [D; data.'];
end
S_decim = D;
S       = S/sqrt(average_energy_per_symb);

Stop1 = toeplitz(S(1,M+1:-1:1),S(1,M+1:Ns+M));
D_Stop1 = toeplitz(S_decim(1,M+1:-1:1),S_decim(1,M+1:Ns+M));

if Nt==1
    S_mat = [Stop1; Stop1.^2];

    D_mat = [D_Stop1; D_Stop1.^2];
else    
    Stop2 = toeplitz(S(2,M+1:-1:1),S(2,M+1:Ns+M));
    S_mat = [Stop1; Stop2; Stop1.^2; Stop2.^2];

    D_Stop2 = toeplitz(S_decim(2,M+1:-1:1), S_decim(2,M+1:Ns+M));
    D_mat = [D_Stop1; D_Stop2; D_Stop1.^2; D_Stop2.^2];
end

%% Received signal
sig_cap_sans_bruit = channels_mat*S_mat;

% ... pilots
Sp = [];
Dp = [];

for i = 1:Nt
    [sig_src, data] = eval(strcat(modulation{Mod_type}, '(Ns + M)'));
    Sp = [Sp; sig_src.'];
    Dp = [Dp; data.'];
end
Sp_decim = Dp;
Sp       = Sp/sqrt(average_energy_per_symb);

Stop1p = toeplitz(Sp(1,M+1:-1:1),Sp(1,M+1:Np+M));
if Nt==1
    Sp_mat = [Stop1p; Stop1p.^2];   
else 
    Stop2p = toeplitz(Sp(2,M+1:-1:1), Sp(2,M+1:Np+M));
    Sp_mat = [Stop1p; Stop2p; Stop1p.^2; Stop2p.^2];
end
sigp_cap_sans_bruit = channels_mat*Sp_mat;

% --- received signal strength ----------------------------------
Pr = norm(sig_cap_sans_bruit,'fro').^2/numel(sig_cap_sans_bruit);

sigmav2 = 10^((10*log10(Pr)-SNR_i)/10); % noise variance for received signal

noise = sqrt(sigmav2)*(randn(Nr,Ns) + randn(Nr,Ns)*1i)/sqrt(2);

sig_cap = sig_cap_sans_bruit + noise;
sigcap_pilot = sigp_cap_sans_bruit + noise(:,1:Np); %noisep;

%----------------- pilot-based initialization -------------------
canauxp  = sig_cap(:,1:Np_init)*pinv(S_mat(:,1:Np_init));

%-------------------------- SB EM -------------------------------
[probaSB, ~, channels_mat_EM_SB, ~] = ...
    SB_EM_func(sig_cap.', trans, sigcap_pilot, Sp_mat, canauxp, sigmav2, ...
    predecessors, successors, tableau, N_iter_max, threshold,Nt); % SB-EM

%% Test NaN values
if any(isnan(channels_mat_EM_SB))
    channels_mat_EM_SB = canauxp;
    compteur_sb(SNRidx,1) = compteur_sb(SNRidx,1)+1;
end

%% Vectorize estimated channels
channels_vec_EM_SB = reshape(channels_mat_EM_SB, [],1); % h_{EM-SB} semi-blind

%% Data detection
est_src = SB_EM_min_symbol_errorMIMO(probaSB,alphabet,M,Nt);

% Compute SER / BER / MSE channel
if Output_type ~= 4
    Err = ER_func(D_mat(1,:).', est_src, Mod_type, Output_type);
else
    Err = ER_func(channels_vec.', channels_vec_EM_SB, Mod_type, Output_type);
end

end