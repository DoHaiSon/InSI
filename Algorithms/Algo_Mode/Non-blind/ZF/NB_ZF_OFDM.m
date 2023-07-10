function Err = NB_ZF_OFDM(Op, SNR_i, Output_type)

%% Zero Forcing - OFDM
%
%% Input:
    % 1. Nfft: number of Occ carriers
    % 2. Pilot_L: number of pilot symbols
    % 3. ChL: length of the channel
    % 4. Ch_type: type of the channel (real, complex, specular, 
    % user's input)
    % 5. Mod_type: type of modulation (All)
    % 6. SNR_i: signal noise ratio
    % 7. Output_type: SER / BER / MSE Signal / MSE Channel
%
%% Output:
    % 2. Err: SER / BER / MSE Signal / MSE Channel
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

% Author: Montadar Abas Taher
% Last Modified by Son 10-Jul-2023 10:33:13 


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

% Interpolation p--->N    
HData_LS = interpolate(Hpilot_LS,PLoc,Nfft,'spline'); % Linear/Spline interpolation

%% parallel to serial   
HData_LS_parallel1 = HData_LS.';

X_hat = d_parallel_fft_channel.' ./ HData_LS_parallel1;

%% Removing Pilots from received data and original data 
D_no_pilots = D(DLoc); % removing pilots from msgint
D_Mod_no_pilots = D_Mod(DLoc);
Rec_d_LS    = X_hat(DLoc); % removing pilots from d_received_chann_LS

% Compute Error rate / MSE Signal
if Output_type ~= 4
    Err = ER_func(D_no_pilots, Rec_d_LS, Mod_type, Output_type, D_Mod_no_pilots);
else
    Err = ER_func(H, HData_LS.', Mod_type, Output_type);
end

end