function Err = NB_MMSE_OFDM(Op, SNR_i, Output_type)

%% Minimum Mean Square Error - OFDM
%
%% Input:
    % 1. Nfft: number of Occ carriers
    % 2. Pilot_L: number of pilot symbols
    % 3. ChL: length of the channel
    % 4. Ch_type: type of the channel (real, complex, 
    % user's input)
    % 5. Mod_type: type of modulation (All)
    % 6. SNR_i: signal noise ratio
    % 7. Output_type: SER / BER / MSE Signal / MSE Channel
%
%% Output:
    % 1. Err: SER / BER / MSE Signal / MSE Channel
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Generate input signal
    %     X <= h^T * s + n
    % Step 3: Estimate channel
    %     H_est <= Y_pilot ./ X_pilot
    % Step 4: Equalization
    %     X <= Y ./ H_est
    % Step 5: Compute Error rate
    %     Demodulate Y
    %     Compute SER / BER / MSE Signal / MSE Channel
    % Step 6: Return 
%
% Ref: Yong Soo Cho, Jaekwon Kim, Won Young Yang, Chung G. Kang, 
% "Channel Estimation," in MIMO‐OFDM Wireless Communications 
% with MATLAB, John Wiley & Sons, Ltd, pp. 187-207, 2010. 
%
%% Require R2006A

% Author: Montadar Abas Taher

% Adapted for InSI by Do Hai Son, 29-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless Communications
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


% Initialize variables
Nfft    = Op{1};         % Occ carriers
Pilot_L = Op{2};         % Number of pilots per OFDM symbol
ChL     = Op{3};         % length of the channel
Ch_type = Op{4};         % complex
Mod_type= Op{5};
Ncp     = Nfft/4;        % CP length
Nps     = Nfft/Pilot_L;  % Pilot spacing
Ep      = 1/sqrt(2);     % Pilot energy


% Generate input signal
modulation = {'Bin', 'QPSK', 'QAM4', 'QAM16', 'QAM64', 'QAM128', 'QAM256'};

% Bits generation
[D_Mod, D]= eval(strcat(modulation{Mod_type}, '(Nfft)'));

% serial to parallel 
D_Mod_serial = D_Mod.';

% specify Pilot & Date Locations
PLoc = 1:Nps:Nfft; % location of pilots
DLoc = setxor(1:Nfft, PLoc); % location of data

% Pilot Insertion
D_Mod_serial(PLoc) = Ep*D_Mod_serial(PLoc);

% inverse discret Fourier transform (IFFT)
d_ifft = ifft(D_Mod_serial);

% parallel to serial 
d_ifft_parallel = d_ifft.';

% Adding Cyclic Prefix
CP_part = d_ifft_parallel(end-Ncp+1:end); % this is the Cyclic Prefix part to be appended.
ofdm_cp = [CP_part; d_ifft_parallel];

% Generate channel
h       = Generate_channel(1, ChL, Ch_type);

H       = fft(h, Nfft);

d_channelled = filter(h, 1, ofdm_cp.').'; % channel effect

    
ofdm_noisy_with_chann = awgn(d_channelled, SNR_i, 'measured');

%% Receiver
% remove Cyclic Prefix
ofdm_cp_removed_with_chann = ofdm_noisy_with_chann(Ncp+1:Nfft+Ncp);
% serial to parallel 
ofdm_parallel_chann = ofdm_cp_removed_with_chann.';
% Discret Fourier transform (FFT)
d_parallel_fft_channel=fft(ofdm_parallel_chann) ;

%% Channel estimation
% Extracting received pilots
TxP = D_Mod_serial(PLoc); % trnasmitted pilots
RxP = d_parallel_fft_channel(PLoc); % received pilots
% Least-Square Estimation
Hpilot_LS= RxP./TxP; % LS channel estimation

noiseVar = 10^(SNR_i*0.1);
k=0:length(h)-1; 
hh = h*h'; 
r = sum(h.*conj(h).*k)/hh;  
r2 = (h.*conj(h).*k)*k.'/hh;
t_rms = sqrt(r2-r^2);     % rms delay
D_1 = 1i*2*pi*t_rms/Nfft; % Denomerator of Eq. (6.16) page 192
K1 = repmat([0:Nfft-1].',1,Pilot_L);
K2 = repmat([0:Pilot_L-1],Nfft,1);
rf = 1./(1+D_1*(K1-K2*Nps));
K3 = repmat([0:Pilot_L-1].',1,Pilot_L);
K4 = repmat([0:Pilot_L-1],Pilot_L,1);
rf2 = 1./(1+D_1*Nps*(K3-K4));
Rhp = rf;
Rpp = rf2 + eye(length(Hpilot_LS),length(Hpilot_LS))/noiseVar;

H_MMSE = transpose(Rhp*inv(Rpp)*Hpilot_LS.');  % MMSE channel estimate

%% parallel to serial   
HData_MMSE_parallel1 = H_MMSE.';

X_hat = d_parallel_fft_channel.' ./ HData_MMSE_parallel1;

%% Removing Pilots from received data and original data 
D_no_pilots = D(DLoc); % removing pilots from msgint
D_Mod_no_pilots = D_Mod(DLoc);
Rec_d_LS    = X_hat(DLoc); % removing pilots from d_received_chann_LS

% Compute Error rate / MSE Signal
if Output_type ~= 4
    Err = ER_func(D_no_pilots, Rec_d_LS, Mod_type, Output_type, D_Mod_no_pilots);
else
    Err = ER_func(H, H_MMSE.', Mod_type, Output_type);
end

end