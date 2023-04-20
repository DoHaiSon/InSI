function vers = load_versions( model, default, name )

%% vers = load_versions(model, default, name): Load the list of versions of current algorithm.
%
%% Input:
    % 1. mode: (char) - current mode of toolbox 'Algo_Mode': Algorithm mode; 'CRB_Mode': CRB mode;
    % 'Demo_Mode': Demo mode
    % 2. default: (hObject) - hObject of current GUI
    % 3. name: (char) - the selected method 'Non-blind': None-blind;
    % 'Semi-blind': Semi-blind; 'Blind': Blind
%
%% Output: 
    % 1. vers: (char, str) - the list of versions of current algorithm
%
%% Require R2006A
%
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 20-Apr-2023 17:52:13 

global main_path;
path  = fullfile(main_path, '/Algorithms/Algo_Mode/', model, name);
sub   = dir(path);
algos = {default};
for i=1:length(sub)
    if ~sub(i).isdir
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
            otherwise
                disp('The mode is not supported.')
        end
        
    end
end
vers = algos;

end