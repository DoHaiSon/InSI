function varargout = Semi_Blind_Menu(varargin)
% SEMI_BLIND_MENU MATLAB code for Semi_Blind_Menu.fig
%      SEMI_BLIND_MENU, by itself, creates a new SEMI_BLIND_MENU or raises the existing
%      singleton*.
%
%      H = SEMI_BLIND_MENU returns the handle to a new SEMI_BLIND_MENU or the handle to
%      the existing singleton*.
%
%      SEMI_BLIND_MENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEMI_BLIND_MENU.M with the given input arguments.
%
%      SEMI_BLIND_MENU('Property','Value',...) creates a new SEMI_BLIND_MENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Semi_Blind_Menu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Semi_Blind_Menu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Semi_Blind_Menu

% Last Modified by GUIDE v2.5 06-Aug-2021 10:15:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;

% Master timer
global time;

% Path of start.m file
global main_path;

gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Semi_Blind_Menu_OpeningFcn, ...
                   'gui_OutputFcn',  @Semi_Blind_Menu_OutputFcn, ...
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


% --- Executes just before Semi_Blind_Menu is made visible.
function Semi_Blind_Menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user method (see GUIDATA)
% varargin   command line arguments to Semi_Blind_Menu (see VARARGIN)

global main_path;
jFrame=get(handle(handles.figure1), 'javaframe');
jicon=javax.swing.ImageIcon(fullfile(main_path,'/Resource/Icon/menu_icon.png'));
jFrame.setFigureIcon(jicon);

handles_main = getappdata(0,'handles_main');
axesH = handles_main.board;  % Not safe! Better get the handle explicitly!
img = imread(fullfile(main_path, '/Resource/Dashboard/nonblind_model.png'));
imshow(img, 'Parent', axesH);

% Set position for this GUI
movegui(hObject, 'west');

% Choose default command line output for Semi_Blind_Menu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Semi_Blind_Menu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Semi_Blind_Menu_OutputFcn(hObject, eventdata, handles) 
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
    if contents == 1
        disp('None Blind - Time Domain');
    else
        disp('None Blind - Frequency Domain');
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
        
    Nt    = str2double(get(handles.Nt, 'String'));
    Nr    = str2double(get(handles.Nr, 'String'));
    L     = str2double(get(handles.order, 'String'));
    M     = str2double(get(handles.multipaths, 'String'));
    K     = str2double(get(handles.subcarriers, 'String'));
    ratio = str2double(get(handles.ratio, 'String'));
    
    if (get(handles.methods, 'Value') - 1 == 0)
        return;
    end
    
    % Exec function:
    if (get(handles.methods, 'Value') - 1 == 1)
        loader('Processing');
        [SNR, CRB_op, CRB_op_spec, CRB_SB, CRB_SB_spec] = ULA(Nt, Nr, L, M, K, ratio, 1, ...
            get(handles.domain, 'Value') - 1, 2);

        % Close loader window
        try
            F = findall(0, 'type', 'figure', 'tag', 'loader');
            waitbar(1, F, 'Done!');
            close(F);
        catch ME
            disp(ME);
        end

        % GUI to WS
        GUI2WS(SNR);
        GUI2WS(CRB_SB);

        % figure

        cla(handles_main.board,'reset');
        set(handles_main.board, 'Visible', 'off');
        set(handles_main.mainaxes, 'Visible', 'on');

        semilogy(handles_main.mainaxes, SNR, CRB_SB, '-o');
        legends{end + 1} = 'normal SB';
        legend(handles_main.mainaxes, legends);
    elseif (get(handles.methods, 'Value') - 1 == 2)
        loader('Processing');
        [SNR, CRB_op, CRB_op_spec, CRB_SB, CRB_SB_spec] = ULA(Nt, Nr, L, M, K, ratio, 2, ...
            get(handles.domain, 'Value') - 1, 2);
        % Close loader window
        try
            F = findall(0, 'type', 'figure', 'tag', 'loader');
            waitbar(1, F, 'Done!');
            close(F);
        catch ME
            disp(ME);
        end
        
        %GUI to WS
        GUI2WS(SNR);
        GUI2WS(CRB_SB_spec);
        %figure
        
        cla(handles_main.board,'reset');
        set(handles_main.board, 'Visible', 'off');
        set(handles_main.mainaxes, 'Visible', 'on');
        
        semilogy(handles_main.mainaxes, SNR, CRB_SB_spec,'-*');
        legends{end + 1} = 'spec SB';
        legend(handles_main.mainaxes, legends);
    end
    
    hold (handles_main.mainaxes, 'on');
    grid (handles_main.mainaxes, 'on');
    ylabel(handles_main.mainaxes, 'Normalized CRB');
    xlabel(handles_main.mainaxes, 'SNR(dB)');
    title(handles_main.mainaxes, 'CRB');


% --- Executes on selection change in methods.
function methods_Callback(hObject, eventdata, handles)
% hObject    handle to methods (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns methods contents as cell array
%        contents{get(hObject,'Value')} returns selected item from methods


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
    
    set(hObject, 'String', {'            Select method', '                    Data', '                 Specular'})
