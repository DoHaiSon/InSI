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
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 20-Apr-2023 17:52:13 

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
