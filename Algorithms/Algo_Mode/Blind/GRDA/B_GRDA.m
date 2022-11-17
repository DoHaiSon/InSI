function [SNR, Err] = B_GRDA(Op, Monte, SNR, Output_type)
% function [gmin,gmax]=GRDA(c,Rshift,m)
%        [gmin,gmax]=GRDA(c,Rshift,m) : l-taps Eqzer
% version de IEEESP
% Rshift : correlation (c*l)-square ST-format
%          l : longeur du egalizeur
% m : ordre de canal,  Eventuellement over estimated
% gmin/gmax ZF equalizers 0(min) delay et m+l(max) delay
% tous les deux choisis selon EPC


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
        %% Blind GRDA program
        [R, Y]  = EstimateCor(sig_rec, num_sq, L, N);

        lncol   = size(R);
        if lncol(1)~=lncol(2)       
            input('GRDA error 1');
            exit;
        end
        l       = lncol(1)/L;
        if floor(l)~=l 
            input('GRDA error 2');
            exit;
        end
        if L*l<=M+l 
            input('GRDA error 3');
            exit;
        end
        
        gammas    = [R(L+1:2*L,1:L) R(1:L,1:L*min([M l]))];
        noiseng   = noisengFROMSOS(L,CORRshift(min([M l]),0,gammas,1),M);
        gammasNF  = gammas;gammasNF(:,1:L)=gammas(:,1:L)-noiseng*eye(L);
        RshiftNF  = R-noiseng*kron(Jmtx(l).',eye(L));
        Gmax      = conj(XSING(RshiftNF,(L-1)*l-M+1,0,1));
        Gmin      = conj(XSING(RshiftNF,(L-1)*l-M+1,1,1));
        
        RNF       = CORRshift(l,0,gammasNF,1);
        [S_l,delta] = XEIG(RNF,l+M,0);
        RNF_pinv  = S_l*diag(1./(delta-noiseng))*S_l';
        
        gmax      = Gmax*XEIG(Gmax'*RNF.'*Gmax,1,0);
        gmin      = Gmin*XEIG(Gmin'*RNF.'*Gmin,1,0);
        
        est_src_b = gmax'* Y;
        est_src_b = est_src_b.';
        
        % Equalization
        sig_src_b   = sig_src(1:num_sq-N+1);
        data_src    = data(1:num_sq-N+1);  

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