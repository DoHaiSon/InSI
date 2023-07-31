function Err = SI_ISDNN_structured (Op, SNR_i, Output_type)

%% Iterative Sequential Deep-neural Network for structured channel model
%
%% Input:
    % + 1. N_test: number of samples to test
    % + 2. config: configuration of antenna arrays 
    % + 3. sigma: Error rate when generate dataset
    % + 4. SNR_i: signal noise ratio
    % + 5. Output_type: BER
%
%% Output:
    % + 1. Err: BER
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Return 
%
% Ref: Do Hai Son, Nghiên cứu nhận dạng hệ thống với tri thức mới
% cho hệ thống truyền thông MIMO kích thước lớn, University of 
% Engineering and Technology, Vietnam national University Hanoi, 
% Jun. 2023
%
%% Require R2014B

% Author: Do Hai Son, Vietnam National University, Hanoi, Vietnam

% Adapted for InSI by Do Hai Son, 30-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless Communications
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


% Initialize variables
N_test  = Op{1};    % number of samples to test
config  = Op{2};    % configuration of antenna arrays 
sigma   = Op{3};    % Error rate when generate dataset


OS_support = {'OS_WINDOWS', 'OS_LINUX'};
ls_pkgs = {'numpy', 'torch'};

if ~Check_Installed_pkgs(OS_support, ls_pkgs)
    return
end

global main_path;
file_path = fullfile(main_path, 'Algorithms', 'Algo_Mode', 'Side-information', 'ISDNN_structured', 'SI_ISDNN_structured.py');
global InSI_time;
timestamp_id = num2str(round(posixtime(InSI_time)));

configurations = {'ULA', 'UCyA'};

[status, ~, Err] = Run_py_script(file_path, timestamp_id, N_test, configurations{config}, SNR_i, sigma);
if status == 1
    return
end

end