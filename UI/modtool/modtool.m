function varargout = modtool(varargin)
% MODTOOL MATLAB code for modtool.fig
%      MODTOOL, by itself, creates a new MODTOOL or raises the existing
%      singleton*.
%
%      H = MODTOOL returns the handle to a new MODTOOL or the handle to
%      the existing singleton*.
%
%      MODTOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODTOOL.M with the given input arguments.
%
%      MODTOOL('Property','Value',...) creates a new MODTOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before modtool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to modtool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help modtool

% Last Modified by GUIDE v2.5 12-Jun-2023 13:56:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @modtool_OpeningFcn, ...
                   'gui_OutputFcn',  @modtool_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before modtool is made visible.
function modtool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to modtool (see VARARGIN)

    % Choose default command line output for modtool
    handles.output = hObject;
    
    % Update handles structure
    guidata(hObject, handles);
    
    movegui(hObject, 'center');
    
    % UIWAIT makes modtool wait for user response (see UIRESUME)
    % uiwait(handles.InSI_modtool);

    init_modtool();
    
    
% --- Outputs from this function are returned to the command line.
function varargout = modtool_OutputFcn(hObject, eventdata, handles) 
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    % Get default command line output from handles structure
    varargout{1} = handles.output;


% --- Executes on button press in next_button.
function next_button_Callback(hObject, eventdata, handles)
% hObject    handle to next_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    global modtool_inputs;
    global main_path;
    
    if modtool_inputs.state == 0
        % Turn off all step 1 components
        set(handles.name, 'Visible', 'off');
        set(handles.name_text, 'Visible', 'off');
        set(handles.select_mode_text, 'Visible', 'off');
        set(handles.select_mode, 'Visible', 'off');
        set(handles.select_model_text, 'Visible', 'off');
        set(handles.select_model, 'Visible', 'off');
        set(handles.num_params_text, 'Visible', 'off');
        set(handles.num_params, 'Visible', 'off');
        set(handles.output_type_panel, 'Visible', 'off');
        set(handles.step1_panel, 'BorderType', 'none');
        set(handles.step1_panel, 'Title', '');
    
        set(handles.param_panel, 'Visible', 'on');
        set(handles.back_button, 'Visible', 'on');
    end
    state       = modtool_inputs.state;
    current_len = length(modtool_inputs.params);

    if (~modtool_inputs.trigger)  % General information
        %% Get all general values 
        % mode
        modtool_inputs.mode = get(handles.select_mode, 'Value');
    
        % model
        models = get(handles.select_model, 'String');
        modtool_inputs.model = models{ get(handles.select_model, 'Value') };
    
        % name
        tmp = get(handles.name, 'String');
        modtool_inputs.name = tmp(find(~isspace(tmp)));
    
        % num_params
        modtool_inputs.num_params = get(handles.num_params, 'Value');
    
        % outputs
        modtool_inputs.outputs = [];
        switch modtool_inputs.mode
            case 1  % CRB
            case 2  % Algo
                ser_mode  = get(handles.output_type_ser,  'Value'); 
                ber_mode  = get(handles.output_type_ber,  'Value');
                mses_mode = get(handles.output_type_mses, 'Value');
                mseh_mode = get(handles.output_type_mseh, 'Value');
                if ser_mode
                    modtool_inputs.outputs(end+1) = 1;
                end
                if ber_mode
                    modtool_inputs.outputs(end+1) = 2;
                end
                if mses_mode
                    modtool_inputs.outputs(end+1) = 3;
                end
                if mseh_mode
                    modtool_inputs.outputs(end+1) = 4;
                end
            case 3  % DEMO
        end
    
        % Turn off all step 1 components
        set(handles.name, 'Visible', 'off');
        set(handles.name_text, 'Visible', 'off');
        set(handles.select_mode_text, 'Visible', 'off');
        set(handles.select_mode, 'Visible', 'off');
        set(handles.select_model_text, 'Visible', 'off');
        set(handles.select_model, 'Visible', 'off');
        set(handles.num_params_text, 'Visible', 'off');
        set(handles.num_params, 'Visible', 'off');
        set(handles.output_type_panel, 'Visible', 'off');
        set(handles.step1_panel, 'BorderType', 'none');
        set(handles.step1_panel, 'Title', '');
    
        set(handles.param_panel, 'Visible', 'on');
        set(handles.back_button, 'Visible', 'on');
        
        modtool_inputs.trigger = true;
        modtool_inputs.state = 1;
    end

    % Switch to the next param
    if state ~= 0
        %% Get all interface setup
        % name
        modtool_inputs.params{state} = get(handles.param_name, 'String');

        % notation
        modtool_inputs.notations{state} = get(handles.param_notation, 'String');

        % input_type
        edit_type   = get(handles.input_type_edit,   'Value');
        popup_type  = get(handles.input_type_popup,  'Value');
        toggle_type = get(handles.input_type_toggle, 'Value');

        if edit_type
            modtool_inputs.params_type(state) = 1;
            tmp     = get(handles.input_default, 'String');
            if isnumeric(tmp)
                modtool_inputs.values{state} = str2num(tmp);
                modtool_inputs.default_values{end+1} = str2num(tmp);
            else
                modtool_inputs.values{state} = tmp;
                modtool_inputs.default_values{state} = tmp;
            end
        end

        if popup_type
            modtool_inputs.params_type(state) = 2;
            modtool_inputs.default_values{state} = 1;
            user_input = get(handles.input_value, 'String');
            user_input_default = get(handles.input_default, 'String');
            ind = strfind(user_input, ',');
            if sum(ind) ~= 0
                % Parse string to cell
                split = strsplit(user_input, ',');
                for i=1:length(split)
                    split{i} = strtrim(split{i});
                    if strcmp (user_input_default, split{i})
                        modtool_inputs.default_values{state} = i;
                    end
                end
                modtool_inputs.values{state} = split;
            else
                modtool_inputs.values{state} = user_input;
            end

        end

        if toggle_type
            modtool_inputs.params_type(state) = 3;
            modtool_inputs.values{state} = 1;
            modtool_inputs.default_values{state} = 1;
            user_input = get(handles.input_default, 'String');
            if (strcmp(user_input, 'off'))
                modtool_inputs.values{state} = 0;
                modtool_inputs.default_values{state} = 0;
            end
        end
        modtool_inputs.state = modtool_inputs.state + 1;
        state                = modtool_inputs.state;

        %% Pass params to InSI_text func
        if (modtool_inputs.finish)
            [function_dir, function_params_dir] = InSI_modtool(modtool_inputs.mode, modtool_inputs.model, modtool_inputs.name, ...
                modtool_inputs.num_params, modtool_inputs.params, modtool_inputs.notations, modtool_inputs.params_type, ...
                modtool_inputs.values, modtool_inputs.default_values, modtool_inputs.outputs, '');
            fprintf('-------------------------------------------------------------------\n');
            fprintf('Finshed. Please modify the below files:\n');
            fprintf('%s\n', function_dir);
            fprintf('%s\n', function_params_dir);
            fprintf('Copyright 2023 @ AVITECH-UET, PRISME-Orleans.\n');
            fprintf('-------------------------------------------------------------------\n');

            [msgicon, iconcmap] = imread('about.png');
            hm = msgbox({'Please modify the below files:'; function_dir; function_params_dir; 'Copyright 2023 @ AVITECH-UET, PRISME-Orleans.'}, 'Finished', 'custom', msgicon, iconcmap);
            jframe=get(hm, 'javaframe');
            jIcon=javax.swing.ImageIcon(fullfile(main_path, '/Resource/Icon/about.png'));
            jframe.setFigureIcon(jIcon);

            closereq();
            return
        end

        %% Renew all params
        release_params(handles, modtool_inputs);

        if (modtool_inputs.state >= modtool_inputs.num_params)
            set(hObject, 'String', 'Finish');
            modtool_inputs.finish = true;
        end

    else
        modtool_inputs.state = 1;
        state                = modtool_inputs.state;
    end

    %% Set value if user used back_button
    if (state <= current_len && state <= modtool_inputs.num_params)
        % panel title
        param_panel_title = ['Interface: Parameter ' num2str(state)];
        set(handles.param_panel, 'Title', param_panel_title);

        % name
        set(handles.param_name, 'String', modtool_inputs.params{state});

        % notation
        set(handles.param_notation, 'String', modtool_inputs.notations{state});

        % Input type
        edit_type  = false;
        popup_type = false;
        toggle_type= false;
        switch modtool_inputs.params_type(state)
            case 1
                set(handles.input_type_edit,  'Value', 1);
                edit_type = true;
            case 2
                set(handles.input_type_popup, 'Value', 1);
                popup_type = true;
            case 3
                set(handles.input_type_toggle,'Value', 1);
                toggle_type= true;
        end

        if edit_type
            set(handles.input_value_panel, 'Visible', 'off');
            if isnumeric(modtool_inputs.values{state})
                set(handles.input_default, 'String', num2str(modtool_inputs.values{state}));
            else
                set(handles.input_default, 'String', modtool_inputs.values{state});
            end
        end

        if popup_type
            set(handles.input_value_panel, 'Visible', 'on');
            set(handles.input_value, 'Visible', 'on');
            values = modtool_inputs.values{state};
            if iscell(values)
                set(handles.input_default, 'String', values{modtool_inputs.default_values{state}});
                values = cell2char(values);
                values = regexprep(values, '[\{\}'''']', '');
            else
                set(handles.input_default, 'String', values);
            end
            set(handles.input_value, 'String', values);
        end

        if toggle_type
            set(handles.input_value_panel, 'Visible', 'off');
            value = modtool_inputs.values{state};
            if (value == 1)
                set(handles.input_default, 'String', 'on');
            else
                set(handles.input_default, 'String', 'off');
            end
        end

        if modtool_inputs.state > current_len || modtool_inputs.state >= modtool_inputs.num_params
            modtool_inputs.trigger_1 = true;
            if (modtool_inputs.state == modtool_inputs.num_params)
                set(hObject, 'String', 'Finish');
                modtool_inputs.finish = true;
            end
        end
        return
    else
        if modtool_inputs.trigger_1
            %% Renew all params
            release_params(handles, modtool_inputs);
            modtool_inputs.trigger_1 = false;
            return
        end
    end

    if (modtool_inputs.state >= modtool_inputs.num_params)
        set(hObject, 'String', 'Finish');
        modtool_inputs.finish = true;
    end
    

% --- Executes on button press in back_button.
function back_button_Callback(hObject, eventdata, handles)
% hObject    handle to back_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    global modtool_inputs;
    set(handles.next_button, 'String', 'Next');
    modtool_inputs.finish = false;
    
    state = modtool_inputs.state;
    %% Get all interface setup
    % name
    modtool_inputs.params{state} = get(handles.param_name, 'String');

    % notation
    modtool_inputs.notations{state} = get(handles.param_notation, 'String');

    % input_type 
    edit_type   = get(handles.input_type_edit,   'Value');
    popup_type  = get(handles.input_type_popup,  'Value');
    toggle_type = get(handles.input_type_toggle, 'Value');
    
    if edit_type
        modtool_inputs.params_type(state) = 1;
        tmp     = get(handles.input_default, 'String');
        if isnumeric(tmp)
            modtool_inputs.values{state} = str2num(tmp);
            modtool_inputs.default_values{end+1} = str2num(tmp);
        else
            modtool_inputs.values{state} = tmp;
            modtool_inputs.default_values{state} = tmp;
        end
    end

    if popup_type
        modtool_inputs.params_type(state) = 2;
        modtool_inputs.default_values{state} = 1;
        user_input = get(handles.input_value, 'String');
        user_input_default = get(handles.input_default, 'String');
        ind = strfind(user_input, ',');
        if sum(ind) ~= 0
            % Parse string to cell
            split = strsplit(user_input, ',');
            for i=1:length(split)
                split{i} = strtrim(split{i});
                if strcmp (user_input_default, split{i})
                    modtool_inputs.default_values{state} = i;
                end
            end
            modtool_inputs.values{state} = split;
        else
            modtool_inputs.values{state} = user_input;
        end
        
    end

    if toggle_type
        modtool_inputs.params_type(state) = 3; 
        modtool_inputs.values{state} = 1;
        modtool_inputs.default_values{state} = 1;
        user_input = get(handles.input_default, 'String');
        if (strcmp(user_input, 'off'))
            modtool_inputs.values{state} = 0;
            modtool_inputs.default_values{state} = 0;
        end
    end

    if (state == 1)
        % Turn on all step 1 components
        set(handles.name, 'Visible', 'on');
        set(handles.name_text, 'Visible', 'on');
        set(handles.select_mode_text, 'Visible', 'on');
        set(handles.select_mode, 'Visible', 'on');
        set(handles.select_model_text, 'Visible', 'on');
        set(handles.select_model, 'Visible', 'on');
        set(handles.num_params_text, 'Visible', 'on');
        set(handles.num_params, 'Visible', 'on');
        set(handles.output_type_panel, 'Visible', 'on');
        set(handles.step1_panel, 'BorderType', 'etchedin');
        set(handles.step1_panel, 'Title', '');
    
        set(handles.param_panel, 'Visible', 'off');
        set(handles.back_button, 'Visible', 'off');

        %% Set all general values 
        % mode
        set(handles.select_mode, 'Value', modtool_inputs.mode);
    
        % model
        models = {'Blind', 'Semi-blind', 'Non-blind'};
        set(handles.select_model, 'String', models);
    
        % name
        set(handles.name, 'String', modtool_inputs.name);
    
        % num_params
        set(handles.num_params, 'Value', modtool_inputs.num_params);
    
        % outputs
        switch modtool_inputs.mode
            case 1  % CRB
                set(handles.output_type_panel, 'Visible', 'off');
            case 2  % Algo
                set(handles.output_type_ser,   'Value', 0); 
                set(handles.output_type_ber,   'Value', 0); 
                set(handles.output_type_mses,  'Value', 0); 
                set(handles.output_type_mseh,  'Value', 0); 
                for i = 1:length(modtool_inputs.outputs)
                    switch modtool_inputs.outputs(i)
                        case 1
                            set(handles.output_type_ser,  'Value', 1); 
                        case 2
                            set(handles.output_type_ber,  'Value', 1); 
                        case 3
                            set(handles.output_type_mses, 'Value', 1); 
                        case 4
                            set(handles.output_type_mseh, 'Value', 1);
                    end
                end
            case 3  % DEMO
                set(handles.output_type_panel, 'Visible', 'off');
        end
        modtool_inputs.trigger = false;
        modtool_inputs.state = modtool_inputs.state - 1;
    else
        %% Set all interface setup
        modtool_inputs.state = modtool_inputs.state - 1;
        state = modtool_inputs.state;

        % panel title
        param_panel_title = ['Interface: Parameter ' num2str(state)];
        set(handles.param_panel, 'Title', param_panel_title);

        % name
        set(handles.param_name, 'String', modtool_inputs.params{state});

        % notation
        set(handles.param_notation, 'String', modtool_inputs.notations{state});

        % Input type
        edit_type  = false;
        popup_type = false;
        toggle_type= false;
        switch modtool_inputs.params_type(state)
            case 1
                set(handles.input_type_edit,  'Value', 1);
                edit_type = true;
            case 2
                set(handles.input_type_popup, 'Value', 1);
                popup_type = true;
            case 3
                set(handles.input_type_toggle,'Value', 1);
                toggle_type= true;
        end
        
        if edit_type
            set(handles.input_value_panel, 'Visible', 'off');
            if isnumeric(modtool_inputs.values{state})
                set(handles.input_default, 'String', num2str(modtool_inputs.values{state}));
            else
                set(handles.input_default, 'String', modtool_inputs.values{state});
            end
        end

        if popup_type
            set(handles.input_value_panel, 'Visible', 'on');
            set(handles.input_value, 'Visible', 'on');
            values = modtool_inputs.values{state};
            if iscell(values)
                set(handles.input_default, 'String', values{modtool_inputs.default_values{state}});
                values = cell2char(values);
                values = regexprep(values, '[\{\}'''']', '');
            else
                set(handles.input_default, 'String', values);
            end
            set(handles.input_value, 'String', values);
        end

        if toggle_type
            set(handles.input_value_panel, 'Visible', 'off');
            value = modtool_inputs.values{state};
            if (value == 1)
                set(handles.input_default, 'String', 'on');
            else
                set(handles.input_default, 'String', 'off');
            end
        end
    end


