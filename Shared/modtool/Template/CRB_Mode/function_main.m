function [SNR, Err] = function_main (Op, Monte, SNR)

% Modtool algorithm

% Initialize variables
flag  

Monte = Monte;     % Number of experiences
SNR   = SNR;       % Signal to noise ratio (dB)

Err_f = [];
for Monte_i = 1:Monte

    Err_SNR = [];
    %============================================
    for snr_i = 1 : length(SNR)
        
        Err_SNR(snr_i) = 0.1;
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