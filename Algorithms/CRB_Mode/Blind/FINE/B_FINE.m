function Err = B_FINE (Op, SNR_i)

%% Fisher Information Neural Estimation
%
%% Input:
    % + 1. K: number of Gaussian distribution's dimensionals
    % + 2. data_size: number of sample data
    % + 3. Mod_type: type of modulation (All)
    % + 4. sigma_w: noise variance
    % + 5. Epochs: number of receive antennas
    % + 6. lr: length of the channel
    % + 7. SNR_i: signal noise ratio
%
%% Output:
    % + 1. Err: CRB
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Return 
%
% Ref: T. T. Duy, L. V. Nguyen, V. -D. Nguyen, N. L. Trung, and 
% K. Abed-Meraim, "Fisher Information Neural Estimation," in 30th
% European Signal Processing Conference (EUSIPCO), Belgrade,
% Serbia, 2022, pp. 2111-2115.

% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 15-Jul-2023 17:54:00 


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
file_path = fullfile(main_path, 'Algorithms', 'CRB_Mode', 'Blind', 'FINE', 'B_FINE.py');
global InSI_time;
timestamp_id = num2str(round(posixtime(InSI_time)));

modulation = {'Bin', 'QPSK', 'QAM4', 'QAM16', 'QAM64', 'QAM256'};

[status, ~, Err] = Run_py_script(file_path, timestamp_id, K, data_size, Mod_type, sigma_w, Epochs, lr, SNR_i);
if status == 1
    return
end

end