% --- Executes on selection change in select_mode.
function select_mode_Callback(hObject, eventdata, handles)
% hObject    handle to select_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    mode = get(hObject, 'Value');
    global modtool_inputs;
    switch mode
        case 1  % CRB
            set(handles.output_type_panel, 'Visible', 'off');
            modtool_inputs.outputs = [];
        case 2  % Algo
            set(handles.output_type_panel, 'Visible', 'on');
        case 3  % DEMO
            set(handles.output_type_panel, 'Visible', 'off');
            modtool_inputs.outputs = [];
    end


% --- Executes during object creation, after setting all properties.
function select_mode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to select_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6666666666666666);


% --- Executes on selection change in select_model.
function select_model_Callback(hObject, eventdata, handles)
% hObject    handle to select_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function select_model_CreateFcn(hObject, eventdata, handles)
% hObject    handle to select_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6666666666666666);


function name_Callback(hObject, eventdata, handles)
% hObject    handle to name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.711111111111111);


% --- Executes on selection change in num_params.
function num_params_Callback(hObject, eventdata, handles)
% hObject    handle to num_params (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function num_params_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_params (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6666666666666666);


% --- Executes on button press in output_type_ser.
function output_type_ser_Callback(hObject, eventdata, handles)
% hObject    handle to output_type_ser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of output_type_ser


% --- Executes on button press in output_type_ber.
function output_type_ber_Callback(hObject, eventdata, handles)
% hObject    handle to output_type_ber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in output_type_mses.
function output_type_mses_Callback(hObject, eventdata, handles)
% hObject    handle to output_type_mses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in output_type_mseh.
function output_type_mseh_Callback(hObject, eventdata, handles)
% hObject    handle to output_type_mseh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




function param_name_Callback(hObject, eventdata, handles)
% hObject    handle to param_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function param_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to param_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6590038314176231);


