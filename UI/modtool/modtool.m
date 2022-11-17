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

% Last Modified by GUIDE v2.5 04-Nov-2022 14:18:26

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

% UIWAIT makes modtool wait for user response (see UIRESUME)
% uiwait(handles.figure1);


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

    if (modtool_inputs.state == 0)  % General information
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

        modtool_inputs.state = 1;

    else  % Switch to the next param
        %% Get all interface setup
        % name
        modtool_inputs.params{end+1} = get(handles.param_name, 'String');

        % input_type 
        edit_type   = get(handles.input_type_edit,   'Value');
        popup_type  = get(handles.input_type_popup,  'Value');
        toggle_type = get(handles.input_type_toggle, 'Value');
        
        if edit_type
            modtool_inputs.params_type(end+1) = 1;
            tmp     = get(handles.input_default, 'String');
            if isnumeric(tmp)
                modtool_inputs.values{end+1} = str2num(tmp);
                modtool_inputs.default_values{end+1} = str2num(tmp);
            else
                modtool_inputs.values{end+1} = tmp;
                modtool_inputs.default_values{end+1} = tmp;
            end
        end

        if popup_type
            modtool_inputs.params_type(end+1) = 2;
            modtool_inputs.default_values{end+1} = 1;
            user_input = get(handles.input_value, 'String');
            user_input_default = get(handles.input_default, 'String');
            ind = strfind(user_input, ',');
            if sum(ind) ~= 0
                % Parse string to cell
                split = strsplit(user_input, ',');
                for i=1:length(split)
                    split{i} = strtrim(split{i});
                    if strcmp (user_input_default, split{i})
                        modtool_inputs.values{end} = i;
                    end
                end
                modtool_inputs.values{end+1} = split;
            else
                modtool_inputs.values{end+1} = user_input;
            end
            
        end

        if toggle_type
            modtool_inputs.params_type(end+1) = 3; 
            modtool_inputs.values{end+1} = 1;
            modtool_inputs.default_values{end+1} = 1;
            user_input = get(handles.input_default, 'String');
            if (strcmp(user_input, 'off'))
                modtool_inputs.values{end} = 0;
                modtool_inputs.default_values{end} = 0;
            end
        end

        modtool_inputs.state = modtool_inputs.state + 1;
        %% Pass params to InfoSysID_modtool func
        if (modtool_inputs.finish)
            [function_dir, function_params_dir] = InfoSysID_modtool(modtool_inputs.mode, modtool_inputs.model, modtool_inputs.name, ...
                modtool_inputs.num_params, modtool_inputs.params, modtool_inputs.params_type, ...
                modtool_inputs.values, modtool_inputs.default_values, modtool_inputs.outputs);
            fprintf('-------------------------------------------------------------------\n');
            fprintf('Finshed. Please modify the below files:\n');
            fprintf('%s\n', function_dir);
            fprintf('%s\n', function_params_dir);
            fprintf('Copyright 2022 AVITECH.\n');
            fprintf('-------------------------------------------------------------------\n');

            [msgicon, iconcmap] = imread('AV.png');
            hm = msgbox({'Please modify the below files:'; function_dir; function_params_dir; 'Copyright 2022 AVITECH.'}, 'Finished', 'custom', msgicon, iconcmap);
            jframe=get(hm, 'javaframe');
            jIcon=javax.swing.ImageIcon(fullfile(main_path, '/Resource/Icon/about.png'));
            jframe.setFigureIcon(jIcon);
            
            closereq(); 
            return
        end
        
        %% Renew all params
        % panel title
        param_panel_tile = ['Interface: Parameter ' num2str(modtool_inputs.state)];
        set(handles.param_panel, 'Title', param_panel_tile);

        % name
        set(handles.param_name, 'String', 'edit');

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
    if (modtool_inputs.state == modtool_inputs.num_params)
        set(hObject, 'String', 'Finish');
        modtool_inputs.finish = true;
    end
    

