function Err = B_FI(Op, SNR_i, Output_type)

%% Fisher Information
%
%% Input:
    % + 1. num_sq: number of samples
    % + 2. L: number of channels
    % + 3. M: Channel order
    % + 4. Ch_type: Type of the channel (real, complex,
    % user's input)
    % + 5. Mod_type: Type of modulation (All)
    % + 6. N: Window length
    % + 7. SNR_i: signal noise ratio
    % + 8. Output_type: MSE Channel
%
%% Output:
    % + 1. Err: MSE Channel
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Generate input signal
    %     X <= h^T * s + n
    % Step 3: 
    % Step 4: FI algorithm
    % Step 5: Compute MSE Channel
    % Step 6: Return 
%
% Ref: 
%
%% Require R2006A

% Author: 

% Adapted for InSI by Do Hai Son, 29-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless communication systems
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


num_sq    = Op{1};     % number of sig sequences
L         = Op{2};     % number of the sensors
M         = Op{3};     % length of the channel 
Ch_type   = Op{4};     % complex
Mod_type  = Op{5};     
N         = Op{6};     % Window length


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

%% Algorithm FI
m1      = N;
d       = M+m1;
B       = L*m1;

% Calcul de l'estimée de R0: Rx0 et celle de R1: Rx1
%---------------------------------------------------
somm0   = zeros(B);
somm1   = zeros(B);
sig_rec1= zeros(B,1);

for ii=0:num_sq-m1
    sig_rec2 = sig_rec(m1+ii:-1:ii+1,:);
    sig_rec2 = sig_rec2.';
    sig_rec2 = sig_rec2(:);
    prod1    = sig_rec2*sig_rec1';
    somm1    = somm1+prod1;
    somm0    = somm0+sig_rec2*sig_rec2';
    sig_rec1 = sig_rec2;
end

Rx0     = somm0 / (num_sq-m1+1);
Rx1     = somm1 / (num_sq-m1);

% calcul de l'éstimée de la puissance du bruit s:
%-------------------------------------------------
[U,Zs,S]= svd(Rx0);
s       = mean(Zs(d+1:B));

% Us représente les vecteurs singuliers associés aux d plus grandes valeurs singulières de R0 :
Us      = U(:,1:d);

% Z représente la matrice diagonale des d plus grandes valeurs singulières de R0 :
Z       = sqrtm(Zs(1:d,1:d)-s*eye(d));
F       = inv(Z)*(Us)';

% calcul de R :
%--------------

% calcul de la matrice J :
J       = [zeros(1,B);eye(B-1),zeros(B-1,1)];
R1      = s*J;
R       = F*(Rx1-R1)*F';

% decomposition en SVD de R
[Yd,Sd,Zd] = svd(R);
yd      = Yd(:,end);
zd      = Zd(:,end);

% calcul de Q=[yd,R.yd,...,(R^(d-1)).yd] :
Q       = [yd];
w_ii    = yd;
for ii=1:d-1
    w_ii = R*w_ii;
    Q   = [Q, w_ii];
end

% calcul de l'éstimée de H :
H_1     = Us*Z*Q;
h       = zeros(L,M+1);
for k = 0:m1-1
    h   = h + H_1(1+k*L:(k+1)*L,k+1:k+M+1);
end

H_2     = h/m1;
h1      = H_2(:);
H_vec   = H(:);
alpha   = h1'*H_vec/norm(h1)^2;
h_est   = alpha*h1;

% Compute MSE Channel
Err     = ER_func(H, h_est, Mod_type, Output_type, sig, 0);

end