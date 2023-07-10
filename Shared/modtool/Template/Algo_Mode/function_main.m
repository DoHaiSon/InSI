function Err = function_main(Op, SNR_i, Output_type)

% Modtool algorithm

% Initialize variables
flag  


%% -----------------------------------------------------------------
%% Modify here

% Generate signals
[sig_src, data] = QAM4(1000);

est_src = sig_src;
data_src= data;  

% Equalization

% Compare to src signals
Err  = ER_func(data_src, est_src, 3, Output_type, sig_src);

end