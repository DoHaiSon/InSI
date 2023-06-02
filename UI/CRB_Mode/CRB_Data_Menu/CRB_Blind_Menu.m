function varargout = CRB_Blind_Menu(varargin)
% CRB_BLIND_MENU MATLAB code for CRB_Blind_Menu.fig
%      CRB_BLIND_MENU, by itself, creates a new CRB_BLIND_MENU or raises the existing
%      singleton*.
%
%      H = CRB_BLIND_MENU returns the handle to a new CRB_BLIND_MENU or the handle to
%      the existing singleton*.
%
%      CRB_BLIND_MENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CRB_BLIND_MENU.M with the given input arguments.
%
%      CRB_BLIND_MENU('Property','Value',...) creates a new CRB_BLIND_MENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CRB_Blind_Menu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CRB_Blind_Menu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CRB_Blind_Menu

% Last Modified by GUIDE v2.5 31-May-2023 13:49:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;

gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CRB_Blind_Menu_OpeningFcn, ...
                   'gui_OutputFcn',  @CRB_Blind_Menu_OutputFcn, ...
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


% --- Executes just before CRB_Blind_Menu is made visible.
function CRB_Blind_Menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user method (see GUIDATA)
% varargin   command line arguments to CRB_Blind_Menu (see VARARGIN)

global main_path;
jFrame=get(handle(handles.InSI_C_B), 'javaframe');
jicon=javax.swing.ImageIcon(fullfile(main_path,'/Resource/Icon/menu_icon.png'));
jFrame.setFigureIcon(jicon);

% Set position for this GUI
movegui(hObject, 'west');

% Release system model when cursor not in any UIClass
% set(hObject,'WindowButtonDownFcn',{@releasesysmodel});
% TODO: set interactive again

% Reset this trigger
global pre_algo;
pre_algo = '';

% Choose default command line output for CRB_Blind_Menu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CRB_Blind_Menu wait for user response (see UIRESUME)
% uiwait(handles.InSI_C_B);


