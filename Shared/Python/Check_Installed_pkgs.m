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
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 13-May-2023 14:42:13 

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

if contains(stdout, 'True')
    status = true;
else
    error(stdout);
end

end