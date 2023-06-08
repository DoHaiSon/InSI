function [SNR, Err] = B_LP(Op, Monte, SNR, Output_type)

%% Linear Prediction
%
%% Input:
    % + 1. num_sq: number of samples
    % + 2. L: number of channels
    % + 3. M: Channel order
    % + 4. Ch_type: Type of the channel (real, complex, specular,
    % user's input)
    % + 5. Mod_type: Type of modulation (All)
    % + 6. N: Window size
    % + 7. Monte: Simulation times
    % + 8. SNR: Range of the SNR
    % + 9. Ouput_type: SER / BER / MSE Signal
%
%% Output:
    % + 1. SNR: Range of the SNR
    % + 2. Err: Error rate
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Generate input signal
    %     X <= h^T * s + n
    % Step 3: 
    % Step 4: LP algorithm
    % Step 5: Compute Error rate
    %     Demodulate Y
    %     Compute SER / BER / MSE Sig
    % Step 6: Return 
%
% Ref:
%
%% Require R2006A

% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 08-Jun-2023 15:54:13.


num_sq    = Op{1};     % number of sig sequences
L         = Op{2};     % number of the sensors
M         = Op{3};     % length of the channel 
Ch_type   = Op{4};     % complex
Mod_type  = Op{5};     
N         = Op{6};     % number of measurements
K         = M + N;     % rank of H
Monte     = Monte;
SNR       = SNR;       % Signal to noise ratio (dB)
Output_type = Output_type;

% Generate input signal
modulation = {'Bin', 'QPSK', 'QAM4', 'QAM16', 'QAM64', 'QAM128', 'QAM256'};

%% Generate channel
H         = Generate_channel(L, M, Ch_type);

res_b     = [];
for monte = 1:Monte
%     fprintf('------------------------------------------------------------\nExperience No %d \n', monte); 
    err_b = [];
    for snr_i = SNR
%         fprintf('Working at SNR: %d dB\n', snr_i);

        %% Generate signals
        [sig_src, data] = eval(strcat(modulation{Mod_type}, '(num_sq + M)'));
        
        % Signal rec
        sig_rec = [];
        for l = 1:L
            sig_rec(:, l) = conv( H(l,:).', sig_src ) ;
        end
        sig_rec = sig_rec(M+1:num_sq + M, :);

        sig_rec = awgn(sig_rec, snr_i);


        %% ----------------------------------------------------------------
        %% Blind Linear Prediction program
        [R, Y]  = EstimateCov1(sig_rec, num_sq, L, N);

        dim_ker = N*L - (N+M);
        
        % Estimation de la covariance du bruit
        [u0, s0]= eig(R);  
        [k0, ord0] = sort(real(diag(s0)));
        sigma = real( (1/dim_ker)*sum(k0(1:dim_ker)) );%,pause  
        
        % Covariance debruitee
        Rd = R - sigma*eye(L*N);
        
          
        % Calcul de r0 et r=[r1,..rM]
        r0 = R(1:L, 1:L)-sigma*eye(L);
        r  = R(1:L, L+1: L*N);
        R0 = R(L+1:N*L,1+L:N*L) - sigma*eye((N-1)*L);
        
        % Calcul de la pseudo inverse de R0
        dim_ker1    = L*(N-1)-(N-1+M);
        [u, s]      = eig(R0);  
        [kk, ord]   = sort(diag(s));
        R0_1        = u(:, ord(dim_ker1+1:(N-1)*L))*diag(1./(kk(dim_ker1+1:(N-1)*L)))...
                        *u(:,ord(dim_ker1+1:(N-1)*L))';
          
        % Calcul des coefficients des filtres
        A           = -r*R0_1;
        D           = r0 + A*r';
        [u1, s1]    = eig(D);
        [k1, ord1]  = sort(abs(diag(s1)));
        G           = [eye(L), A];
        h           = exp(-1i*angle(u1(1,ord1(L))))*real(k1(L))^(-1/2)*u1(:,ord1(L));
        g           = h'*G;
        
        % Equalization
        est_src_b   = (g*Y).';
        
        % Compute Error rate / MSE Signal
        sig_src_b   = sig_src(M+N:num_sq+M);
        data_src    = data(M+N:num_sq+M);  
        ER_SNR      = ER_func(data_src, est_src_b, Mod_type, Output_type, sig_src_b);

        err_b   = [err_b , ER_SNR];
    end
    
    res_b   = [res_b;  err_b];
end

% Return
if Monte ~= 1
    Err = mean(res_b);
else
    Err = res_b;
end