function [SNR, Err] = B_CS_SCMA(Op, Monte, SNR, Output_type)

%% SCMA Channel Subspace
%
%% Input:
    % + 1. num_sq: number of samples
    % + 2. L: number of channels
    % + 3. M: Channel order
    % + 4. Ch_type: Type of the channel (real, complex, specular,
    % user's input)
    % + 5. Mod_type: Type of modulation (All)
    % + 6. N: Window length
    % + 7. Monte: Simulation times
    % + 8. SNR: Range of the SNR
    % + 9. Ouput_type: MSE Channel
%
%% Output:
    % + 1. SNR: Range of the SNR
    % + 2. Err: MSE Channel
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Generate input signal
    %     X <= h^T * s + n
    % Step 3: 
    % Step 4: CS algorithm
    % Step 5: Compute MSE Channel
    % Step 6: Return 
%
% Ref: 
%
%% Require R2006A

% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 08-Jun-2023 16:13:00.


num_sq    = Op{1};     % number of sig sequences
L         = Op{2};     % number of the sensors
M         = Op{3};     % length of the channel 
Ch_type   = Op{4};     % complex
Mod_type  = Op{5};     
N         = Op{6};     % Window length
Nb        = N * L - (M + N + 1);

Monte     = Monte;
SNR       = SNR;       % Signal to noise ratio (dB)
Output_type = Output_type;

% Generate input signal
modulation = {'Bin', 'QPSK', 'QAM4', 'QAM16', 'QAM64', 'QAM128', 'QAM256'};

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

        %% Algorithm CS SCMA
        M_1     = M+1;
        M_est   = M_1;

    	%::::: estimation des statistiques
    	[R_est, X_N] = EstimateCov_modif(sig_rec,num_sq,L,N);
    	[U_est, Sigma, V_est] = svd(R_est);
    	R_est_inv = U_est(:,1:M_est+N-1)*pinv(Sigma(1:M_est+N-1,1:M_est+N-1))*U_est(:,1:M_est+N-1)';
        U_n     = U_est(:,M_est+N+1:L*N);
    	noise_proj = U_n * U_n';
    	D       = zeros(L*N*(M_est+N),L*(M_est+N));

        for i = 0: N-1
            block = noise_proj(:,i*L+1:(i+1)*L);
            D   = kron(diag(ones(N+M_est-i,1),-i),block) + D;
        end

    	D_fin   = D(:,1:L*M_est);
    	[U, Sigma_1, V] = svd(D_fin'*D_fin);
    	L_1     = M_est - M + 1;			% L derniers vecteurs propres
    	U_L     = U(:,L*M_est-L_1+1:L*M_est);
        U_LL    = [];
        for ii= 1:M_est
            U_LL = [U_L((ii-1)*L+1:ii*L,:);U_LL];
        end

        %::::  CRITERE CMA
        W       = R_est_inv*[U_LL;zeros(L*(N-M_est),L_1)];
        Z_N     = W.'*X_N;
        
        V       = CS_HCMA(Z_N,L_1);

        H_est_vect = U_LL*V;
        H_est   = reshape(H_est_vect,L,M_est);
        h_est   = fliplr(H_est);

        

        h_est   = h_est.';
        h_est   = h_est(:);

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