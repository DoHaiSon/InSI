function load_params(hObject, eventdata, handles, mode, method, algo )

%% ~ = load_params(hObject, eventdata, handles, mode, method, algo)
% Load parameters from file and display to the parameters Menu.
%
%% Input:
    % 1. hObject: (hObject) - hObject of current GUI
    % 2. eventdata: (eventdata) - eventdata of current GUI
    % 3. handles: (handles) - handles of current GUI
    % 4. mode: (char) - current mode of toolbox 'Algo_Mode': 
    % Algorithm mode; 'CRB_Mode': CRB mode; 'Demo_Mode': Demo mode
    % 5. method: (char) - the selected method 'Non-blind': None-blind;
    % 'Semi-blind': Semi-blind; 'Blind': Blind;
    % 'Side-information': Side-information; 'Informed': Informed
    % 6. algo: (char) - the name of selected algorithm
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


global main_path;
param_file_name = strcat(algo, '_params');
global configs;
global params;
params = eval(param_file_name);

global pre_algo;
if ( ~ strncmp(pre_algo, param_file_name, length(param_file_name)) )
    trigger_scale = true;
    pre_algo = param_file_name;
else
    trigger_scale = false;
end

if params.num_params == 0
    return
end

set(handles.panelparams, 'Visible', 'on');

% Turn off unuse params
if params.num_params < configs.max_params
    for i=1:params.num_params
        set(eval(strcat('handles.Text_', num2str(i))), 'Visible', 'on');
        set(eval(strcat('handles.Op_', num2str(i))), 'Visible', 'on');
    end
    for i=10:-1:params.num_params + 1
        set(eval(strcat('handles.Text_', num2str(i))), 'Visible', 'off');
        set(eval(strcat('handles.Op_', num2str(i))), 'Visible', 'off');
    end
end

% Set texts for using params
for i=1:params.num_params
    % Cat params and notation to Op Label
    Label = [params.params{i} ' (' params.notations{i} ')'];
    if (strcmp(mode, 'CRB_mode'))
        font_size = eval(strcat('configs.max_Op_text_CRB.Op_', num2str(i)));
    else
        font_size = eval(strcat('configs.max_Op_text_Algo.Op_', num2str(i)));
    end

    if (length(Label) > configs.max_Op_text)
        set(eval(strcat('handles.Text_', num2str(i))), 'FontSize', font_size * (configs.max_Op_text / length(Label)));
    else
        set(eval(strcat('handles.Text_', num2str(i))), 'FontSize', font_size);
    end

    set(eval(strcat('handles.Text_', num2str(i))), 'String', Label);
end

% Set UIClass and default value for using params
    % Type of the UIControl: edit_text   = 1
    %                        popup_menu  = 2
    %                        toggle      = 3
for i=1:params.num_params
    switch (params.params_type(i))
        case 1
            set(eval(strcat('handles.Op_', num2str(i))), 'Style', 'edit');
            set(eval(strcat('handles.Op_', num2str(i))), 'Enable', 'on');

            % TODO: Scale edit box
%                 if (trigger_scale)
%                     set(eval(strcat('handles.Op_', num2str(i))), 'units','pixels');
%                     old_pos    = get(eval(strcat('handles.Op_', num2str(i))), 'Position');
%                     if (old_pos(3) >= 60)
%                         new_pos    = old_pos;
%                         new_pos(1) = old_pos(1) * 2.8473282443;
%                         new_pos(3) = old_pos(3) / 2;
%                         set(eval(strcat('handles.Op_', num2str(i))), 'Position', new_pos);
%                     end
%                 end
            
            % Set default values for using params
            set(eval(strcat('handles.Op_', num2str(i))), 'String', params.default_values{i});
        case 2
            set(eval(strcat('handles.Op_', num2str(i))), 'Style', 'popupmenu');
            % Scale droplist box
            if (trigger_scale)
                old_pos    = get(eval(strcat('handles.Op_', num2str(i))), 'Position');
                if (old_pos(3) <= 0.3)
                    new_pos    = old_pos;
                    new_pos(1) = old_pos(1) - old_pos(3)/2;
                    new_pos(3) = old_pos(3) * 2;
                    set(eval(strcat('handles.Op_', num2str(i))), 'Position', new_pos);
                end
            end

            % Set default values for using params
            set(eval(strcat('handles.Op_', num2str(i))), 'String', params.values{i});
            set(eval(strcat('handles.Op_', num2str(i))), 'Value', params.default_values{i});
        case 3
            set(eval(strcat('handles.Op_', num2str(i))), 'Style', 'togglebutton');
            set(eval(strcat('handles.Op_', num2str(i))), 'Value', params.default_values{i});
            if params.default_values{i} == 1
                set(eval(strcat('handles.Op_', num2str(i))), 'String', 'on');
            else
                set(eval(strcat('handles.Op_', num2str(i))), 'String', 'off');
            end
    end
end

% Load default SNR range and the number of monte
set(handles.Monte, 'String', params.default_Monte);
set(handles.SNR, 'String', params.default_SNR);

% Load system model
handles_main = getappdata(0, 'handles_main');
axesH        = handles_main.board;  % Not safe! Better get the handle explicitly!

releasesysmodel();

img          = imread(fullfile(main_path, '/Resource/Dashboard', params.sys_model));
if length(img) < 2000
    img = imresize(img, 2065 / length(img));
end
imshow(img, 'Parent', axesH, 'InitialMagnification','fit');
title_dashboard = load_title(algo);

if length(title_dashboard) > configs.max_title_dashboard
    set(handles_main.board_title, 'FontSize', 0.5102040816326531 * (configs.max_title_dashboard / length(title_dashboard)) );
else
    set(handles_main.board_title, 'FontSize', 0.5102040816326531);
end
set(handles_main.board_title, 'String', title_dashboard);


% Load interactiveness
for i=1:params.num_params
    if params.has_inter(i)
        set(eval(strcat('handles.Op_', num2str(i))), 'Enable', 'inactive');
    end
end

% Load output panel
switch (mode)
    case 'Algo_Mode'
        set(handles.btngroup, 'Visible', 'on');
        if length(params.outputs) ~= 4
           for i=1:4
               if any(params.outputs(:) == i)
                   set(eval(strcat('handles.output', num2str(i))), 'Enable', 'on');
               else
                   set(eval(strcat('handles.output', num2str(i))), 'Enable', 'off');
               end
           end
        end
        set(eval(strcat('handles.output', num2str(params.default_output))), 'Value', 1);
    case 'CRB_Mode'
    case 'Demo_Mode'
        try
            if length(params.outputs) ~= 4
               for i=1:4
                   if any(params.outputs(:) == i)
                       set(eval(strcat('handles.output', num2str(i))), 'Enable', 'on');
                   else
                       set(eval(strcat('handles.output', num2str(i))), 'Enable', 'off');
                   end
               end
            end
            set(eval(strcat('handles.output', num2str(params.default_output))), 'Value', 1);
        catch
        end

        if (strcmp(param_file_name, 'Demo_CRB_Beacons_settings_params'))
            set(handles.Monte, 'Visible', 'off');
            set(handles.Monte_text, 'Visible', 'off');
            set(handles.SNR, 'Visible', 'off');
            set(handles.SNR_text, 'Visible', 'off');
            set(handles.dB_text, 'Visible', 'off');
        end
end

end