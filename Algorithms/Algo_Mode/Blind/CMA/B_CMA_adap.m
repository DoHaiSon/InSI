function [SNR, Err] = CMA_adap(Op, Monte, SNR, Output_type)

%BLIND CHANNEL USING CMA ALGORITHM
% Ref: J. Treichler and B. Agee, "A new approach to multipath correction of constant modulus signals,"
% in IEEE Transactions on Acoustics, Speech, and Signal Processing, vol. 31, no. 2, pp. 459-472, 1983.
%% Input:
    % N: number of sample data
    % ChL: length of the channel
    % Ch_type: type of the channel (real, complex, specular, user' input
    % Mod_type: type of modulation (Bin, QPSK, 4-QAM)
    % mu: step size
    % L: length of the CMA filter
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
    % Step 3: Initialize CMA FIR
    %     W <= randn(L, 1)
	%	  W <= W/norm(W)
    % Step 4: CMA algorithm
    %     repeat
    %         y(k)   <= x^T(k) * W(k)
    %         W(k+1) <= W(k) - mu * (|y(k)|^2 - 1)* y_k * conj(x(k))
    %         Y      <= [Y y(k)]
    %     util end of the input
    % Step 5: Compute Symbol Error rate
    %     Demodulate Y
    %     Compate elements in two array init data and Demodulated signal
    % Step 7: Return 
%% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
%% Last Modified by Son 22-Oct-2021 12:52:13 


% Initialize variables
N       = Op{1};         % number of sample data
ChL     = Op{2};         % length of the channel
Ch_type = Op{3};         % complex
Mod_type= Op{4};
mu      = Op{5};
L       = Op{6};
Monte   = Monte;
SNR     = SNR;
Output_type = Output_type;

% Generate input signal
modulation = {'Bin', 'QPSK', 'QAM4'};

SER_f = [];
for Monte_i = 1:Monte
    [sig, data]  = eval(strcat(modulation{Mod_type}, '(N)'));

    Ch         = Generate_channel(1, ChL, Ch_type);
    x          = filter(Ch, 1, sig);
    
    SER_SNR    = [];
    for SNR_i   = 1:length(SNR)
        X       = awgn(x, SNR(SNR_i));              % received noisy signal
        
        %% CMA estimator
        CM      = abs(sig(1));                      % constant modulous of QAM4 symbols
        W       = zeros(L, 1);                      % init filter coeff
        W(1)    = 1;
        Y       = [];
        Y_k     = 0;
        
        for k=L:N
            %% y(k) = x.^T(k) * W(k)
            X_k     = X(k: -1:k-L+1);
            Y_k     = transpose(X_k) * W;
            
            %% W(k+1) = W(k) - mu * (|y(k)|^2 - CM)* y_k * conj(x(k))
            ep      = (abs(Y_k)^2 - CM)* Y_k;
            W       = W - mu * ep * conj(X_k);

            Y       = [Y; Y_k];                     %L->end
        end
        
        % Compute Symbol Error rate
        SER_SNR(end + 1) = SER_func(Y, data, L, Mod_type);
    end
    SER_f = [SER_f; SER_SNR];
end

% Return
if Monte ~= 1
    Err = mean(SER_f);
else
    Err = SER_f;
end