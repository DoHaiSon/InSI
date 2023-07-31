function vers = load_versions( mode, model, default, name )

%% vers = load_versions(model, default, name): Load the list of versions of current algorithm.
%
%% Input:
    % 1. mode: (char) - current mode of toolbox 'Algo_Mode': 
    % Algorithm mode; 'CRB_Mode': CRB mode; 'Demo_Mode': Demo mode
    % 2. default: (hObject) - hObject of current GUI
    % 3. model: (char) - the selected method 'Non-blind': None-blind;
    % 'Semi-blind': Semi-blind; 'Blind': Blind;
    % 'Side-information': Side-information; 'Informed': Informed
    % 4. name: (char) - name of selected algorithm
%
%% Output: 
    % 1. vers: (char, str) - the list of versions of current algorithm
%
%% Require R2006A
%
% Author: Do Hai Son, Vietnam National University, Hanoi, Vietnam

% Last modified by Do Hai Son, 31-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless Communications
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


global main_path;

if strcmp(mode, 'Algo_Mode')
    path  = fullfile(main_path, '/Algorithms', mode, model, name);
    sub   = dir(path);
    algos = {default};
    for i=1:length(sub)
        name = sub(i).name;
        ext = '';
        if length(name) > 2
            ext = name(end - 1:end);
        end
        if ~sub(i).isdir && strcmp(ext, '.m') 
            switch (model)
                case 'Blind'
                    if strcmp(sub(i).name(1:2), 'B_')
                        algos{end+1} = sub(i).name(1:end-2);
                    end
                case 'Non-blind'
                    if strcmp(sub(i).name(1:3), 'NB_')
                        algos{end+1} = sub(i).name(1:end-2);
                    end
                case 'Semi-blind'
                    if strcmp(sub(i).name(1:3), 'SB_')
                        algos{end+1} = sub(i).name(1:end-2);
                    end
                case 'Side-information'
                    if strcmp(sub(i).name(1:3), 'SI_')
                        algos{end+1} = sub(i).name(1:end-2);
                    end
                case 'Informed'
                    if strcmp(sub(i).name(1:2), 'I_')
                        algos{end+1} = sub(i).name(1:end-2);
                    end
                otherwise
                    disp('The mode is not supported.')
            end
            
        end
    end
    vers = algos;
else
    path  = fullfile(main_path, '/Algorithms', mode, name, model);
    sub   = dir(path);
    algos = {default};
    for i=1:length(sub)
        name = sub(i).name;
        if ~strcmp(name, '.') && ~strcmp(name, '..') && sub(i).isdir
            algos{end+1} = sub(i).name;
        end
    end
    vers = algos;
end

end