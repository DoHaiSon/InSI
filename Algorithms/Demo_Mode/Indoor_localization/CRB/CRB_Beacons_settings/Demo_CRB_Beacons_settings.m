function [xaxis, Err] = Demo_CRB_Beacons_settings (Op, ~, ~)

%% BCRB vs. Beacon settings
%
%% Input:
    % + 1. Epochs: number of receive antennas
    % + 2. lr: length of the channel
    % + 3. B1: status on/off of Beacon 1
    % + 4. B2: status on/off of Beacon 2
    % + 5. B3: status on/off of Beacon 3
    % + 6. B4: status on/off of Beacon 4
    % + 7. B5: status on/off of Beacon 5
    % + 8. B6: status on/off of Beacon 6
    % + 9. B7: status on/off of Beacon 7
    % + 10. B8: status on/off of Beacon 8
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
Epochs     = Op{1};    % max epochs
lr         = Op{2};    % learning-rate 
B1         = Op{3};    % status on/off of Beacon 1
B2         = Op{4};    % status on/off of Beacon 2
B3         = Op{5};    % status on/off of Beacon 3
B4         = Op{6};    % status on/off of Beacon 4
B5         = Op{7};    % status on/off of Beacon 5
B6         = Op{8};    % status on/off of Beacon 6
B7         = Op{9};    % status on/off of Beacon 7
B8         = Op{10};    % status on/off of Beacon 8


OS_support = {'OS_WINDOWS', 'OS_LINUX'};
ls_pkgs = {'numpy', 'torch', 'tqdm', 'scipy'};

if ~Check_Installed_pkgs(OS_support, ls_pkgs)
    return
end

global main_path;
file_path = fullfile(main_path, 'Algorithms', 'Demo_Mode', 'Indoor_localization', 'CRB', 'CRB_Beacons_settings', 'Demo_CRB_Beacons_settings.py');
global InSI_time;
timestamp_id = num2str(round(posixtime(InSI_time)));


[status, xaxis, Err] = Run_py_script(file_path, timestamp_id, Epochs, lr, B1, B2, B3, B4, B5, B6, B7, B8);
if status == 1
    return
end

end