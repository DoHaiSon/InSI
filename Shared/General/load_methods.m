function methods = load_methods( default, mode, name )

%% methods = load_methods(default, mode, name): Load the list of algorithms of current mode.
%
%% Input:
    % 1. default: (hObject) - hObject of current GUI
    % 2. mode: (char) - current mode of toolbox 'Algo_Mode': Algorithm mode; 'CRB_Mode': CRB mode;
    % 'Demo_Mode': Demo mode
    % 3. name: (char) - the selected method 'Non-blind': None-blind;
    % 'Semi-blind': Semi-blind; 'Blind': Blind
%
%% Output: 
    % 1. methods: (char, str) - the list of algorithms of current mode and
    % name
%
%% Require R2006A
%
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 20-Apr-2023 17:52:13 

global main_path;
path = fullfile(main_path, '/Algorithms/', mode, name);
sub  = dir(path);
sub_folder = {default};
for i=1:length(sub)
    if sub(i).isdir
        if ~strcmp(sub(i).name(1), '.')
            sub_folder{end+1} = sub(i).name;
        end
    end
end
methods = sub_folder;

end