function [SNR, Err] = SB_FIR (Op, Monte, SNR)

% Initialize variables
Nt  = Op{1};    % number of transmit antennas
Nr  = Op{2};    % number of receive antennas
L   = Op{3};    % channel order
M   = Op{4};    % Number of multipaths 
K   = Op{5};    % OFDM subcarriers
ratio = Op{6};  % Pilot/Data Power ratio

Monte   = Monte;
SNR     = SNR;

F  = dftmtx(K);
FL  = F(:,1:L);
sigmax2=1;

Err_f = [];
for Monte_i = 1:Monte
    %% Signal Generation
    % we use the Zadoff-Chu sequences
    U = 1:2:7;
    ZC_p = [];
    for u = 1 : Nt
        for k = 1 : K
            ZC(k,u) = ratio * exp( ( -1i * pi * U(u) * (k-1)^2 ) / K );
        end
        ZC_p = [ZC_p; ZC(:,u)];
    end
    
    %% Channel generation: In this time, channel effects are fixed.
    % Fading, delay, DOA matrix of size(M,Nt), M - the number of multipath
    fading = rand(M,Nt)+1i*rand(M,Nt);
    delay  = 0.1+(0.15-0.1)*rand(M,Nt)*0.01;
    DOA    = (-0.5+(0.5-(-0.5))*rand(M,Nt))*pi;
    
    %% ------------------------------------------------------------------------
    
    X = [];
    for ii = 1 : Nt
        X        = [X diag(ZC(:,ii))*FL];
    end
    
    
    [H, h_true]        = gen_chan(fading,delay,DOA,Nr,L,Nt);
    
    
    %% CRB 
    % Loop SNR
    
    
    %============================================
    %LAMBDA
    LAMBDA  = [];
    for jj = 1 : Nt
        lambda_j =[];
        for r = 1 : Nr
            h_rj       = transpose(H(r,:,jj));
            lambda_rj  = diag(FL*h_rj);
            lambda_j   = [lambda_j; lambda_rj];
        end
        LAMBDA = [LAMBDA lambda_j];
    end
    
    % Partial derivative of LAMBDA w.r.t. h_i
    partial_LAMBDA  = cell(1,L);
    for ll = 1 : L
        partial_LAMBDA_ll = [];
        for jj = 1 : Nt
            lambda_jj =[];
            for r = 1 : Nr
                lambda_rj_ll = diag(FL(:,ll));
                lambda_jj    = [lambda_jj; lambda_rj_ll];
            end
        partial_LAMBDA_ll = [partial_LAMBDA_ll lambda_jj];
        end
        partial_LAMBDA{1, ll} =  partial_LAMBDA_ll;
    end
    
    
    N_total = 4;
    N_pilot = 2;
    N_data  = N_total-N_pilot;
    Err_SNR = [];
    %============================================
    for snr_i = 1 : length(SNR)
        sigmav2 = 10^(-SNR(snr_i)/10);
    %============================================
        %Only Pilot    
        X_nga=kron(eye(Nr),X);
    %============================================
        %Only Pilot Normal
        Iop      = X_nga'*X_nga / sigmav2;
    
    %SemiBlind
        Cyy      = sigmax2 * LAMBDA * LAMBDA'  + sigmav2 * eye(K*Nr);
        Cyy_inv  = pinv(Cyy);
    
        for ii = 1 : L
            partial_Cyy_hii = sigmax2 * LAMBDA * partial_LAMBDA{1,ii}';
            for jj = 1 : L   
                partial_Cyy_hjj = sigmax2 * LAMBDA * partial_LAMBDA{1,jj}';
                % Slepian-Bangs Formula
                I_D(ii,jj) = trace(Cyy_inv * partial_Cyy_hii * Cyy_inv * partial_Cyy_hjj);
                I_D(ii,jj) = I_D(ii,jj)';
            end
        end
        I_D = triu(repmat(I_D, Nr*Nt, Nr*Nt));
    %============================================
    %Semiblind Normal
        I_SB       = N_data*I_D + N_pilot*Iop;
        CRB_SB_i   = pinv(I_SB);
        Err_SNR(snr_i) = abs(trace(CRB_SB_i));
    
       clear I_D;
    end
    Err_f = [Err_f; Err_SNR];
end

% Return
if Monte ~= 1
    Err = mean(Err_f);
else
    Err = Err_f;
end

end