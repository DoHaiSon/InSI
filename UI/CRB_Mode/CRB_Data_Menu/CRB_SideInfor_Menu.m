function varargout = CRB_SideInfor_Menu(varargin)
% CRB_SIDEINFOR_MENU MATLAB code for CRB_SideInfor_Menu.fig
%      CRB_SIDEINFOR_MENU, by itself, creates a new CRB_SIDEINFOR_MENU or raises the existing
%      singleton*.
%
%      H = CRB_SIDEINFOR_MENU returns the handle to a new CRB_SIDEINFOR_MENU or the handle to
%      the existing singleton*.
%
%      CRB_SIDEINFOR_MENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CRB_SIDEINFOR_MENU.M with the given input arguments.
%
%      CRB_SIDEINFOR_MENU('Property','Value',...) creates a new CRB_SIDEINFOR_MENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CRB_SideInfor_Menu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CRB_SideInfor_Menu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CRB_SideInfor_Menu

% Last Modified by GUIDE v2.5 28-Jul-2023 15:47:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;

gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CRB_SideInfor_Menu_OpeningFcn, ...
                   'gui_OutputFcn',  @CRB_SideInfor_Menu_OutputFcn, ...
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


% --- Executes just before CRB_SideInfor_Menu is made visible.
function CRB_SideInfor_Menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user method (see GUIDATA)
% varargin   command line arguments to CRB_SideInfor_Menu (see VARARGIN)

    global main_path;
    jFrame=get(handle(handles.InSI_C_SI), 'javaframe');
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
    
    % Choose default command line output for CRB_SideInfor_Menu
    handles.output = hObject;
    
    % Update handles structure
    guidata(hObject, handles);
    
    % UIWAIT makes CRB_SideInfor_Menu wait for user response (see UIRESUME)
    % uiwait(handles.InSI_C_SI);


% --- Outputs from this function are returned to the command line.
function varargout = CRB_SideInfor_Menu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user method (see GUIDATA)

    varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function methods_CreateFcn(hObject, eventdata, handles)
% hObject    handle to methods (see GCBO) Side-information
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.3445586671393123);
    % Set default menu to escape error when temp of menu is stored
    default = '              Select model';
    set(hObject, 'String', default);
    methods = load_methods(default, 'CRB_Mode', 'Side-information');
    set(hObject, 'String', methods);

% --- Executes on selection change in methods.
function methods_Callback(hObject, eventdata, handles)
% hObject    handle to methods (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    method = get(hObject, 'Value');
    methods = get(hObject, 'String');
    if method == 1
        % Feedback turn off param panel
        set(handles.panelparams, 'Visible', 'off');
        set(handles.ref_web, 'Visible', 'off');
        return;
    end
    % TODO: Version is lost when choose default but method is not default
    algo = strcat('SI_', methods{method});
    load_params(hObject, eventdata, handles, 'CRB_Mode', 'Side-information', algo);

    set(handles.ref_web, 'Visible', 'on');


% --- Executes during object creation, after setting all properties.
function panelparams_CreateFcn(hObject, eventdata, handles)
% hObject    handle to panelparams (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'Visible', 'off');
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.034111008169797015);


% --- Executes during object creation, after setting all properties.
function Op_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.5990783410138246);


function Op_1_Callback(hObject, eventdata, handles)
% hObject    handle to Op_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    input_data(hObject);

    if (strcmp(get(hObject, 'Style'), 'togglebutton'))
        value = get(hObject, 'Value');
        if value == 1
            set(hObject, 'String', 'on');
        else
            set(hObject, 'String', 'off');
        end
    end

    
% --- Executes during object creation, after setting all properties.
function Op_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.5990783410138246);


function Op_2_Callback(hObject, eventdata, handles)
% hObject    handle to Op_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    input_data(hObject);

    if (strcmp(get(hObject, 'Style'), 'togglebutton'))
        value = get(hObject, 'Value');
        if value == 1
            set(hObject, 'String', 'on');
        else
            set(hObject, 'String', 'off');
        end
    end

    