% --- Outputs from this function are returned to the command line.
function varargout = CRB_Blind_Menu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user method (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function methods_CreateFcn(hObject, eventdata, handles)
% hObject    handle to methods (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
    % Set default menu to escape error when temp of menu is stored
    default = '                  Select model';
    set(hObject, 'String', default);
    methods = load_methods(default, 'CRB_Mode', 'Blind');
    set(hObject, 'String', methods);

% --- Executes on selection change in methods.
function methods_Callback(hObject, eventdata, handles)
% hObject    handle to methods (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns methods contents as cell array
%        contents{get(hObject,'Value')} returns selected item from methods
    method = get(hObject, 'Value');
    methods = get(hObject, 'String');
    if method == 1
        % Feedback turn off param panel
        set(handles.panelparams, 'Visible', 'off');
        set(handles.ref_web, 'Visible', 'off');
        return;
    end
    % TODO: Version is lost when choose default but method is not default
    algo = strcat('B_', methods{method});
    load_params(hObject, eventdata, handles, 'CRB_Mode', 'Blind', algo);

    set(handles.ref_web, 'Visible', 'on');


% --- Executes during object creation, after setting all properties.
function panelparams_CreateFcn(hObject, eventdata, handles)
% hObject    handle to panelparams (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    set(hObject, 'Visible', 'off');


% --- Executes during object creation, after setting all properties.
function Op_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Op_1_Callback(hObject, eventdata, handles)
% hObject    handle to Op_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Op_1 as text
%        str2double(get(hObject,'String')) returns contents of Op_1 as a double
    input_data(hObject);


% --- Executes during object creation, after setting all properties.
function Op_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Op_2_Callback(hObject, eventdata, handles)
% hObject    handle to Op_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Op_2 as text
%        str2double(get(hObject,'String')) returns contents of Op_2 as a double
    input_data(hObject);


% --- Executes during object creation, after setting all properties.
function Op_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Op_3_Callback(hObject, eventdata, handles)
% hObject    handle to Op_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Op_3 as text
%        str2double(get(hObject,'String')) returns contents of Op_3 as a double
    input_data(hObject);

% --- Executes during object creation, after setting all properties.
function Op_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Op_4_Callback(hObject, eventdata, handles)
% hObject    handle to Op_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Op_4 as text
%        str2double(get(hObject,'String')) returns contents of Op_4 as a double
    input_data(hObject);

% --- Executes during object creation, after setting all properties.
function Op_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Op_5_Callback(hObject, eventdata, handles)
% hObject    handle to Op_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Op_5 as text
%        str2double(get(hObject,'String')) returns contents of Op_5 as a double
    input_data(hObject);


% --- Executes during object creation, after setting all properties.
function Op_6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Op_6_Callback(hObject, eventdata, handles)
% hObject    handle to Op_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Op_6 as text
%        str2double(get(hObject,'String')) returns contents of Op_6 as a double
    input_data(hObject);

% --- Executes during object creation, after setting all properties.
function Op_7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Op_7_Callback(hObject, eventdata, handles)
% hObject    handle to Op_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Op_7 as text
%        str2double(get(hObject,'String')) returns contents of Op_7 as a double
    input_data(hObject);


% --- Executes during object creation, after setting all properties.
function Op_8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Op_8_Callback(hObject, eventdata, handles)
% hObject    handle to Op_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Op_8 as text
%        str2double(get(hObject,'String')) returns contents of Op_8 as a double
    input_data(hObject);
    

% --- Executes during object creation, after setting all properties.
function Op_9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Op_9_Callback(hObject, eventdata, handles)
% hObject    handle to Op_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Op_9 as text
%        str2double(get(hObject,'String')) returns contents of Op_9 as a double
    input_data(hObject);

% --- Executes during object creation, after setting all properties.
function Op_10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Op_10_Callback(hObject, eventdata, handles)
% hObject    handle to Op_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Op_10 as text
%        str2double(get(hObject,'String')) returns contents of Op_10 as a double
    input_data(hObject);

% --- Executes during object creation, after setting all properties.
function Monte_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Monte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
    set(hObject, 'units','pixels');
    set(hObject, 'Position', [125, 50, 70, 20]);

function Monte_Callback(hObject, eventdata, handles)
% hObject    handle to Monte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Monte as text
%        str2double(get(hObject,'String')) returns contents of Monte as a double



% --- Executes during object creation, after setting all properties.
function SNR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
    set(hObject, 'units','pixels');
    set(hObject, 'Position', [80, 15, 90, 20]);

function SNR_Callback(hObject, eventdata, handles)
% hObject    handle to SNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SNR as text
%        str2double(get(hObject,'String')) returns contents of SNR as a double


% --- Executes on button press in apply.
function apply_Callback(hObject, eventdata, handles)
% hObject    handle to apply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    method = get(handles.methods, 'Value');
    methods = get(handles.methods, 'String');
    
    % Try catch
    if get(handles.methods, 'Value') == 1
        return;
    end
    
    % Load all params to function exec
    algo = strcat('B_', methods{method});
    load_funcs(hObject, eventdata, handles, 'CRB_Mode', 'Blind', algo);
    

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Op_1.
function Op_1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Op_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    method = get(handles.methods, 'Value');
    methods = get(handles.methods, 'String');
    if method == 1
        % Feedback turn off param panel
        set(handles.panelparams, 'Visible', 'off');
        return;
    end
    algo = strcat('B_', methods{method});
    load_reactive(hObject, eventdata, handles, 'CRB_Mode', 'Blind', algo);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Op_2.
function Op_2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Op_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    method = get(handles.methods, 'Value');
    methods = get(handles.methods, 'String');
    if method == 1
        % Feedback turn off param panel
        set(handles.panelparams, 'Visible', 'off');
        return;
    end
    algo = strcat('B_', methods{method});
    load_reactive(hObject, eventdata, handles, 'CRB_Mode', 'Blind', algo);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Op_3.
function Op_3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Op_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    method = get(handles.methods, 'Value');
    methods = get(handles.methods, 'String');
    if method == 1
        % Feedback turn off param panel
        set(handles.panelparams, 'Visible', 'off');
        return;
    end
    algo = strcat('B_', methods{method});
    load_reactive(hObject, eventdata, handles, 'CRB_Mode', 'Blind', algo);

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Op_4.
function Op_4_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Op_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    method = get(handles.methods, 'Value');
    methods = get(handles.methods, 'String');
    if method == 1
        % Feedback turn off param panel
        set(handles.panelparams, 'Visible', 'off');
        return;
    end
    algo = strcat('B_', methods{method});
    load_reactive(hObject, eventdata, handles, 'CRB_Mode', 'Blind', algo);

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Op_5.
function Op_5_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Op_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    method = get(handles.methods, 'Value');
    methods = get(handles.methods, 'String');
    if method == 1
        % Feedback turn off param panel
        set(handles.panelparams, 'Visible', 'off');
        return;
    end
    algo = strcat('B_', methods{method});
    load_reactive(hObject, eventdata, handles, 'CRB_Mode', 'Blind', algo);

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Op_6.
function Op_6_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Op_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    method = get(handles.methods, 'Value');
    methods = get(handles.methods, 'String');
    if method == 1
        % Feedback turn off param panel
        set(handles.panelparams, 'Visible', 'off');
        return;
    end
    algo = strcat('B_', methods{method});
    load_reactive(hObject, eventdata, handles, 'CRB_Mode', 'Blind', algo);

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Op_7.
function Op_7_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Op_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    method = get(handles.methods, 'Value');
    methods = get(handles.methods, 'String');
    if method == 1
        % Feedback turn off param panel
        set(handles.panelparams, 'Visible', 'off');
        return;
    end
    algo = strcat('B_', methods{method});
    load_reactive(hObject, eventdata, handles, 'CRB_Mode', 'Blind', algo);

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Op_8.
function Op_8_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Op_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    method = get(handles.methods, 'Value');
    methods = get(handles.methods, 'String');
    if method == 1
        % Feedback turn off param panel
        set(handles.panelparams, 'Visible', 'off');
        return;
    end
    algo = strcat('B_', methods{method});
    load_reactive(hObject, eventdata, handles, 'CRB_Mode', 'Blind', algo);

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Op_9.
function Op_9_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Op_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    method = get(handles.methods, 'Value');
    methods = get(handles.methods, 'String');
    if method == 1
        % Feedback turn off param panel
        set(handles.panelparams, 'Visible', 'off');
        return;
    end
    algo = strcat('B_', methods{method});
    load_reactive(hObject, eventdata, handles, 'CRB_Mode', 'Blind', algo);

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Op_10.
function Op_10_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Op_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    method = get(handles.methods, 'Value');
    methods = get(handles.methods, 'String');
    if method == 1
        % Feedback turn off param panel
        set(handles.panelparams, 'Visible', 'off');
        return;
    end
    algo = strcat('B_', methods{method});
    load_reactive(hObject, eventdata, handles, 'CRB_Mode', 'Blind', algo);


% --- Executes during object creation, after setting all properties.
function Monte_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Monte_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    set(hObject, 'units','pixels');
    set(hObject, 'Position', [30, 50, 90, 20]);

% --- Executes during object creation, after setting all properties.
function SNR_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SNR_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    set(hObject, 'units','pixels');
    set(hObject, 'Position', [25, 15, 45, 20]);

% --- Executes during object creation, after setting all properties.
function dB_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dB_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    set(hObject, 'units','pixels');
    set(hObject, 'Position', [175, 15, 30, 20]);


% --- Executes on button press in ref_web.
function ref_web_Callback(hObject, eventdata, handles)
% hObject    handle to ref_web (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    method = get(handles.methods, 'Value');
    methods = get(handles.methods, 'String');
    algo = strcat('B_', methods{method});
    msg = load_help(algo);

    help_questdlg(msg, algo);
