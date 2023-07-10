function Err = NB_FINE (Op, SNR_i)

%% Fisher Information Neural Estimation
%
%% Input:
    % + 1. data_size: number of sample data
    % + 2. delta_arr: number of transmit antennas
    % + 3. Epochs: number of receive antennas
    % + 4. lr: length of the channel
    % + 5. SNR_i: signal noise ratio
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
% Last Modified by Son 10-Jul-2023 11:13:13 


% Initialize variables
data_size  = Op{1};    % Data size
delta_arr  = Op{2};    % delta
Epochs     = Op{3};    % max epochs
lr         = Op{4};    % learning-rate 

OS_support = {'OS_WINDOWS', 'OS_LINUX'};
ls_pkgs = {'numpy', 'torch', 'multiprocessing', 'tqdm', 'matplotlib'};

if ~Check_Installed_pkgs(OS_support, ls_pkgs)
    return
end

global main_path;
file_path = fullfile(main_path, 'Algorithms', 'CRB_Mode', 'Non-blind', 'FINE', 'NB_FINE.py');
global InSI_time;
timestamp_id = num2str(round(posixtime(InSI_time)));

[status, ~, Err] = Run_py_script(file_path, timestamp_id, data_size, delta_arr, Epochs, lr, SNR_i);
if status == 1
    return
end

end