function input_value_Callback(hObject, eventdata, handles)
% hObject    handle to input_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function input_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.5245901639344263);


function input_default_Callback(hObject, eventdata, handles)
% hObject    handle to input_default (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function input_default_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_default (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.3516483516483516);


% --- Executes on button press in input_type_edit.
function input_type_edit_Callback(hObject, eventdata, handles)
% hObject    handle to input_type_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    set(handles.input_value_panel, 'Visible', 'off');


% --- Executes on button press in input_type_popup.
function input_type_popup_Callback(hObject, eventdata, handles)
% hObject    handle to input_type_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    set(handles.input_value_panel, 'Visible', 'on');
    set(handles.input_value, 'Visible', 'on');


% --- Executes on button press in input_type_toggle.
function input_type_toggle_Callback(hObject, eventdata, handles)
% hObject    handle to input_type_toggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    set(handles.input_value_panel, 'Visible', 'off');
    set(handles.input_default, 'String', 'on');



function param_notation_Callback(hObject, eventdata, handles)
% hObject    handle to param_notation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function param_notation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to param_notation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6590038314176248);


% --- Executes during object creation, after setting all properties.
function param_panel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to param_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.03531079789315661);


% --- Executes during object creation, after setting all properties.
function back_button_CreateFcn(hObject, eventdata, handles)
% hObject    handle to back_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    
    set(hObject.Parent, 'units','pixels');
    [x, y, w, h] = scale_InSI(hObject.Parent);
    set(hObject.Parent, 'Position', [x, y, w, h]);
    
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.4848484848484848);


