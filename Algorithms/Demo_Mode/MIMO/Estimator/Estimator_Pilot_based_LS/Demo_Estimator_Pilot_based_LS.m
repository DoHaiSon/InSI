function Err = Demo_Estimator_Pilot_based_LS(Op, SNR_i, Output_type)

%% Least-squares
%
%% Input:
    % + 1. Ns: number of sample data
    % + 2. Nt: number of transmit antennas
    % + 3. Nr: number of receive antennas
    % + 4. M: length of the channel
    % + 5. Ch_type: type of the channel (real, complex,
    % user's input)
    % + 6. Mod_type: type of modulation (All)
    % + 7. Np: number of pilot symbols
    % + 8. SNR_i: signal noise ratio
    % + 9. Output_type: SER / BER / MSE Channel
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
Np        = Op{7};     % number of pilot symbols 


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


% --- received signal strength ----------------------------------
Pr = norm(sig_cap_sans_bruit,'fro').^2/numel(sig_cap_sans_bruit);

sigmav2 = 10^((10*log10(Pr)-SNR_i)/10); % noise variance for received signal

noise = sqrt(sigmav2)*(randn(Nr,Ns) + randn(Nr,Ns)*1i)/sqrt(2);

sig_cap = sig_cap_sans_bruit + noise;

%----------------- pilot-based initialization -------------------
canauxp  = sig_cap(:,1:Np)*pinv(S_mat(:,1:Np));

%% Vectorize estimated channels
channels_vec_ls = reshape(canauxp, [],1); % h_{LS}

%% Data detection
est_src = pinv(canauxp)*sig_cap;
est_src = est_src(1, :);

% Compute SER / BER / MSE channel
if Output_type ~= 4
    Err = ER_func(D_mat(1,:), est_src, Mod_type, Output_type);
else
    Err = ER_func(channels_vec.', channels_vec_ls, Mod_type, Output_type);
end

end