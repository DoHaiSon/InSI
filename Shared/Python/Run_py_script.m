function [status, SNR, Err] = Run_py_script ( file_path, varargin)
    %% Require R2016b
    
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
    split_output = splitlines(stdout);
    if (strcmp(split_output{end-1}, 'True'))
        file_name = ['result_' split_output{end - 2} '.txt'];
        result_file = fullfile(dir_path, file_name);

        % Read file
        fop = fopen(result_file, 'r');
        SNR = str2num(fgetl(fop));
        Err = str2num(fgetl(fop));
        
        if strcmp(type_of(SNR), 'array') && strcmp(type_of(Err), 'array')
            status = 1;
        end
    else
        error('Run python script failed.')
    end
end