function [SNR, Err] = B_MRE_linear(Op, Monte, SNR, Output_type)

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
modulation = {'Bin', 'QPSK', 'QAM4', 'QAM16'};

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

        %% MRE
        Vt      = zeros(K, L*N);
        X       = [];
        for ii  = 1:L
          x     = sig_rec(:, ii);
          mat   = hankel(x(1:N), x(N:num_sq));
          mat   = mat(N:-1:1, :);
          X     = [X; mat];
        end
        
        %% ----------------------------------------------------------------
        %% Batch Implementations
        % MRE error function: 
        R_0     = zeros(L*N, L*N);
        R_1     = zeros(L*N, L*N);
        for i   = 1:num_sq - N
            X_n     = X(:, i);
            X_n_1   = X(:, i+1);
            R_0     = R_0 + (X_n * X_n');
            R_1     = R_1 + (X_n_1 * X_n');
        end
        R_0 = R_0 ./ (num_sq - N);
        R_1 = R_1 ./ (num_sq - N);
    
        % Create R
        R = kron(diag(-1*ones(K-1,1), -1), R_1);
        R = R + R';
        b_diag = 2 * eye(K);
        b_diag(1,1) = 1;
        b_diag(K,K) = 1;
        R = R + kron(b_diag, R_0);
    
        %% C2-MRE method
        % V_opt
        U       = zeros(L*N*K, 1);
        U(1)    = 1;
        
        V       = (inv(R) * U) / (U' * inv(R) * U);
    
        % Reshape V
        V_b     = reshape(V, [L*N, K]);
        
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