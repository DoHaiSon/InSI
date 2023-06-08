function [SNR, Err] = NB_FINE (Op, Monte, SNR)

%% Fisher Information Neural Estimation
%
%% Input:
    % + 1. data_size: number of sample data
    % + 2. delta_arr: number of transmit antennas
    % + 3. Epochs: number of receive antennas
    % + 4. lr: length of the channel
    % + 5. Monte: simulation times
    % + 6. SNR: range of the SNR
%
%% Output:
    % + SNR: range of the SNR
    % + Err: CRB
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
% Last Modified by Son 08-Jun-2023 16:52:13 


% Initialize variables
data_size  = Op{1};    % Data size
delta_arr  = Op{2};    % delta
Epochs     = Op{3};    % max epochs
lr         = Op{4};    % learning-rate 

Monte   = Monte;
SNR     = SNR;

OS_support = {'OS_WINDOWS', 'OS_LINUX'};
ls_pkgs = {'numpy', 'torch', 'multiprocessing', 'tqdm', 'matplotlib'};

if ~Check_Installed_pkgs(OS_support, ls_pkgs)
    return
end

global main_path;
file_path = fullfile(main_path, 'Algorithms', 'CRB_Mode', 'Non-blind', 'FINE', 'NB_FINE.py');

Err_f = [];
for Monte_i = 1:Monte
    [status, ~, Err] = Run_py_script(file_path, data_size, delta_arr, Epochs, lr, Monte, SNR);
    if status == 1
        Err_f = [Err_f; Err];
    end
end

% Return
if Monte ~= 1
    Err = mean(Err_f);
else
    Err = Err_f;
end

end