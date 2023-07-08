function Err = B_CMA_Grad_adap(Op, SNR_i, Output_type)

%% Adaptive Constant Modulus Algorithm
%
%% Input:
    % + 1. N: number of samples
    % + 2. Num_Ch: number of channels
    % + 3. ChL: Channel order
    % + 4. Ch_type: Type of the channel (real, complex, specular,
    % user's input)
    % + 5. Mod_type: Type of modulation (Bin, QPSK, 4-QAM)
    % + 6. mu: Step size
    % + 7. L: Length of the CMA filter
    % + 8. SNR_i: signal noise ratio
    % + 9. Output_type: SER / BER / MSE Signal
%
%% Output:
    % + 1. Err: Error rate
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Generate input signal
    %     X <= h^T * s + n
    % Step 3: Initialize CMA FIR
    %     CM<= abs(X(1))
    %     W <= [0, 0, ..., 1, ..., 0]
    % Step 4: Adaptive CMA
    %     repeat
    %         y(k)   <= x^T(k) * W(k)
    %         W(k+1) <= W(k) - mu*(|y(k)|^2 - 1)* y_k*conj(x(k))
    %           if ( CM - abs(y(k) > CM - abs(x^T(k) * W(k+1)) )
    %               mu = 0.5 * mu 
    %         Y      <= [Y y(k)]
    %     util end of the input
    % Step 5: Compute Error rate
    %     Demodulate Y
    %     Compute SER / BER / MSE Sig
    % Step 6: Return 
%
% Ref: J. Treichler and B. Agee, "A new approach to multipath 
% correction of constant modulus signals," in IEEE Transactions 
% on Acoustics, Speech, and Signal Processing, vol. 31, no. 2, 
% pp. 459-472, Apr. 1983.
%
%% Require R2006A

% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 08-Jul-2023 11:35:13.


% Initialize variables
N       = Op{1};         % number of sample data
Num_Ch  = Op{2};         % number of channels
ChL     = Op{3};         % length of the channel
Ch_type = Op{4};         % complex
Mod_type= Op{5};
mu      = Op{6};         % Step size
L       = Op{7};         % Window length

% Generate input signal
modulation  = {'Bin', 'QPSK', 'QAM4'};
[sig, data] = eval(strcat(modulation{Mod_type}, '(N + ChL)'));

% Generate channel
H           = Generate_channel(Num_Ch, ChL, Ch_type);

sig_rec = [];
for l = 1:Num_Ch
    sig_rec(:, l) = conv( H(l,:).', sig ) ;
end
x       = sig_rec(ChL+1:N + ChL, :);

X       = awgn(x, SNR_i);              % received noisy signal

%% CMA estimator
CM      = abs(sig(1));
d       = floor(L*Num_Ch/2);
W       = [zeros(d, 1); 1 ; zeros(L*Num_Ch-d-1,1)];
Y       = [];
Y_k     = 0;

k       = L;
while k <= N
    %% y(k) = x.^T(k) * W(k)
    x1      = X(k:-1:(k-L+1),:);
    X_k     = x1(:);
    Y_k     = W' * X_k;

    W_old   = W;
    
    %% W(k+1) = W(k) - mu * (|y(k)|^2 - CM)* y_k * conj(x(k))
    ep      = (abs(Y_k)^2 - CM)*conj(Y_k);
    W       = W - (mu * X_k * ep);
    
    y1      = Y_k;
    y2      = W' * X_k;
    Crit1   = (CM - abs(y1)^2)^2;
    Crit2   = (CM - abs(y2)^2)^2;

    if Crit2<=Crit1
        k   = k + 1;
        Y   = [Y; Y_k];                     %L->end
    else
        W   = W_old;
        mu  = 0.5*mu;
    end
end

Xn = [];
for jj = L:N
    x2      = X(jj:-1:(jj-L+1),:);
    Bn      = x2(:);
    Xn      = [Xn Bn];
end
est_src_b   = conj(Xn'*W);


% Compute Error rate / MSE Signal
for win=1:ChL+L
    sig_src_b       = sig(win:N+win-L);                                                   
    data_src        = data(win:N+win-L);  
    Err_tmp(win)    = ER_func(data_src, est_src_b, Mod_type, Output_type, sig_src_b);
end

% Return
Err = min(Err_tmp);

end