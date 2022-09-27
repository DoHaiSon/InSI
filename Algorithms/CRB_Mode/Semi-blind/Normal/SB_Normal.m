function [SNR, Err] = SB_Normal (Op, Monte, SNR)

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
%fading = rand(M,Nt)+1i*rand(M,Nt);
%fading = 0.1+(0.6-0.1)*rand(M,Nt);
fading=[0.8,0.6,0.4,0.2;0.9,0.7,0.5,0.3];
%delay  = 0.1+(0.15-0.1)*rand(M,Nt)*0.01;
delay=[0.1,0.2,0.3,0.4;0.2,0.3,0.4,0.5]*0.001;
%DOA    = (-0.5+(0.5-(-0.5))*rand(M,Nt))*pi;
DOA=[pi/2,pi/4,pi/6,pi/8;pi/3,pi/5,pi/7,pi/9];
d_nor=1/2;

%H      = spec_chan(fading,delay,DOA,Nr,L,Nt);  % H(Nr,L,Nt)

%h=[];
%for ii = 1 : Nt
%    h              = [h reshape(transpose(H(:,:,ii)),1,Nr*L)];
%end

%hmod2      = (h*h')^2; 
%% Derivative
% w.r.t. fading
%Br_fading = zeros(Nt,M,L);
dev_h_fading_tmp=[];
dev_h_delay_tmp=[];
dev_h_angle_tmp=[];
%dev_h_fading_tmp=cell(Nr,1);

dev_h_fading=[];
dev_h_delay=[];
dev_h_angle=[];

for Nr_index=1:Nr
    Br_fading = SEMI_spec_chan_derive_fading_ULA(fading,delay,DOA,d_nor,Nr_index,L,M,Nt);
    dev_h_fading=[dev_h_fading; transpose(Br_fading)];

    Br_delay = SEMI_spec_chan_derive_delay_ULA(fading,delay,DOA,d_nor,Nr_index,L,M,Nt);
    dev_h_delay=[dev_h_delay; transpose(Br_delay)];

    Br_angle = SEMI_spec_chan_derive_angle_ULA(fading,delay,DOA,d_nor,Nr_index,L,M,Nt);
    dev_h_angle=[dev_h_angle; transpose(Br_angle)];

    %dev_h_fading=[dev_h_fading;Br_fading];
end

%% Derivation of $h$ w.r.t. (bar{h},tau,alpha) %% channel specular parameters

G = [dev_h_fading,dev_h_delay,dev_h_angle]; 
%% ------------------------------------------------------------------------

X = [];
for ii = 1 : Nt
    X        = [X diag(ZC(:,ii))*FL];
end


[H, h_true]        = gen_chan_specular(fading,delay,DOA,Nr,L,Nt);


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
%============================================
for snr_i = 1 : length(SNR)
    sigmav2 = 10^(-SNR(snr_i)/10);
%============================================
    %Only Pilot    
    X_nga=kron(eye(Nr),X);
%============================================
    %Only Pilot Normal
    Iop      = X_nga'*X_nga / sigmav2;
%     Iop_fp   = N_total * Iop;
%     CRB_op(snr_i) = abs(trace(pinv(Iop_fp)));

%============================================
%     %Only Pilot Specular
% 
%     Iop_spec = G*G'*Iop_fp*G*G';
%     CRB_op_spec(snr_i) = abs(trace(pinv(Iop_spec)));
    
%============================================
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
%     CRB_SB_i           = pinv(I_SB);
%     CRB_SB(snr_i)      = abs(trace(CRB_SB_i));

%============================================
%Semiblind Specular
   I_SB_spec=G*G'*I_SB*G*G';
   CRB_SB_spec_i           = pinv(I_SB_spec);
   Err(snr_i)      = abs(trace(CRB_SB_spec_i));
   clear I_D;
end