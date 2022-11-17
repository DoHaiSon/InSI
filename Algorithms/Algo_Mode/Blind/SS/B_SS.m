function [SNR, Err] = B_SS(Op, Monte, SNR, Output_type)
% estimation of source signals using signal subspace method
%
% SYNTAXE est_source = fse(sig_cap, sig_source, N, M, q, T,alpha);
%
% sig_cap : T x q observation matrix
% sig_source : (T+M) x 1 source signal vector
% N : window length
% M : channel degree
% q : number of channels
% T : number of observation
% alpha: alphabet
%
% est_source : estimate of the source signal vector


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