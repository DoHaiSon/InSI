function Err = B_OP(Op, SNR_i, Output_type)

%% OP
%
%% Input:
    % + 1. num_sq: number of samples
    % + 2. L: number of channels
    % + 3. M: Channel order
    % + 4. Ch_type: Type of the channel (real, complex,
    % user's input)
    % + 5. Mod_type: Type of modulation (All)
    % + 6. SNR_i: signal noise ratio
    % + 7. Output_type: MSE Channel
%
%% Output:
    % + 1. Err: MSE Channel
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Generate input signal
    %     X <= h^T * s + n
    % Step 3: 
    % Step 4: OP algorithm
    % Step 5: Compute MSE Channel
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


num_sq    = Op{1};     % number of sig sequences
L         = Op{2};     % number of the sensors
M         = Op{3};     % length of the channel 
Ch_type   = Op{4};     % complex
Mod_type  = Op{5};     
N         = M+1;       % Window length


% Generate input signal
modulation = {'Bin', 'QPSK', 'QAM4', 'QAM16', 'QAM64', 'QAM128', 'QAM256'};
[sig, data] = eval(strcat(modulation{Mod_type}, '(num_sq + M)'));

% Generate channel
H         = Generate_channel(L, M, Ch_type);
H         = H / norm(H, 'fro');
    
% Signal rec
sig_rec_noiseless = [];
for l = 1:L
    sig_rec_noiseless(:, l) = conv( H(l,:).', sig ) ;
end
sig_rec_noiseless = sig_rec_noiseless(M+1:num_sq + M, :);

sig_rec = awgn(sig_rec_noiseless, SNR_i);

%% Algorithm OP
[R, Y]  = EstimateCov1(sig_rec, num_sq, L, N);

if L<2                        
    input('OP error 0');
    exit;
end

lncol   = size(R);
if lncol(1)~=lncol(2)
    input('OP error 1');
    exit;
end

m       = lncol(1)/L-1;
if floor(m)~=m 
    input('OP error 2');
    exit;
end


Y       = R - noisengFROMSOS(L,R,m)*eye(L*(m+1));
Ycirc   = Hae(Y(1:L,:));

% calculer la pseudo inv de Y pour etre sur q'elle soit hermitienne
[u,s,v] = svd(Y);
for ii  = 1:2*m+1
    s(ii,ii) = 1/s(ii,ii);
end
for ii  = 2*m+2:L*(m+1)
    s(ii,ii) = 0;
end
pinvY   = u*s*u';

D1      = Ycirc*pinvY*Ycirc';
D2      = [   D1(L+1:L+L*m,L+1:L+L*m) zeros(L*m,L) ;
    zeros(L        ,      L*m) zeros(L  ,L) ];

[h,lambda] = XEIG(D1-D2,1,0);
h_est      = h*exp(-1i*angle(h(1,1)));

% Compute MSE Channel
Err        = ER_func(H.', h_est, Mod_type, Output_type);

end