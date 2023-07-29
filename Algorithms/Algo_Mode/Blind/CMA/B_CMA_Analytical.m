function Err = B_CMA_Analytical(Op, SNR_i, Output_type)

%% Analytical Constant Modulus Algorithm
%
%% Input:
    % + 1. N: number of samples
    % + 2. Num_Ch: number of channels
    % + 3. ChL: Channel order
    % + 4. Ch_type: Type of the channel (real, complex,
    % user's input)
    % + 5. Mod_type: Type of modulation (Bin, QPSK, 4-QAM)
    % + 6. L: Length of the CMA filter
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
    % Step 4: Analytical CMA algorithm
    % Step 5: Compute Error rate
    %     Demodulate Y
    %     Compute SER / BER / MSE Sig
    % Step 6: Return 
%
% Ref: A. . -J. van der Veen and A. Paulraj, "An analytical 
% constant modulus algorithm," in IEEE Transactions on Signal 
% Processing, vol. 44, no. 5, pp. 1136-1155, May 1996.
%
%% Require R2006A

% Author: A. . -J. van der Veen and A. Paulraj

% Adapted for InSI by Do Hai Son, 29-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless communication systems
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
L       = Op{6};         % Window length

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

Xout    = X(:,end:-1:1);               % Not sure about that
Xout    = Xout.';

% construction de la matrice d'observation
Xdata   = matrice_data(Xout(:), L, Num_Ch);

[m, n]  = size(Xdata);
d       = m;
d1      = d;

%% disp('STEP 1: Estimate signal subspace (SVD of X)')
% ---------------------------------------------------------------------------

[u,s,v] = svd(Xdata);		    % estimate row space of X
U1      = u(:,1:d);
S1      = s(1:d,1:d);
V1      = v(:,1:d)';		    % rows of V1 are basis of S
clear v		% ( v could be large)
        

%% disp('STEP 2: Set up conditions for CM')
% ---------------------------------------------------------------------------

P       = zeros(n,d^2);
for i   = 1:n
    v1  = V1(:,i);
    P(i,:) = vecreal(v1*v1')';
end

% Householder transform to map ones(N,1) to e1

v       = [1 ; ones(n-1,1)/(1+sqrt(n))];
P       = P - 2*v*(v'*P)/(v'*v);	% apply householder transform to P

P       = P(2:n,:);			% Throw away first condition
		                    % We are left with solving Py = 0, for 
		                    % y = vec(w'*w)


%% disp('STEP 3: Solve conditions for CM (SVD of P)')
% ---------------------------------------------------------------------------

% [up,sp,vp] = svd(P);		% solve LS problem P y = 0 (ie find kernel of P)
R       = triu(qr(P));		% (qr first, to avoid storing large matrices)
[up,sp,vp] = svd(R);

sp      = diag(sp);

% plot(sp,'+');		% CM signals corr. to small singular values


% collect solutions in matrix y
y       = zeros(d,d*d1);
for i   = 1:d1
  yi    = unvecreal(vp(:,d^2+1-i)); 	% select vectors from the kernel of P
  y(:,(i-1)*d+1:i*d) = yi;	% store in block vector y
end

% At this point, y = [Y_1 ... Y_d1], with Y_k complex, symmetric
        

%% disp('STEP 4: Construct w')
% ---------------------------------------------------------------------------

% Ideally, each yi has rank 1 and is equal to yi = wi'*wi
% However, linear combinations of the yi are also vectors in the kernel
% So, solve lambda_1 y1 + ... + lambda_d yd = wi'*wi (rank 1), for i=1..d.

w = supereig(y);		% decouple solutions to obtain weight vectors

% w: d1 by d

% scale each row of w to norm sqrt(N)
for i=1:d1
   w(i,:) = w(i,:)/norm(w(i,:))*sqrt(n);
end

%% disp('STEP 5: Construct S')
% ---------------------------------------------------------------------------

S               = w*V1;
tmp             = S(1,:);
est_src_b       = tmp.';

% Compute Error rate / MSE Signal
for win=1:ChL+L
    sig_src_b       = sig(win:N+win-L);                                                   
    data_src        = data(win:N+win-L);  
    Err_tmp(win)    = ER_func(data_src, est_src_b, Mod_type, Output_type, sig_src_b);
end

% Return
Err = min(Err_tmp);

end