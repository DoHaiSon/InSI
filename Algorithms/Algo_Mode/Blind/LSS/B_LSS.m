function [SNR, Err] = B_LSS(Op, Monte, SNR, Output_type)

num_sq    = Op{1};     % number of sig sequences
L         = Op{2};     % number of the sensors
M         = Op{3};     % length of the channel 
Ch_type   = Op{4};     % complex
Mod_type  = Op{5};     
N         = M;         % Window length

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

        %% Algorithm LSS
        d       = M;
        % Formation de la Matrice Y Zd (Zdp,Zdf)
        Y       = [];
        Zdf     = [];
        Zdp     = [];
        cs      = 2*d+3*N-2;
        for ii  = d+2*N-1:-1:d+N-1
            x1  = sig_rec(ii:num_sq+ii-cs,:);
            x1  = x1.';
            Y   = [Y;x1];
        end

        for ii  = cs:-1:d+2*N
            x2  = sig_rec(ii:num_sq+ii-cs,:);
            x2  = x2.';
            Zdf = [Zdf;x2];
        end

        for ii  = 2*N-2:-1:1
            x3  = sig_rec(ii:num_sq+ii-cs,:);
            x3  = x3.';
            Zdp = [Zdp;x3];
        end

        Zd      = [Zdf; Zdp];
        [Q1,Q2,Qt] = svd(Zd);
        Q       = Qt(:,1:3*N+2*M+d-3);

        Ed      = Y-(Y*Q*Q');
        [Ue,Q3,Q4] = svd(Ed);
        h_est   = Ue(:,1);

        h       = reshape(h_est,L,M+1);
        h       = h(:,M+1:-1:1);
        h       = h.';
        h_est_1 = h(:);

        % Compute MSE Channel
        ER_SNR  = ER_func(H, h_est_1, Mod_type, Output_type);

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