function [SNR, Err] = B_CS_MNS(Op, Monte, SNR, Output_type)

% calcule un estimateur des coefficients des canaux par la methode MNS.
% syntaxe: est_can= fmns(can,Pi,L,N,M)
%
% Input:
%          can: coeff exacts des canaux
%          Pi = Noise eigenvectors NL x (L-1) 
%          L = nombre de canaux
%          N = taille du snapshot (i.e., nombre de decalage temporels)
%          pour chaque canaux
%          M = degre des polynomes associes aux canaux 
%
% Output
%          est_can = coefficients estimes des canaux

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

        %% Algorithm CS MNS
        tmp     = H.';
        can     = tmp(:);
        can     = can*exp(-1i*angle(can(1)));

        R       = EstimateCov(sig_rec, num_sq, L, N);

        %.. Estimation of the noise-eigenvectors
        Pi      = zeros(N*L,L-1);
        for ii  = 1:L-1
            Rii = [R(1:N,1:N),R(1:N,ii*N+1:(ii+1)*N); ...
                R(ii*N+1:(ii+1)*N,1:N),R(ii*N+1:(ii+1)*N,ii*N+1:(ii+1)*N)];
            [u,s,v] = svd(Rii);
            x   = [u(1:N,2*N);zeros((ii-1)*N,1);u(N+1:2*N,2*N);zeros((L-ii-1)*N,1)];
            Pi(:,ii) = x;
        end
        %
        %... calcul des produits < vec bruit | mat base >
        %
        BB      = zeros(L-1, L*(M+1)*(M+N));
        icol    = 1:M+N;
        for icap=1:L
            Ecap=Pi(N*(icap-1)+1:N*icap,:)';
            for jdec=1:M+1
    	        B = zeros(L-1,M+N);
    	        B (:,jdec:jdec+N-1)=Ecap;
                BB(:,icol) = B;
                icol=icol+M+N;
            end
        end
        Q       = zeros(L*(M+1),L*(M+1));
        %
        %... calcul de la forme quadratique
        %
        B1      = zeros((L-1)*(M+N),1);
        B2      = zeros((L-1)*(M+N),1);
        for ii  = 1:L*(M+1)
            for jj=1:L*(M+1)
                icoli = (ii-1)*(M+N)+1:ii*(M+N);
                icolj = (jj-1)*(M+N)+1:jj*(M+N);
                B1(:) = BB(:,icoli);
                B2(:) = BB(:,icolj);
                Q(ii,jj) = B1'*B2;
            end
        end
        [u,v]   = eig(Q);
        [k,l]   = sort(diag(v));
        h_est   = u(:,l(1));
        h_est   = h_est*h_est'*can;

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