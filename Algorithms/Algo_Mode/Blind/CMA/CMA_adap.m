function [] = CMA_adap()

%BLIND CHANNEL USING CMA ALGORITHM
% Ref: J. Treichler and B. Agee, "A new approach to multipath correction of constant modulus signals,"
% in IEEE Transactions on Acoustics, Speech, and Signal Processing, vol. 31, no. 2, pp. 459-472, 1983.
%% Input:
    % N: number of sample data
    % SNR: Signal to noise ratio(dB)
    % ChL: length of the channel
    % Chtype: type of the channel (real, complex, specular, user' input
    % Modtype: type of modulation (FM, PM, FSK, PSK, 4-QAM)
    % mu: step size
    % FIR_len: length of the CMA filter
%% Output:
    % Y: signal after equalization
    % Errs: Symbol error rate
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Generate input signal
    %     X <= h^T * s + n
    % Step 3: Initialize CMA FIR
    %     W <= randn(FIR_len, 1)
	%	  W <= W/norm(W)
    % Step 4: CMA algorithm
    %     repeat
    %         y(k)   <= x^T(k) * W(k)
    %         W(k+1) <= W(k) - mu * (|y(k)|^2 - 1)* y_k * conj(x(k))
    %     util end of the input
    % Step 5: Equaliztion
    %     reapeat
    %         y(k)   <= x^T(k) * W(k)
    %         Y      <= [Y y(k)]
    %     util end of the input
    % Step 6: Compute Symbol Error rate
    %     Demodulate Y
    %     Compate elements in two array init data and Demodulated signal
    % Step 7: Figure 
%% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
%% Last Modified by Son 10-Sep-2021 12:52:13 

N       = 10000;     % number of sample data
SNR     = 25;        % Signal to noise ratio(dB)
ChL     = 2;         % length of the channel
Chtype  = 2;         % complex

[s, data] = QAM4(N);

% Ch      = Generate_channel(ChL, Chtype);    % complex channel and normalize
Ch      = [0.8+i*0.1 .9-i*0.2];

x       = filter(Ch,1,s);                   % channel distortion

X       = awgn(x, SNR);                     % received noisy signal

%% CMA estimator
mu      = 0.001;                            % step size
CM      = abs(s(1));                        % constant modulous of QAM4 symbols
FIR_len = 20;                               % Filter length
W       = randn(FIR_len, 1) + 1j*randn(FIR_len, 1);               % init filter coeff
W       = W / norm(W);
Y       = [];

% assume channel is constant => W is constant
for i= FIR_len + 1: N
    %% y(k) = x.^T(k) * W(k)
    X_k     = X(i - FIR_len: i-1);
    Y_k     = X_k.' * W;

    %% W(k+1) = W(k) - mu * (|y(k)|^2 - CM)* y_k * conj(x(k)) 
    ep      = (abs(Y_k)^2 - CM)* Y_k;
    W       = W - mu * ep * conj(X_k);
end

%% Equalizer:
for i= FIR_len + 1: N
    X_k     = X(i - FIR_len: i-1);
    Y_k     = X_k.' * W;
    Y       = [Y Y_k];
end

%% Symbol error rate
X_demod     = qamdemod(Y, 4);
data        = data(FIR_len + 1:N)';                % Remove length of filter
Errs        = sum(data == X_demod);               % Number of symbols Errs
[r, lag]    = xcorr(data, X_demod);
[argvalue, argmax] = max(r);
fprintf('Symbol error rate: %f.\n', Errs / length(X_demod));
fprintf('Lag: %d.\n', lag(argmax));
lag         = lag(argmax);
if lag >0
    Errs    = sum(data(1+lag:end) == X_demod(1:end-lag));
else
    Errs    = sum(data(1:end+lag) == X_demod(1-lag:end));
end
fprintf('Symbol error rate after shifted symbols: %f.\n', Errs / length(X_demod));
end