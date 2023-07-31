function release_params(handles, modtool_inputs)

%% ~ = release_params(handles, modtool_inputs): Renew all input box of InSI_modtool
%
%% Input:
    % 1. handles: (handles) - handles of current GUI
    % 2. modtool_inputs: (struct) - struct of current input 
    % parameter in the InSI_modtool
%
%% Output: None
%
%% Require R2006A
%
% Author: Do Hai Son, Vietnam National University, Hanoi, Vietnam

% Last modified by Do Hai Son, 30-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless Communications
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


% panel title
param_panel_tile = ['Interface: Parameter ' num2str(modtool_inputs.state)];
set(handles.param_panel, 'Title', param_panel_tile);

% name
set(handles.param_name, 'String', 'edit');

% notation
set(handles.param_notation, 'String', 'edit');

% input_type
set(handles.input_type_edit, 'Value', 1);

% input_value panel
set(handles.input_value_panel, 'Visible', 'off');

% input_value
set(handles.input_value, 'Visible', 'off');
set(handles.input_value, 'String', 'edit');

% input_default
set(handles.input_default, 'String', 'edit');

end