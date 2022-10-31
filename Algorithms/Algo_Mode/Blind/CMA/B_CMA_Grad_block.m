function [SNR, Err] = B_CMA_Grad_block(Op, Monte, SNR, Output_type)

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
Num_Ch  = Op{2};         % number of channels
ChL     = Op{3};         % length of the channel
Ch_type = Op{4};         % complex
Mod_type= Op{5};
mu      = Op{6};         % Step size
L       = Op{7};         % Window length
Monte   = Monte;
SNR     = SNR;
Output_type = Output_type;

% Generate input signal
modulation = {'Bin', 'QPSK', 'QAM4'};

SER_f = [];
for Monte_i = 1:Monte
    [sig, data] = eval(strcat(modulation{Mod_type}, '(N + ChL)'));

    H           = Generate_channel(Num_Ch, ChL, Ch_type);

    sig_rec = [];
        for l = 1:Num_Ch
            sig_rec(:, l) = conv( H(l,:).', sig ) ;
        end
    x           = sig_rec(ChL+1:N + ChL, :);
    
    SER_SNR     = [];
    for SNR_i   = 1:length(SNR)
        X       = awgn(x, SNR(SNR_i));              % received noisy signal
        
        Xn=[];
        for i   = L:N
            x1  = X(i:-1:(i-L+1),:);
            Zn  = x1(:);
            Xn  = [Xn Zn];
        end
        
        %% CMA estimator
        CM      = abs(sig(1));
        d       = floor(L*Num_Ch/2);
        W       = [zeros(d, 1); 1 ; zeros(L*Num_Ch-d-1,1)];
        
        jj      = 1;
        while (jj < 5)
            
            Y   = W'*Xn;
            EP  = (CM - abs(Y).^2).*conj(Y);
            G   = Xn*EP';
            
            W   = W+(mu*G);            
            jj  = jj+1;
        end

        if any(isnan(W(:)))
            error('W matrix includes N/A values. Please choose a lower step size (mu) value.');
        end

        est_src_b       = conj(Xn'*W);
        
        % Compute Symbol Error rate
        for win=1:ChL+L
            sig_src_b       = sig(win:N+win-L);                                                   
            est_src_tmp     = est_src_b' * sig_src_b * est_src_b;           % remove the inherent scalar indeterminacy related to the blind processing
            data_src        = data(win:N+win-L);  
            Err_tmp(win)    = SER_func(data_src, est_src_tmp, Mod_type);
        end
        SER_SNR(end+1)  = min(Err_tmp);
    end
    SER_f = [SER_f; SER_SNR];
end

% Return
if Monte ~= 1
    Err = mean(SER_f);
else
    Err = SER_f;
end