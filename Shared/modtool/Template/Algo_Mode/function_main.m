function [SNR, Err] = function_main(Op, Monte, SNR, Output_type)

% Initialize variables
flag  

Monte     = Monte;     % Number of experiences
SNR       = SNR;       % Signal to noise ratio (dB)
Output_type = Output_type; % BER / SER / MSE H

res_b     = [];
for monte = 1:Monte
    fprintf('------------------------------------------------------------\nExperience No %d \n', monte); 
    err_b = [];
    for snr_i = SNR
        fprintf('Working at SNR: %d dB\n', snr_i);


        %% -----------------------------------------------------------------
        %% Modify here

        % Generate signals
        [sig_src, data] = QAM4(1000);
        
        est_src = sig_src;
        data_src= data;  

        % Equalization

        % Compare to src signals
        ER_SNR  = ER_func(data_src, est_src, 3, Output_type, sig_src);

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