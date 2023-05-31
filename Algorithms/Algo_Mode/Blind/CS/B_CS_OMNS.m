function [SNR, Err] = B_CS_OMNS(Op, Monte, SNR, Output_type)

% calcule un estimateur des coefficients des H par la methode MNS.
% syntaxe: est_can= forth_space(can,Mat_ins,q,p,N,M)
%
% Input:
%          can: coeff exacts des H (on considere le p)
%          Mat_ins = Matrice contenant des vectors orthogonales  
%          q = nombre de H
%          p = nb. d'entree 
%          N = taille du snapshot (i.e., nombre de decalage temporels)
%          pour chaque H
%          M = degre des polynomes associes aux H 
%
% Output:
%          est_can = coefficients estimes des H (qX(M+1)) Xp)

num_sq    = Op{1};     % number of sig sequences
L         = Op{2};     % number of the sensors
M         = Op{3};     % length of the channel 
Ch_type   = Op{4};     % complex
Mod_type  = Op{5};     

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

        %% Algorithm CS OMNS
        tmp     = H.';
        can     = tmp(:);
        can     = can*exp(-1i*angle(can(1)));

        p       = 1;
        tmp     = p*M;
        N       = [];
        step    = 1;

        while ((step)>=1 && step<=(L-p))
            N_new = ceil((tmp+1)/(L-(p+step-1)));  % ... A deteminer la taille de Taux
            tmp = N_new + tmp - 1;
            N   = [N N_new];

            if step == 1
                R = EstimateCov(sig_rec,num_sq,L,N_new);
                [a, sigma, b] = svd(R);
                %clear R;
                Mat_ins = b(:,L*N);
                %clear a sigma b;
                step    = step + 1;
            else
                %...Calcule de taille de Matrice a inserer
                vv      = reshape(Mat_ins,N(step-1),L*(step-1));
                vvv     = [vv; zeros(N_new-N(step-1),L*(step-1))];
                vvvv    = reshape(vvv,L*N_new,(step-1));

                [Taux_N, Taux_N_v] = calcH_tst(H,p,vvvv,N);
                %... test
                R = EstimateCov(sig_rec, num_sq, L, N_new) + Taux_N_v*Taux_N_v';
                [a, sigma, b] = svd(R);
                clear R;
                Mat_ins = b(:,L*N_new);
                %clear a sigma b;
                Mat_ins = [vvvv Mat_ins];
            	step    = step + 1;
            end		%end of step
        end			%end of while

        %----------------------------------------------------
        %... calcul des produits < vec bruit | mat base >
        %
        last_N  = length(N);
        A       = Mat_ins';
        % ... Forme quadratidue
        D_fin   = [];
        for index_out = 1:L
            D   = zeros((L-p)*(M+N(last_N)),(M+N(last_N)));
            for index = 1: N(last_N)
                block = A(:, ((index_out-1)*N(last_N))+index);
                D = kron(diag(ones(N(last_N)+M+1-index,1),-index+1),block) + D;
            end 	%end of index

            D_tmp = D(:,1:(M+1));
            D_fin = [D_fin D_tmp];
        end	%end of index out

        [U, Sigma, V] = svd(D_fin' * D_fin);

        %... ranger des valeurs
        %... pour p = 1
        est_can_tmp = reshape(U(:,L*(M+1)),M+1,L);
        est_can_1   = est_can_tmp;
        est_can     = est_can_1(:);
        % to get rid from the constante matrix
        %

        h_est   = est_can * pinv(est_can) * can;

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