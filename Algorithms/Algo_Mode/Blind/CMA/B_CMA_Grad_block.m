function Err = B_CMA_Grad_block(Op, SNR_i, Output_type)

%% Block Constant Modulus Algorithm
%
%% Input:
    % + 1. N: number of samples
    % + 2. Num_Ch: number of channels
    % + 3. ChL: Channel order
    % + 4. Ch_type: Type of the channel (real, complex,
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
    % Step 3: 
    % Step 4: Analytical CMA algorithm
    % Step 5: Compute Error rate
    %     Demodulate Y
    %     Compute SER / BER / MSE Sig
    % Step 6: Return 
%
% Ref: 
%
%% Require R2006A

% Author: 

% Adapted for InSI by Do Hai Son, 29-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless Communications
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


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
    error(['W matrix includes N/A values. Please choose a' ...
        'lower step size (mu) value.']);
end

est_src_b       = conj(Xn'*W);

% Compute Error rate / MSE Signal
for win=1:ChL+L
    sig_src_b       = sig(win:N+win-L);                                                   
    data_src        = data(win:N+win-L);  
    Err_tmp(win)    = ER_func(data_src, est_src_b, Mod_type, Output_type, sig_src_b);
end

% Return
Err = min(Err_tmp);

end