% --- Executes during object creation, after setting all properties.
function next_button_CreateFcn(hObject, eventdata, handles)
% hObject    handle to next_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.5079365079365079);


% --- Executes during object creation, after setting all properties.
function InSI_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InSI_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.5765765765765766);


% --- Executes during object creation, after setting all properties.
function param_name_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to param_name_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.7615155385270328);


% --- Executes during object creation, after setting all properties.
function param_notation_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to param_notation_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.7615155385270328);


% --- Executes during object creation, after setting all properties.
function input_type_panel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_type_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.19470567746429815);


% --- Executes during object creation, after setting all properties.
function input_type_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_type_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6095238095238095);


% --- Executes during object creation, after setting all properties.
function input_type_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_type_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6095238095238095);


% --- Executes during object creation, after setting all properties.
function input_type_toggle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_type_toggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6095238095238095);


% --- Executes during object creation, after setting all properties.
function input_value_panel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_value_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.16635048171707034);


% --- Executes during object creation, after setting all properties.
function text9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.5333333333333333);


% --- Executes during object creation, after setting all properties.
function input_default_panel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_default_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.1730717133015984);


% --- Executes during object creation, after setting all properties.
function text10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.17066666666666666);


% --- Executes during object creation, after setting all properties.
function step1_panel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to step1_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.035516093229744736);

% --- Executes during object creation, after setting all properties.
function output_type_ser_CreateFcn(hObject, eventdata, handles)
% hObject    handle to output_type_ser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6095238095238095);

% --- Executes during object creation, after setting all properties.
function output_type_ber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to output_type_ber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.60952380952381);


% --- Executes during object creation, after setting all properties.
function output_type_mses_CreateFcn(hObject, eventdata, handles)
% hObject    handle to output_type_mses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6095238095238095);


% --- Executes during object creation, after setting all properties.
function output_type_mseh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to output_type_mseh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6095238095238095);


% --- Executes during object creation, after setting all properties.
function select_mode_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to select_mode_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.7703703703703703);


% --- Executes during object creation, after setting all properties.
function select_model_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to select_model_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.7703703703703703);


% --- Executes during object creation, after setting all properties.
function name_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to name_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.7703703703703703);


% --- Executes during object creation, after setting all properties.
function num_params_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_params_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.24586288416075627);


% --- Executes during object creation, after setting all properties.
function output_type_panel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to output_type_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.11479028697571744);