% --- Executes during object creation, after setting all properties.
function Op_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.5990783410138246);


function Op_3_Callback(hObject, eventdata, handles)
% hObject    handle to Op_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    input_data(hObject);

    if (strcmp(get(hObject, 'Style'), 'togglebutton'))
        value = get(hObject, 'Value');
        if value == 1
            set(hObject, 'String', 'on');
        else
            set(hObject, 'String', 'off');
        end
    end

    
% --- Executes during object creation, after setting all properties.
function Op_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.5990783410138246);


function Op_4_Callback(hObject, eventdata, handles)
% hObject    handle to Op_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    input_data(hObject);

    if (strcmp(get(hObject, 'Style'), 'togglebutton'))
        value = get(hObject, 'Value');
        if value == 1
            set(hObject, 'String', 'on');
        else
            set(hObject, 'String', 'off');
        end
    end

    
% --- Executes during object creation, after setting all properties.
function Op_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.5990783410138246);


function Op_5_Callback(hObject, eventdata, handles)
% hObject    handle to Op_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    input_data(hObject);

    if (strcmp(get(hObject, 'Style'), 'togglebutton'))
        value = get(hObject, 'Value');
        if value == 1
            set(hObject, 'String', 'on');
        else
            set(hObject, 'String', 'off');
        end
    end

    
% --- Executes during object creation, after setting all properties.
function Op_6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.5990783410138246);


function Op_6_Callback(hObject, eventdata, handles)
% hObject    handle to Op_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    input_data(hObject);

    if (strcmp(get(hObject, 'Style'), 'togglebutton'))
        value = get(hObject, 'Value');
        if value == 1
            set(hObject, 'String', 'on');
        else
            set(hObject, 'String', 'off');
        end
    end

    
% --- Executes during object creation, after setting all properties.
function Op_7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.5990783410138246);


function Op_7_Callback(hObject, eventdata, handles)
% hObject    handle to Op_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    input_data(hObject);

    if (strcmp(get(hObject, 'Style'), 'togglebutton'))
        value = get(hObject, 'Value');
        if value == 1
            set(hObject, 'String', 'on');
        else
            set(hObject, 'String', 'off');
        end
    end

    
% --- Executes during object creation, after setting all properties.
function Op_8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.5990783410138246);


function Op_8_Callback(hObject, eventdata, handles)
% hObject    handle to Op_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    input_data(hObject);
    
    if (strcmp(get(hObject, 'Style'), 'togglebutton'))
        value = get(hObject, 'Value');
        if value == 1
            set(hObject, 'String', 'on');
        else
            set(hObject, 'String', 'off');
        end
    end

    
% --- Executes during object creation, after setting all properties.
function Op_9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.5990783410138246);


function Op_9_Callback(hObject, eventdata, handles)
% hObject    handle to Op_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    input_data(hObject);

    if (strcmp(get(hObject, 'Style'), 'togglebutton'))
        value = get(hObject, 'Value');
        if value == 1
            set(hObject, 'String', 'on');
        else
            set(hObject, 'String', 'off');
        end
    end

    
% --- Executes during object creation, after setting all properties.
function Op_10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Op_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.5990783410138246);


function Op_10_Callback(hObject, eventdata, handles)
% hObject    handle to Op_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    input_data(hObject);
    
    if (strcmp(get(hObject, 'Style'), 'togglebutton'))
        value = get(hObject, 'Value');
        if value == 1
            set(hObject, 'String', 'on');
        else
            set(hObject, 'String', 'off');
        end
    end


% --- Executes during object creation, after setting all properties.
function Monte_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Monte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6666666666666666);

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
    set(hObject, 'FontSize', 0.6666666666666666);


