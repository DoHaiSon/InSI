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
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 20-Apr-2023 18:52:13 

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