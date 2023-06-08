function [SNR, Err] = B_CMA_Grad_Unidimensional(Op, Monte, SNR, Output_type)

%% Unidimensional Constant Modulus Algorithm
%
%% Input:
    % + 1. N: number of samples
    % + 2. ChL: Channel order
    % + 3. Ch_type: Type of the channel (real, complex, specular,
    % user's input)
    % + 4. Mod_type: Type of modulation (Bin, QPSK, 4-QAM)
    % + 5. mu: Step size
    % + 6. L: Length of the CMA filter
    % + 7. Monte: Simulation times
    % + 8. SNR: Range of the SNR
    % + 9. Ouput_type: SER / BER / MSE Signal
%
%% Output:
    % + 1. SNR: Range of the SNR
    % + 2. Err: Error rate
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Generate input signal
    %     X <= h^T * s + n
    % Step 3: 
    % Step 4: Analytical CMA algorithm
    % Step 5: Compute Error rate
    %     Demodulate Y
    %     Compute SER / BER / MSE Sig
    % Step 6: Return 
%
% Ref: 
%
%% Require R2006A

% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 08-Jun-2023 16:13:00.


% Initialize variables
N       = Op{1};         % number of sample data
Num_Ch  = Op{2};         % number of channels
ChL     = Op{3};         % length of the channel
Ch_type = Op{4};         % complex
Mod_type= Op{5};
L       = Op{6};         % Window length
Monte   = Monte;
SNR     = SNR;
Output_type = Output_type;

% Generate input signal
modulation = {'Bin', 'QPSK', 'QAM4'};

ER_f = [];
for Monte_i = 1:Monte
    [sig, data] = eval(strcat(modulation{Mod_type}, '(N + ChL)'));

    H           = Generate_channel(Num_Ch, ChL, Ch_type);

    sig_rec = [];
        for l = 1:Num_Ch
            sig_rec(:, l) = conv( H(l,:).', sig ) ;
        end
    x           = sig_rec(ChL+1:N + ChL, :);
    
    ER_SNR     = [];
    for SNR_i   = 1:length(SNR)
        X       = awgn(x, SNR(SNR_i));              % received noisy signal
        
        %% CMA estimator
        CM      = abs(sig(1));
        d       = floor(L*Num_Ch/2);
        W       = [zeros(d, 1); 1 ; zeros(L*Num_Ch-d-1,1)];
        Xn      = [];
        
        for jj  = 1:10
            for ii = L:N
                x1      =X(ii:-1:(ii-L+1),:);
                Zn      = x1(:);
                if jj == 1
                    Xn  =[Xn Zn];
                end
            
                y       = W'*Zn;
                ep      = (CM-abs(y)^2)*conj(y);
            
                c       = (y^2-1)^2;
                b       = -16*c*(Zn'*Zn);
            
                L1      = -2*c/b;
                Wb      = W+(L1*ep*Zn);
                yb      = Wb'*Zn;
                d       = (yb^2-1)^2;
            
                a       = (d-(L1*b)-c)/(L1^2);
            
                mu      = -b/(2*a);
            
                W       = W+(mu*Zn*ep);
            end
        end

        if any(isnan(W(:)))
            error('W matrix includes N/A values. Please choose a lower step size (mu) value.');
        end
        est_src_b   = conj(Xn'*W);
        
        % Compute Error rate / MSE Signal
        for win=1:ChL+L
            sig_src_b       = sig(win:N+win-L);                                                   
            data_src        = data(win:N+win-L);  
            Err_tmp(win)    = ER_func(data_src, est_src_b, Mod_type, Output_type, sig_src_b);
        end
        ER_SNR(end+1)  = min(Err_tmp);
    end
    ER_f = [ER_f; ER_SNR];
end

% Return
if Monte ~= 1
    Err = mean(ER_f);
else
    Err = ER_f;
end