function methods = load_methods( default, mode, name )

%% methods = load_methods(default, mode, name): Load the list of algorithms of current mode.
%
%% Input:
    % 1. default: (hObject) - hObject of current GUI
    % 2. mode: (char) - current mode of toolbox 'Algo_Mode': 
    % Algorithm mode; 'CRB_Mode': CRB mode; 'Demo_Mode': Demo mode
    % 3. name: (char) - the selected method 'Non-blind': None-blind;
    % 'Semi-blind': Semi-blind; 'Blind': Blind
%
%% Output: 
    % 1. methods: (char, str) - the list of algorithms of current mode and
    % name
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