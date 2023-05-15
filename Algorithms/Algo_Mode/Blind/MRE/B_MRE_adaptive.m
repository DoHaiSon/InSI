function [SNR, Err] = B_MRE_adaptive(Op, Monte, SNR, Output_type)

num_sq    = Op{1};     % number of sig sequences
L         = Op{2};     % number of the sensors
M         = Op{3};     % length of the channel
Ch_type   = Op{4};     % complex
Mod_type  = Op{5};     
N         = Op{6};     % number of measurements
mu        = Op{7};     % Step size
K         = M + N;     % rank of H
Monte     = Monte;
SNR       = SNR;       % Signal to noise ratio (dB)
Output_type = Output_type;

% Generate input signal
modulation = {'Bin', 'QPSK', 'QAM4', 'QAM16'};

res_b     = [];
for monte = 1:Monte
    err_b = [];

    %% Generate channel
    H         = Generate_channel(L, M, Ch_type);
    
    %% Generate signals
    [sig_src, data] = eval(strcat(modulation{Mod_type}, '(num_sq + M)'));
    
    % Signal rec
    sig_rec = [];
    for l = 1:L
        sig_rec(:, l) = conv( H(l,:).', sig_src ) ;
    end
    sig_rec = sig_rec(M+1:num_sq + M, :);

    for snr_i = SNR

        sig_rec_i = awgn(sig_rec, snr_i);

        %% MRE
        Vt      = zeros(K, L*N);
        X       = [];
        for ii  = 1:L
          x     = sig_rec_i(:, ii);
          mat   = hankel(x(1:N), x(N:num_sq));
          mat   = mat(N:-1:1, :);
          X     = [X; mat];
        end
        
        %% ----------------------------------------------------------------
        %% MRE Adaptive implementation
        V_b     = ones(L*N, K);
    
        for i = 1:num_sq - N
            E_n     = [eye(K-1), zeros(K-1, 1)] * V_b' * X(:, i) - ...
                      [zeros(K-1, 1), eye(K-1)] * V_b' * X(:, i+1);
    
            V_dev   = X(:, i) * E_n' * [eye(K-1), zeros(K-1, 1)] - ...
                      X(:, i+1) * E_n' * [zeros(K-1, 1), eye(K-1)];
    
            V_b     = V_b - mu * V_dev;                                       
    
            V_b     = V_b / norm(V_b);                                      % unit-norm constraint
    
            V_b(1,1) = 1;                                                   % linear constraint
        end

        %% ----------------------------------------------------------------
        %% Select the Equalizer has min norm
        for ii  = 1:K
          x_b(ii)   = norm(V_b(:,ii));
        end
        [~, ind_b]  = min(x_b);
        
        % Equalization
        est_src_b   = conj(X' * V_b(:, ind_b));
        sig_src_b   = sig_src(K-ind_b+1:num_sq+M-ind_b+1);
        data_src    = data(K-ind_b+1:num_sq+M-ind_b+1);  
        
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