function [SNR, Err] = B_CR_Minimum_White(Op, Monte, SNR, Output_type)

% SYNTAXE: est_can=fmncr(sig_cap,M);
%
% est_can : estimateur du canal de transmission
%
% sig_capteur: tableau des observations T x q
% M : degres des filtres

num_sq    = Op{1};     % number of sig sequences
L         = Op{2};     % number of the sensors
M         = Op{3};     % length of the channel 
Ch_type   = Op{4};     % complex
Mod_type  = Op{5};     

Monte     = Monte;
SNR       = SNR;       % Signal to noise ratio (dB)
Output_type = Output_type;

% Generate input signal
modulation = {'Bin', 'QPSK', 'QAM4', 'QAM16'};

res_b     = [];
for monte = 1:Monte
%     fprintf('------------------------------------------------------------\nExperience No %d \n', monte); 

    %% Generate channel
    H         = Generate_channel(L, M, Ch_type);
    H         = H / norm(H, 'fro');
    
    %% Generate signals
    [sig, data] = eval(strcat(modulation{Mod_type}, '(num_sq + M)'));
    
    % Signal rec
    sig_rec_noiseless = [];
    for l = 1:L
        sig_rec_noiseless(:, l) = conv( H(l,:).', sig ) ;
    end
    sig_rec_noiseless = sig_rec_noiseless(M+1:num_sq + M, :);

    err_b = [];
    for snr_i = SNR
%         fprintf('Working at SNR: %d dB\n', snr_i);
        sig_rec = awgn(sig_rec_noiseless, snr_i);

        %% Algorithm CR Minimum
        % Calcul de la forme quadratique Q
        Q       = cal_YMCRB(sig_rec,M);
            
        [u,s,v] = svd(Q);
        h1      = [sqrt(2)*u(1:M+1,L*(M+1));u(M+2:(L-1)*(M+1),L*(M+1)); ...
			        sqrt(2)*u((L-1)*(M+1)+1:L*(M+1),L*(M+1))];    %% for Y3
        h       = h1* exp(-sqrt(-1)*angle(h1(1)));
        h_est   = h / norm(h,'fro');

        % Compute MSE Channel
        ER_SNR  = ER_func(H, h_est, Mod_type, Output_type);

        err_b   = [err_b, ER_SNR];
    end
    
    res_b   = [res_b;  err_b];
end

% Return
if Monte ~= 1
    Err = mean(res_b);
else
    Err = res_b;
end