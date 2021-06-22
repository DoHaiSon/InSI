function varargout = Data_Menu(varargin)
% DATA_MENU MATLAB code for Data_Menu.fig
%      DATA_MENU, by itself, creates a new DATA_MENU or raises the existing
%      singleton*.
%
%      H = DATA_MENU returns the handle to a new DATA_MENU or the handle to
%      the existing singleton*.
%
%      DATA_MENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DATA_MENU.M with the given input arguments.
%
%      DATA_MENU('Property','Value',...) creates a new DATA_MENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Data_Menu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Data_Menu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Data_Menu

% Last Modified by GUIDE v2.5 22-Jun-2021 18:34:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Data_Menu_OpeningFcn, ...
                   'gui_OutputFcn',  @Data_Menu_OutputFcn, ...
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


% --- Executes just before Data_Menu is made visible.
function Data_Menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user method (see GUIDATA)
% varargin   command line arguments to Data_Menu (see VARARGIN)

% Choose default command line output for Data_Menu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Data_Menu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Data_Menu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user method (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in domain.
function domain_Callback(hObject, eventdata, handles)
% hObject    handle to domain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user method (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns domain contents as cell array
    contents = get(hObject, 'Value') - 1;
    if contents == 0
        return;
    end
    methods = {'Pilot', 'Semi-blind', 'Blind'};
    method = get(handles.method, 'Value') - 1;
    if method == 0
        if contents == 1
            disp('CE - Time Domain');
        else
            disp('CE - Frequency Domain');
        end
    else
        if contents == 1
            fprintf('CE - Time Domain - %s\n', char(methods(method)));
        else
            fprintf('CE - Frequency Domain - %s\n', char(methods(method)));
        end
    end


% --- Executes during object creation, after setting all properties.
function domain_CreateFcn(hObject, eventdata, handles)
% hObject    handle to domain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in method.
function method_Callback(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user method (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns method contents as cell array
    
    % Get domain
    Domain = get(handles.domain,'Value') - 1;
    if Domain == 0
        return;
    end
    if Domain == 1
        Domain = 'CE - Time Domain';
    else
        Domain = 'CE - Frequency Domain';
    end    
    
    
    contents = get(hObject,'Value') - 1;
    if contents == 0
        return;
    end

    if contents == 1
        fprintf('%s - Pilot\n', Domain);
    elseif contents == 2
        fprintf('%s - Semi-blind\n', Domain);

    else
        fprintf('%s - Blind\n', Domain);
    end


% --- Executes during object creation, after setting all properties.
function method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in modulation.
function modulation_Callback(hObject, eventdata, handles)
% hObject    handle to modulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user method (see GUIDATA)

    mod = get(hObject,'Value') -1 ;
    if mod == 0
        return;
    end
    
    disp('OFDM Modulation: 64 sub-carriers');
%     handles_main = getappdata(0,'handles_main');
%     scatter(handles_main.dataaxes, real(data), imag(data));

% --- Executes during object creation, after setting all properties.
function modulation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to modulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Nr_Callback(hObject, eventdata, handles)
% hObject    handle to Nr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user method (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Nr as text
%        str2double(get(hObject,'String')) returns contents of Nr as a double


% --- Executes during object creation, after setting all properties.
function Nr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Nr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ratio_Callback(hObject, eventdata, handles)
% hObject    handle to ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user method (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ratio as text
%        str2double(get(hObject,'String')) returns contents of ratio as a double


% --- Executes during object creation, after setting all properties.
function ratio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function multipaths_Callback(hObject, eventdata, handles)
% hObject    handle to multipaths (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user method (see GUIDATA)

% Hints: get(hObject,'String') returns contents of multipaths as text
%        str2double(get(hObject,'String')) returns contents of multipaths as a double


% --- Executes during object creation, after setting all properties.
function multipaths_CreateFcn(hObject, eventdata, handles)
% hObject    handle to multipaths (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Nt_Callback(hObject, eventdata, handles)
% hObject    handle to Nt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user method (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Nt as text
%        str2double(get(hObject,'String')) returns contents of Nt as a double


% --- Executes during object creation, after setting all properties.
function Nt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Nt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function order_Callback(hObject, eventdata, handles)
% hObject    handle to order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user method (see GUIDATA)

% Hints: get(hObject,'String') returns contents of order as text
%        str2double(get(hObject,'String')) returns contents of order as a double


% --- Executes during object creation, after setting all properties.
function order_CreateFcn(hObject, eventdata, handles)
% hObject    handle to order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function subcarriers_Callback(hObject, eventdata, handles)
% hObject    handle to subcarriers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user method (see GUIDATA)

% Hints: get(hObject,'String') returns contents of subcarriers as text
%        str2double(get(hObject,'String')) returns contents of subcarriers as a double


% --- Executes during object creation, after setting all properties.
function subcarriers_CreateFcn(hObject, eventdata, handles)
% hObject    handle to subcarriers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in apply.
function apply_Callback(hObject, eventdata, handles)
% hObject    handle to apply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    % Get handes form main window
    handles_main = getappdata(0,'handles_main');
    global legends;
    
    if~(get(handles_main.holdon, 'Value'))
        %clear old method
        cla(handles_main.mainaxes, 'reset');
    end
        
    Nt = str2double(get(handles.Nt, 'String'));
    Nr = str2double(get(handles.Nr, 'String'));
    L = str2double(get(handles.order, 'String'));
    M = str2double(get(handles.multipaths, 'String'));
    K = str2double(get(handles.subcarriers, 'String'));
    ratio = str2double(get(handles.ratio, 'String'));
    
    if get(handles.method, 'Value') - 1 == 0
        return
    end
    
    % Run function:
    
    if get(handles.method, 'Value') - 1 == 1
        loader(.5, 'Processing');
        [SNR, CRB_op, CRB_op_spec, CRB_SB, CRB_SB_spec] = ULA(Nt, Nr, L, M, K, ratio, 1, ...
            get(handles.domain, 'Value') - 1, 1);
        %GUI to WS
        GUI2WS(SNR);
        GUI2WS(CRB_op);
        %figure
    
        cla(handles_main.board,'reset');
        set(handles_main.board, 'Visible', 'off');     
        set(handles_main.mainaxes, 'Visible', 'on');
        
        semilogy(handles_main.mainaxes, SNR, CRB_op, '-o');
        legends{end + 1} = 'normal OP';
        legend(handles_main.mainaxes, legends);
    else
        loader(0.0103*(Nt*Nr*L)^2 - 0.5228*(Nt*Nr*L) + 7.1862, 'Processing');
        [SNR, CRB_op, CRB_op_spec, CRB_SB, CRB_SB_spec] = ULA(Nt, Nr, L, M, K, ratio, 1, ...
            get(handles.domain, 'Value') - 1, 2);
        %GUI to WS
        GUI2WS(SNR);
        GUI2WS(CRB_SB);
        %figure
    
        cla(handles_main.board,'reset');
        set(handles_main.board, 'Visible', 'off');     
        set(handles_main.mainaxes, 'Visible', 'on');
        
        semilogy(handles_main.mainaxes, SNR, CRB_SB,'->');
        legends{end + 1} = 'normal SB';
        legend(handles_main.mainaxes, legends);
    end
    hold (handles_main.mainaxes, 'on');
    grid (handles_main.mainaxes, 'on');
    ylabel(handles_main.mainaxes, 'Normalized CRB');
    xlabel(handles_main.mainaxes, 'SNR(dB)');
    title(handles_main.mainaxes, 'CRB');