% --- Executes on button press in back_button.
function back_button_Callback(hObject, eventdata, handles)
% hObject    handle to back_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global modtool_inputs;
    global main_path;
    if (modtool_inputs.state == 1)
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

        set(handles.next_button, 'String', 'Next');
        modtool_inputs.finish = false;

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
        modtool_inputs.state = modtool_inputs.state - 1;
    else
        %% Set all interface setup
        state = modtool_inputs.state - 1;
        % name
        set(handles.param_name, 'String', modtool_inputs.params{state});

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
            if isnumeric(modtool_inputs.values{state})
                set(handles.input_default, 'String', num2str(modtool_inputs.values{state}));
            else
                set(handles.input_default, 'String', modtool_inputs.values{state});
            end
        end

        if popup_type
            modtool_inputs.params_type(end+1) = 2;
            modtool_inputs.default_values{end+1} = 1;
            user_input = get(handles.input_value, 'String');
            user_input_default = get(handles.input_default, 'String');
            ind = strfind(user_input, ',');
            if sum(ind) ~= 0
                % Parse string to cell
                split = strsplit(user_input, ',');
                for i=1:length(split)
                    split{i} = strtrim(split{i});
                    if strcmp (user_input_default, split{i})
                        modtool_inputs.values{end} = i;
                    end
                end
                modtool_inputs.values{end+1} = split;
            else
                modtool_inputs.values{end+1} = user_input;
            end
            
        end

        if toggle_type
            set(handles.input_default, 'String', modtool_inputs.values{state});
        end
    end

% --- Executes on selection change in select_mode.
function select_mode_Callback(hObject, eventdata, handles)
% hObject    handle to select_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns select_mode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from select_mode
    mode = get(hObject, 'Value');
    switch mode
        case 1  % CRB
        case 2  % Algo
            set(handles.output_type_panel, 'Visible', 'on');
        case 3  % DEMO
    end

% --- Executes during object creation, after setting all properties.
function select_mode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to select_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in select_model.
function select_model_Callback(hObject, eventdata, handles)
% hObject    handle to select_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns select_model contents as cell array
%        contents{get(hObject,'Value')} returns selected item from select_model


% --- Executes during object creation, after setting all properties.
function select_model_CreateFcn(hObject, eventdata, handles)
% hObject    handle to select_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function name_Callback(hObject, eventdata, handles)
% hObject    handle to name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of name as text
%        str2double(get(hObject,'String')) returns contents of name as a double


% --- Executes during object creation, after setting all properties.
function name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in num_params.
function num_params_Callback(hObject, eventdata, handles)
% hObject    handle to num_params (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns num_params contents as cell array
%        contents{get(hObject,'Value')} returns selected item from num_params


% --- Executes during object creation, after setting all properties.
function num_params_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_params (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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

% Hint: get(hObject,'Value') returns toggle state of output_type_ber


% --- Executes on button press in output_type_mses.
function output_type_mses_Callback(hObject, eventdata, handles)
% hObject    handle to output_type_mses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of output_type_mses


% --- Executes on button press in output_type_mseh.
function output_type_mseh_Callback(hObject, eventdata, handles)
% hObject    handle to output_type_mseh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of output_type_mseh



function param_name_Callback(hObject, eventdata, handles)
% hObject    handle to param_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of param_name as text
%        str2double(get(hObject,'String')) returns contents of param_name as a double


% --- Executes during object creation, after setting all properties.
function param_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to param_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_value_Callback(hObject, eventdata, handles)
% hObject    handle to input_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_value as text
%        str2double(get(hObject,'String')) returns contents of input_value as a double


% --- Executes during object creation, after setting all properties.
function input_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_default_Callback(hObject, eventdata, handles)
% hObject    handle to input_default (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_default as text
%        str2double(get(hObject,'String')) returns contents of input_default as a double


% --- Executes during object creation, after setting all properties.
function input_default_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_default (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in input_type_edit.
function input_type_edit_Callback(hObject, eventdata, handles)
% hObject    handle to input_type_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of input_type_edit
    set(handles.input_value_panel, 'Visible', 'off');

% --- Executes on button press in input_type_popup.
function input_type_popup_Callback(hObject, eventdata, handles)
% hObject    handle to input_type_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of input_type_popup
    set(handles.input_value_panel, 'Visible', 'on');
    set(handles.input_value, 'Visible', 'on');

% --- Executes on button press in input_type_toggle.
function input_type_toggle_Callback(hObject, eventdata, handles)
% hObject    handle to input_type_toggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of input_type_toggle
    set(handles.input_value_panel, 'Visible', 'off');
