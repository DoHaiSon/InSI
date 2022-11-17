function [SNR, Err] = B_TSML(Op, Monte, SNR, Output_type)

% SYNTAXE: est_can=ftsml2(sig_rec,M,q,can,T);
%
% est_can : estimateur du canal de transmission
%
% sig_rec: observations T x q
% M : degres des filtres
% q : number of sensors
% T : sample size
% can: exact channel coeff.

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
    [sig_src, data] = eval(strcat(modulation{Mod_type}, '(num_sq + M)'));
    
    % Signal rec
    sig_rec = [];
    for l = 1:L
        sig_rec(:, l) = conv( H(l,:).', sig_src ) ;
    end
    sig_rec = sig_rec(M+1:num_sq + M, :);

    err_b = [];
    for snr_i = SNR
%         fprintf('Working at SNR: %d dB\n', snr_i);
        sig_rec = awgn(sig_rec, snr_i);

        %% Algorithm TSML
        mu      = 0;

        [Q,Y]   = cal_Y(sig_rec, M);
        [u,v]   = eig(Q);
        [k,ord] = sort(diag(v));
        h       = u(:,ord(1));
        h       = h*exp(-1i*angle(h(1)));
        est_can0=h;

        x       = zeros(M+1,L);
        x(:)    = est_can0;
        can0    = x.';
        G       = calcG(can0,num_sq);
        I       = eye(length(G(:,1)));
        W       = pinv(G*G'+mu*I);
        Q       = cal_Q(sig_rec,M,W,num_sq);

        [u,v]   = eig(Q);
        [k,ord] = sort(diag(v));
        h       = u(:,ord(1));
        fcan    = H(:);
        h       = h*h'*fcan;
        h_est   = h*exp(-1i*angle(h(1)));

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