function [data] = openfile(name)

%% data = openfile(name): Load a file and export the its value into a toolbox variable.
%
%% Input: 
    % 1. name: (char, str) - the name of import file
%
%% Output:
    % 1. data: (any) - value of imported file
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


[file,file_path, indx] = uigetfile( ...
{'*.m;*.mlx;*.fig;*.mat;*.slx;*.mdl',...
    'MATLAB Files (*.m,*.mlx,*.fig,*.mat,*.slx,*.mdl)';
   '*.m;*.mlx','Code files (*.m,*.mlx)'; ...
   '*.fig','Figures (*.fig)'; ...
   '*.mat','MAT-files (*.mat)'; ...
   '*.mdl;*.slx','Models (*.slx, *.mdl)'; ...
   '*.*',  'All Files (*.*)'}, ...
   'Select a File');
if isequal(file,0)
   disp('User selected Cancel');
   return;
end
    file_path = fullfile(file_path, file);
    stru      = load(file_path);
    stru_name = fieldnames(stru);
    data = eval(strcat('stru.',stru_name{1}));
    data = {'Trigger_input', data};
    global input_data;
    eval(strcat('input_data.', name, '= data;'));
end
