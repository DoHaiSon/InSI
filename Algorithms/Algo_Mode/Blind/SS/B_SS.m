function Err = B_SS(Op, SNR_i, Output_type)

%% Signal Subspace
%
%% Input:
    % + 1. num_sq: number of samples
    % + 2. L: number of channels
    % + 3. M: Channel order
    % + 4. Ch_type: Type of the channel (real, complex,
    % user's input)
    % + 5. Mod_type: Type of modulation (All)
    % + 6. N: Window size
    % + 7. SNR_i: signal noise ratio
    % + 8. Output_type: SER / BER / MSE Signal
%
%% Output:
    % + 1. Err: Error rate
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Generate input signal
    %     X <= h^T * s + n
    % Step 3: 
    % Step 4: SS algorithm
    % Step 5: Compute Error rate
    %     Demodulate Y
    %     Compute SER / BER / MSE Sig
    % Step 6: Return 
%
% Ref: E. Moulines, P. Duhamel, J. . -F. Cardoso, and 
% S. Mayrargue, "Subspace methods for the blind identification of
% multichannel FIR filters," in IEEE Transactions on Signal 
% Processing, vol. 43, no. 2, pp. 516-525, Feb. 1995.
%
%% Require R2006A

% Author: E. Moulines, P. Duhamel, J. . -F. Cardoso, and 
% S. Mayrargue

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
N         = Op{6};     % number of measurements


% Generate input signal
modulation = {'Bin', 'QPSK', 'QAM4', 'QAM16', 'QAM64', 'QAM128', 'QAM256'};
[sig_src, data] = eval(strcat(modulation{Mod_type}, '(num_sq + M)'));

% Generate channel
H          = Generate_channel(L, M, Ch_type);
        
% Signal rec
sig_rec = [];
for l = 1:L
    sig_rec(:, l) = conv( H(l,:).', sig_src ) ;
end
sig_rec = sig_rec(M+1:num_sq + M, :);

sig_rec = awgn(sig_rec, SNR_i);


%% ----------------------------------------------------------------
%% Blind Signal subspace program
x       = sig_rec(:,1);
mat     = hankel(x(1:N), x(N:num_sq));
mat     = mat(N:-1:1,:);
Y       = mat;

for ii  = 2:L
  x     = sig_rec(:,ii);
  mat   = hankel(x(1:N),x(N:num_sq));
  mat   = mat(N:-1:1,:);
  Y     = [Y;mat];
end

[u,s,v] = svd(Y);
V0      = [v(:,N+M+1:num_sq-N+1);zeros(N+M-1,num_sq-2*N-M+1)];
zz      = zeros(1, num_sq-2*N-M+1);
V       = V0;

for ii  = 1: N+M-1
   V0   = [zz; V0(1:num_sq+M-1,:)];
   V    = [V, V0];
end
V       = conj(V);

[u1,s1,v1] = svd(V);

% Equalization
est_src_b  =  u1(:, num_sq+M);

% Compute Error rate / MSE Signal
sig_src_b   = sig_src;
data_src    = data;  
Err         = ER_func(data_src, est_src_b, Mod_type, Output_type, sig_src_b);

end