function [SNR, Err] = NB_MMSE(Op, Monte, SNR, Output_type)

% MMSE (Minimum Mean Square Error)
% Ref: https://www.sharetechnote.com/html/Communication_ChannelModel_MMSE.html
%% Input:
    % N: number of sample data
    % Pilot_L: number of pilot symbols
    % ChL: length of the channel
    % Ch_type: type of the channel (real, complex, specular, user' input
    % Mod_type: type of modulation (Bin, QPSK, 4-QAM)
    % Monte: simulation times
    % SNR: range of the SNR
    % Ouput_type: MSE Sig, MSE Ch, Error rate
%% Output:
    % SNR: range of the SNR
    % SER: Symbol error rate
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Generate input signal
    %     X <= h^T * s + n
    % Step 3: Estimate channel
    %     H_est <= Y_pilot ./ X_pilot
    % Step 4: Equalization
    %     X <= Y ./ H_est
    % Step 5: Compute Symbol Error rate
    %     Demodulate Y
    %     Compate elements in two array init data and Demodulated signal
    % Step 6: Return 
%% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
%% Last Modified by Son 29-Sept-2022 12:52:13 


% Initialize variables
Nfft    = Op{1};         % Occ carriers
Ng      = Nfft/4;        % CP length
Nofdm   = Nfft+Ng;       % OFDM symbol len
Nbit    = Nfft;          % Seq
Pilot_L = Op{2};         % Number of pilots per OFDM symbol
Nps     = Nfft / Pilot_L;% Pilot spacing
P_loc   = 1:(1+Nps):(Nfft + Pilot_L);
ChL     = Op{3};         % length of the channel
Ch_type = Op{4};         % complex
Mod_type= Op{5};
Monte   = Monte;
SNR     = SNR;
Output_type = Output_type;

% Generate input signal
modulation = {'Bin', 'QPSK', 'QAM4'};

% ZF algorithm
SER_f   = [];
MSE_H_f = [];
for Monte_i = 1:Monte
    %% Data Bit generation
    [sig, data]= eval(strcat(modulation{Mod_type}, '(Nfft)'));

    %% Pilot sequence generation
    Pilot      = Gen_Pilot(Pilot_L);
    
    x_p        = ifft(Pilot, Nfft);
    xt_p       = [x_p(Nfft-Ng+1:Nfft); x_p]; % IFFT and add CP
    x_d        = ifft(sig, Nfft);
    xt_d       = [x_d(Nfft-Ng+1:Nfft); x_d]; % IFFT and add CP

    Ch     = Generate_channel(1, ChL, Ch_type);

    H          = fft(Ch, Nfft);
    ch_length  = length(Ch); % True channel and its length
    H_power_dB = 10*log10(abs(H.*conj(H))); % True channel power in dB

    %% Channel path (convolution)
    x_pilot    = conv(xt_p, Ch); 
    x          = conv(xt_d, Ch);
    
    SER_SNR    = [];
    MSE_H      = [];
    for SNR_i  = 1:length(SNR)
        X_pilot= awgn(x_pilot, SNR(SNR_i));        % received noisy pilot
        X      = awgn(x, SNR(SNR_i));              % received noisy signal
        
        %% Remove CP
        y_p    = X_pilot(Ng+1:Nofdm);
        Y_p    = fft(y_p); % FFT

        y_d    = X(Ng+1:Nbit + Ng);
        Y_d    = fft(y_d); % FFT
        
        %% Estimate H
        H_est  = MMSE_CE(Y_p, Pilot, P_loc, Nfft, Nps, Ch, SNR_i);
        H_est_power_dB = 10*log10(abs(H_est.*conj(H_est)));
        h_est  = ifft(H_est);
        
        %% MSE H
        MSE_H      = [MSE_H, (H-H_est)*(H-H_est)'];

        Y   = Y_d ./ H_est(1:Nfft).';
        
        % Compute Symbol Error rate
        SER_SNR(end + 1) = SER_func(Y, data, 1, Mod_type);
    end
    SER_f   = [SER_f; SER_SNR];
    MSE_H_f = [MSE_H_f; MSE_H];
end

% Return
if Monte ~= 1
    if Output_type == 1
        Err = mean(SER_f);
    else
        if Output_type == 3
            Err = mean(MSE_H_f);
        end
    end
else
    if Output_type == 1
        Err = SER_f;
    else
        if Output_type == 3
            Err = MSE_H_f;
        end
    end
end