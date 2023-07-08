function Err = B_CMA_Grad(Op, SNR_i, Output_type)

%% Constant Modulus Algorithm
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
    %     W <= [0, 0, ..., 1, ..., 0]
    % Step 4: CMA algorithm
    %     repeat
    %         y(k)   <= x^T(k) * W(k)
    %         W(k+1) <= W(k) - mu*(|y(k)|^2 - 1)* y_k*conj(x(k))
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
% Last Modified by Son 08-Jul-2023 10:54:13.


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
Xn      = [];

for jj  = 1:10
    for ii = L:N
    
        x1  = X(ii:-1:(ii-L+1),:);
        Zn  = x1(:);
        
        if jj==1
            Xn = [Xn Zn];
        end
    
        y   = W'*Zn;
        ep  = (CM-abs(y)^2)*conj(y);
    
        W   = W + (mu*Zn*ep);
    end
end

if any(isnan(W(:)))
    error(['W matrix includes N/A values. Please choose a ' ...
        'lower step size (mu) value.']);
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