function SNR_Callback(hObject, eventdata, handles)
% hObject    handle to SNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
    algo = strcat('SI_', methods{method});
    load_funcs(hObject, eventdata, handles, 'CRB_Mode', 'Side-information', algo);
    

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
    algo = strcat('SI_', methods{method});
    load_reactive(hObject, eventdata, handles, 'CRB_Mode', 'Side-information', algo);


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
    algo = strcat('SI_', methods{method});
    load_reactive(hObject, eventdata, handles, 'CRB_Mode', 'Side-information', algo);


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
    algo = strcat('SI_', methods{method});
    load_reactive(hObject, eventdata, handles, 'CRB_Mode', 'Side-information', algo);


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
    algo = strcat('SI_', methods{method});
    load_reactive(hObject, eventdata, handles, 'CRB_Mode', 'Side-information', algo);


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
    algo = strcat('SI_', methods{method});
    load_reactive(hObject, eventdata, handles, 'CRB_Mode', 'Side-information', algo);


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
    algo = strcat('SI_', methods{method});
    load_reactive(hObject, eventdata, handles, 'CRB_Mode', 'Side-information', algo);


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
    algo = strcat('SI_', methods{method});
    load_reactive(hObject, eventdata, handles, 'CRB_Mode', 'Side-information', algo);


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
    algo = strcat('SI_', methods{method});
    load_reactive(hObject, eventdata, handles, 'CRB_Mode', 'Side-information', algo);


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
    algo = strcat('SI_', methods{method});
    load_reactive(hObject, eventdata, handles, 'CRB_Mode', 'Side-information', algo);


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
    algo = strcat('SI_', methods{method});
    load_reactive(hObject, eventdata, handles, 'CRB_Mode', 'Side-information', algo);


% --- Executes during object creation, after setting all properties.
function Monte_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Monte_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.7333333333333333);


% --- Executes during object creation, after setting all properties.
function SNR_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SNR_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.7333333333333333);


% --- Executes during object creation, after setting all properties.
function dB_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dB_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.7333333333333333);


% --- Executes on button press in ref_web.
function ref_web_Callback(hObject, eventdata, handles)
% hObject    handle to ref_web (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    method = get(handles.methods, 'Value');
    methods = get(handles.methods, 'String');
    algo = strcat('SI_', methods{method});
    msg = load_help(algo);

    help_questdlg(msg, algo);


% --- Executes during object creation, after setting all properties.
function panelconfig_CreateFcn(hObject, eventdata, handles)
% hObject    handle to panelconfig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.18797864933859362);


% --- Executes during object creation, after setting all properties.
function apply_CreateFcn(hObject, eventdata, handles)
% hObject    handle to apply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.38166002174700964);


% --- Executes during object creation, after setting all properties.
function ref_web_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ref_web (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    
    set(hObject.Parent, 'units','pixels');
    [x, y, w, h] = scale_InSI(hObject.Parent);
    set(hObject.Parent, 'Position', [x, y, w, h]);

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.3215880893300251);


% --- Executes during object creation, after setting all properties.
function Text_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Text_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.7061900610287699);


% --- Executes during object creation, after setting all properties.
function Text_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Text_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.7061900610287699);


% --- Executes during object creation, after setting all properties.
function Text_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Text_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6699751861042192);


% --- Executes during object creation, after setting all properties.
function Text_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Text_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.7917888563049847);


% --- Executes during object creation, after setting all properties.
function Text_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Text_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.7061900610287699);


% --- Executes during object creation, after setting all properties.
function Text_6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Text_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.7917888563049871);


% --- Executes during object creation, after setting all properties.
function Text_7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Text_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6699751861042185);


% --- Executes during object creation, after setting all properties.
function Text_8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Text_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6532258064516129);


% --- Executes during object creation, after setting all properties.
function Text_9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Text_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6699751861042192);


% --- Executes during object creation, after setting all properties.
function Text_10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Text_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.6076519129782452);
