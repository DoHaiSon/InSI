function varargout = Demo_Menu(varargin)
% DEMO_MENU MATLAB code for Demo_Menu.fig
%      DEMO_MENU, by itself, creates a new DEMO_MENU or raises the existing
%      singleton*.
%
%      H = DEMO_MENU returns the handle to a new DEMO_MENU or the handle to
%      the existing singleton*.
%
%      DEMO_MENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEMO_MENU.M with the given input arguments.
%
%      DEMO_MENU('Property','Value',...) creates a new DEMO_MENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Demo_Menu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Demo_Menu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Demo_Menu

% Last Modified by GUIDE v2.5 31-Jul-2023 17:51:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;

gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Demo_Menu_OpeningFcn, ...
                   'gui_OutputFcn',  @Demo_Menu_OutputFcn, ...
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


% --- Executes just before Demo_Menu is made visible.
function Demo_Menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user method (see GUIDATA)
% varargin   command line arguments to Demo_Menu (see VARARGIN)

    global main_path;
    jFrame=get(handle(handles.InSI_D_Menu), 'javaframe');
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
    
    % Choose default command line output for Demo_Menu
    handles.output = hObject;
    
    % Update handles structure
    guidata(hObject, handles);
    
    % UIWAIT makes Demo_Menu wait for user response (see UIRESUME)
    % uiwait(handles.InSI_D_Menu);

    
    %% Load params here
    handles_main = getappdata(0,'handles_main');
    stack = dbstack();
    tree  = [stack.name];

    Op = {};
    Op_s = {};
    if ~isempty(strfind(tree, 'Op1_button_Callback'))
        Op_s = get(handles_main.Op1_button, 'String');
        Op   = Op_s(get(handles_main.Op1_button, 'Value'));
    end
    if ~isempty(strfind(tree, 'Op2_button_Callback'))
        Op_s = get(handles_main.Op2_button, 'String');
        Op   = Op_s(get(handles_main.Op2_button, 'Value'));
    end
    if ~isempty(strfind(tree, 'Op3_button_Callback'))
        Op_s = get(handles_main.Op3_button, 'String');
        Op   = Op_s(get(handles_main.Op3_button, 'Value'));
    end
    if ~isempty(strfind(tree, 'Op4_button_Callback'))
        Op_s = get(handles_main.Op4_button, 'String');
        Op   = Op_s(get(handles_main.Op4_button, 'Value'));
    end
    if ~isempty(strfind(tree, 'Op5_button_Callback'))
        Op_s = get(handles_main.Op5_button, 'String');
        Op   = Op_s(get(handles_main.Op5_button, 'Value'));
    end

    % CRB or not
    if ~isempty(strfind(Op_s{1}, 'CRB'))
        set(handles.btngroup, 'Visible', 'off');
    end

    Option = strsplit(Op_s{1}, ' ');
    Option = Option{end};

    algo   = ['Demo_' Option '_' Op{1}];

    global Demo_Algo;
    Demo_Algo = algo;

    load_params(hObject, eventdata, handles, 'Demo_Mode', '', algo);
    
    set(handles.ref_web, 'Visible', 'on');


% --- Outputs from this function are returned to the command line.
function varargout = Demo_Menu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user method (see GUIDATA)

    varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function panelparams_CreateFcn(hObject, eventdata, handles)
% hObject    handle to panelparams (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject.Parent, 'units','pixels');
    [x, y, w, h] = scale_InSI(hObject.Parent);
    set(hObject.Parent, 'Position', [x, y, w, h]);

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.032491391378615335);


% --- Executes during object creation, after setting all properties.
function Op_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6639292159062649);


function Op_1_Callback(hObject, eventdata, handles)
% hObject    handle to Op_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    input_data(hObject);


% --- Executes during object creation, after setting all properties.
function Op_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6639292159062649);


function Op_2_Callback(hObject, eventdata, handles)
% hObject    handle to Op_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    input_data(hObject);


% --- Executes during object creation, after setting all properties.
function Op_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6639292159062649);


function Op_3_Callback(hObject, eventdata, handles)
% hObject    handle to Op_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    input_data(hObject);


% --- Executes during object creation, after setting all properties.
function Op_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6639292159062649);


function Op_4_Callback(hObject, eventdata, handles)
% hObject    handle to Op_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    input_data(hObject);


% --- Executes during object creation, after setting all properties.
function Op_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6639292159062649);


function Op_5_Callback(hObject, eventdata, handles)
% hObject    handle to Op_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    input_data(hObject);


% --- Executes during object creation, after setting all properties.
function Op_6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6639292159062649);


function Op_6_Callback(hObject, eventdata, handles)
% hObject    handle to Op_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    input_data(hObject);


% --- Executes during object creation, after setting all properties.
function Op_7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6639292159062649);


function Op_7_Callback(hObject, eventdata, handles)
% hObject    handle to Op_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    input_data(hObject);


% --- Executes during object creation, after setting all properties.
function Op_8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6639292159062649);


function Op_8_Callback(hObject, eventdata, handles)
% hObject    handle to Op_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    input_data(hObject);


% --- Executes during object creation, after setting all properties.
function Op_9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6639292159062649);


