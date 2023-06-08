function [SNR, Err] = B_GRDA(Op, Monte, SNR, Output_type)

%% GRDA
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
    % Step 4: GRDA algorithm
    % Step 5: Compute Error rate
    %     Demodulate Y
    %     Compute SER / BER / MSE Sig
    % Step 6: Return 
%
% Ref: H. Gazzah, P. A. Regalia, J. . -P. Delmas, and 
% K. Abed-Meraim, "A blind multichannel identification algorithm
% robust to order overestimation," in IEEE Transactions on Signal
% Processing, vol. 50, no. 6, pp. 1449-1458, Jun. 2002.
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
        %% Blind GRDA program
        [R, Y]  = EstimateCor(sig_rec, num_sq, L, N);

        lncol   = size(R);
        if lncol(1)~=lncol(2)       
            input('GRDA error 1');
            exit;
        end
        l       = lncol(1)/L;
        if floor(l)~=l 
            input('GRDA error 2');
            exit;
        end
        if L*l<=M+l 
            input('GRDA error 3');
            exit;
        end
        
        gammas    = [R(L+1:2*L,1:L) R(1:L,1:L*min([M l]))];
        noiseng   = noisengFROMSOS(L,CORRshift(min([M l]),0,gammas,1),M);
        gammasNF  = gammas;gammasNF(:,1:L)=gammas(:,1:L)-noiseng*eye(L);
        RshiftNF  = R-noiseng*kron(Jmtx(l).',eye(L));
        Gmax      = conj(XSING(RshiftNF,(L-1)*l-M+1,0,1));
        Gmin      = conj(XSING(RshiftNF,(L-1)*l-M+1,1,1));
        
        RNF       = CORRshift(l,0,gammasNF,1);
        [S_l,delta] = XEIG(RNF,l+M,0);
        RNF_pinv  = S_l*diag(1./(delta-noiseng))*S_l';
        
        gmax      = Gmax*XEIG(Gmax'*RNF.'*Gmax,1,0);
        gmin      = Gmin*XEIG(Gmin'*RNF.'*Gmin,1,0);
        
        est_src_b = gmax'* Y;
        est_src_b = est_src_b.';
        
        % Equalization
        sig_src_b   = sig_src(1:num_sq-N+1);
        data_src    = data(1:num_sq-N+1);  

        % Compute Error rate / MSE Signal
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