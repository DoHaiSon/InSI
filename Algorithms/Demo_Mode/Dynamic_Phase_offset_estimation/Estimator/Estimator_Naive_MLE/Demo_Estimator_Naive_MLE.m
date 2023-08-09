function Err = Demo_Estimator_Naive_MLE (Op, SNR_i, ~)

%% Naive Maximum Likelihood
%
%% Input:
    % + 1. K: block length
    % + 2. data_size: number of sample data
    % + 3. Mod_type: type of modulation (All)
    % + 4. sigma_w: noise variance
    % + 5. Epochs: number of training epochs
    % + 6. lr: learning rate
    % + 7. SNR_i: signal noise ratio
%
%% Output:
    % + 1. Err: CRB
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Return 
%
% Ref: Tran Trong Duy, Nguyen Van Ly, Nguyen Linh Trung, and 
% Karim Abed-Meraim, "Fisher information estimation using neural 
% networks," REV Journal on Electronics and Communications, vol.
% 13, no. 1-2, Jan-Jun, 2023.
%
%% Require R2014B

% Author: Tran Trong Duy, Vietnam National University, Hanoi, Vietnam

% Adapted for InSI by Do Hai Son, 29-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless Communications
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


% Initialize variables
K          = Op{1};    % K-dimensionals
data_size  = Op{2};    % Data size
Mod_type   = Op{3};
sigma_w    = Op{4};    % sigma_w
Epochs     = Op{5};    % max epochs
lr         = Op{6};    % learning-rate 


OS_support = {'OS_WINDOWS', 'OS_LINUX'};
ls_pkgs = {'numpy', 'torch', 'tqdm'};

if ~Check_Installed_pkgs(OS_support, ls_pkgs)
    return
end

global main_path;
file_path = fullfile(main_path, 'Algorithms', 'Demo_Mode', 'Dynamic_Phase_offset_estimation', 'Estimator', 'Estimator_Naive_MLE', 'Demo_Estimator_Naive_MLE.py');
global InSI_time;
timestamp_id = num2str(round(posixtime(InSI_time)));

modulation = {'Bin', 'QPSK', 'QAM4', 'QAM16'};

[status, ~, Err] = Run_py_script(file_path, timestamp_id, K, data_size, Mod_type, sigma_w, Epochs, lr, SNR_i);
if status == 1
    return
end

end