function Op_9_Callback(hObject, eventdata, handles)
% hObject    handle to Op_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    input_data(hObject);


% --- Executes during object creation, after setting all properties.
function Op_10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6639292159062649);

function Op_10_Callback(hObject, eventdata, handles)
% hObject    handle to Op_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    input_data(hObject);
    
% --- Executes during object creation, after setting all properties.
function Monte_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Monte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.7361744753539745);


function Monte_Callback(hObject, eventdata, handles)
% hObject    handle to Monte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function SNR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.7361744753539745);


function SNR_Callback(hObject, eventdata, handles)
% hObject    handle to SNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in apply.
function apply_Callback(hObject, eventdata, handles)
% hObject    handle to apply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    global Demo_Algo;
    algo = Demo_Algo;

    load_funcs(hObject, eventdata, handles, 'Demo_Mode', '', algo);
    

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Op_1.
function Op_1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Op_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    global Demo_Algo;
    algo = Demo_Algo;

    load_reactive(hObject, eventdata, handles, 'Demo_Mode', '', algo);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Op_2.
function Op_2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Op_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    global Demo_Algo;
    algo = Demo_Algo;

    load_reactive(hObject, eventdata, handles, 'Demo_Mode', '', algo);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Op_5.
function Op_5_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Op_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    global Demo_Algo;
    algo = Demo_Algo;

    load_reactive(hObject, eventdata, handles, 'Demo_Mode', '', algo);

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Op_6.
function Op_6_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Op_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    global Demo_Algo;
    algo = Demo_Algo;

    load_reactive(hObject, eventdata, handles, 'Demo_Mode', '', algo);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Op_9.
function Op_9_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Op_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    global Demo_Algo;
    algo = Demo_Algo;

    load_reactive(hObject, eventdata, handles, 'Demo_Mode', '', algo);

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Op_10.
function Op_10_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Op_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    global Demo_Algo;
    algo = Demo_Algo;

    load_reactive(hObject, eventdata, handles, 'Demo_Mode', '', algo);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Op_7.
function Op_7_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Op_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    global Demo_Algo;
    algo = Demo_Algo;

    load_reactive(hObject, eventdata, handles, 'Demo_Mode', '', algo);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Op_8.
function Op_8_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Op_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    global Demo_Algo;
    algo = Demo_Algo;

    load_reactive(hObject, eventdata, handles, 'Demo_Mode', '', algo);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Op_3.
function Op_3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Op_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    global Demo_Algo;
    algo = Demo_Algo;

    load_reactive(hObject, eventdata, handles, 'Demo_Mode', '', algo);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Op_4.
function Op_4_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Op_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    global Demo_Algo;
    algo = Demo_Algo;

    load_reactive(hObject, eventdata, handles, 'Demo_Mode', '', algo);


% --- Executes during object creation, after setting all properties.
function Monte_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Monte_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.7361744753539745);


% --- Executes during object creation, after setting all properties.
function SNR_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SNR_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called'

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.7361744753539745);


% --- Executes during object creation, after setting all properties.
function dB_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dB_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.7361744753539745);


% --- Executes on button press in ref_web.
function ref_web_Callback(hObject, eventdata, handles)
% hObject    handle to ref_web (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    global Demo_Algo;
    algo = Demo_Algo;

    msg = load_help(algo);

    help_questdlg(msg, algo);


% --- Executes during object creation, after setting all properties.
function apply_CreateFcn(hObject, eventdata, handles)
% hObject    handle to apply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.38720078161482135);


% --- Executes during object creation, after setting all properties.
function Text_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Text_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6758428269814599);


% --- Executes during object creation, after setting all properties.
function Text_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Text_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.7144624170946855);


% --- Executes during object creation, after setting all properties.
function Text_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Text_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6411842204695922);


% --- Executes during object creation, after setting all properties.
function Text_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Text_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.625154614957852);


% --- Executes during object creation, after setting all properties.
function Text_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Text_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6758428269814599);


% --- Executes during object creation, after setting all properties.
function Text_6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Text_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.7577631696458822);


% --- Executes during object creation, after setting all properties.
function Text_7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Text_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6411842204695916);


% --- Executes during object creation, after setting all properties.
function Text_8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Text_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.625154614957852);


% --- Executes during object creation, after setting all properties.
function Text_9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Text_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6411842204695908);


% --- Executes during object creation, after setting all properties.
function Text_10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Text_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6946162388420567);


% --- Executes during object creation, after setting all properties.
function panelconfig_CreateFcn(hObject, eventdata, handles)
% hObject    handle to panelconfig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.10681719225759374);


% --- Executes during object creation, after setting all properties.
function btngroup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to btngroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.11312911725463343);


% --- Executes during object creation, after setting all properties.
function ref_web_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ref_web (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.3342765125228479);


% --- Executes during object creation, after setting all properties.
function output1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to output1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.4806755934266588);


% --- Executes during object creation, after setting all properties.
function output2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to output2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.4806755934266588);


% --- Executes during object creation, after setting all properties.
function output3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to output3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.48067559342665866);


% --- Executes during object creation, after setting all properties.
function output4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to output4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.4806755934266588);
