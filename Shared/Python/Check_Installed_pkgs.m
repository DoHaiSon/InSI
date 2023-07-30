function status = Check_Installed_pkgs ( OS_support,  ls_pkgs)
    
%% status = Check_Installed_pkgs(OS_support, ls_pkgs): Check Operator system and python installed packages.
%
%% Input:
    % 1. OS_support: (cell) - cell of OS_support in char
    % 2. ls_pkgs: (cell) - cell of requirement packages in char
%
%% Output:
    % 1. status: (bool) - True/False
%
%% Require R2006A
%
% Author: Do Hai Son, Vietnam National University, Hanoi, Vietnam

% Last modified by Do Hai Son, 30-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless communication systems
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


OS_support_p = [];
ls_pkgs_p = [];

for i = 1:length(OS_support)
    OS_support_p = [OS_support_p ' ' OS_support{i}];
end

for i = 1:length(ls_pkgs)
    ls_pkgs_p = [ls_pkgs_p ' ' ls_pkgs{i}];
end

% Determine if version is for Windows/Linux/MacOS platform
os     = checkOS();
if strcmp(os, 'macos')
    python = 'python3 ';
elseif strcmp(os, 'linux')
    python = 'python3 ';
elseif strcmp(os, 'windows')
    python = 'python ';
else
    error('Platform not supported');
end

script = './Shared/Python/Check_Installed_pkgs.py ';

cmd = [python, script, OS_support_p, ls_pkgs_p];

[~, stdout] = system(cmd);

if ~isempty(strfind(stdout, 'True'))
    status = true;
else
    disp(stdout);
end

end