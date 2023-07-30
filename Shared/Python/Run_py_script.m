function [status, SNR, Err] = Run_py_script ( file_path, varargin)

%% [status, SNR, Err] = Run_py_script(file_path, varargin): Run python program and return the Error rate.
%
%% Input:
    % 1. file_path: (char) - location of target python program
    % 2. varargin: (char) - list of input params
%
%% Output:
    % 1. status: (bool) - True/False
    % 2. SNR: (array) - working SNR
    % 3. Err: (array) - output error rate
%
%% Require R2013A
%
% Author: Do Hai Son, Vietnam National University, Hanoi, Vietnam

% Last modified by Do Hai Son, 30-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless communication systems
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France

    
status = 0;
[dir_path, file_name, ext] = fileparts(file_path);

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

args = '';

if (nargin == 1)
    cmd = [python, file_path];
else
    for i=1:nargin-1
        args = [args ' ' parse_arg2py(varargin{i})];
    end
    cmd = [python, file_path, args];
end

[status, stdout] = system(cmd);

disp(stdout);

%% Read result
% Check status
split_output = strsplit(stdout, '\n');
if (strcmp(split_output{end-1}, 'True'))
    file_name = ['result_' varargin{1} '.txt'];
    result_file = fullfile(dir_path, file_name);

    % Read file
    fop = fileread(result_file);

    split_fop = strsplit(fop, '\n');

    SNR = str2num(split_fop{end - 1});
    Err = str2num(split_fop{end});
    
    if strcmp(type_of(SNR), 'array') && strcmp(type_of(Err), 'array')
        status = 1;
    end
else
    error('Run python script failed.')
end

end