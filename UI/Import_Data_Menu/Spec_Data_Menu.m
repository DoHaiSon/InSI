function varargout = Spec_Data_Menu(varargin)
%SPEC_DATA_MENU MATLAB code file for Spec_Data_Menu.fig
%      SPEC_DATA_MENU, by itself, creates a new SPEC_DATA_MENU or raises the existing
%      singleton*.
%
%      H = SPEC_DATA_MENU returns the handle to a new SPEC_DATA_MENU or the handle to
%      the existing singleton*.
%
%      SPEC_DATA_MENU('Property','Value',...) creates a new SPEC_DATA_MENU using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to Spec_Data_Menu_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      SPEC_DATA_MENU('CALLBACK') and SPEC_DATA_MENU('CALLBACK',hObject,...) call the
%      local function named CALLBACK in SPEC_DATA_MENU.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Spec_Data_Menu

% Last Modified by GUIDE v2.5 21-Jun-2021 13:30:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Spec_Data_Menu_OpeningFcn, ...
                   'gui_OutputFcn',  @Spec_Data_Menu_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before Spec_Data_Menu is made visible.
function Spec_Data_Menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for Spec_Data_Menu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Spec_Data_Menu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Spec_Data_Menu_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Nr_Callback(hObject, eventdata, handles)
% hObject    handle to Nr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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
% handles    structure with handles and user data (see GUIDATA)

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
% handles    structure with handles and user data (see GUIDATA)

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
% handles    structure with handles and user data (see GUIDATA)

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
% handles    structure with handles and user data (see GUIDATA)

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
% handles    structure with handles and user data (see GUIDATA)

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


% --- Executes on selection change in method.
function method_Callback(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from method


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


% --- Executes on selection change in data.
function data_Callback(hObject, eventdata, handles)
% hObject    handle to data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns data contents as cell array
%        contents{get(hObject,'Value')} returns selected item from data


% --- Executes during object creation, after setting all properties.
function data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data (see GCBO)
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
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns modulation contents as cell array
%        contents{get(hObject,'Value')} returns selected item from modulation


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


% --- Executes on button press in apply.
function apply_Callback(hObject, eventdata, handles)
% hObject    handle to apply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Get handes form main window
    handles_main = getappdata(0,'handles_main');
    
    if~(get(handles_main.holdon, 'Value'))
        %clear old data
        cla(handles_main.mainaxes, 'reset');
    end
        
    Nt = str2double(get(handles.Nt, 'String'));
    Nr = str2double(get(handles.Nr, 'String'));
    L = str2double(get(handles.order, 'String'));
    M = str2double(get(handles.multipaths, 'String'));
    K = str2double(get(handles.subcarriers, 'String'));
    ratio = str2double(get(handles.ratio, 'String'));
    [SNR, CRB_op, CRB_op_spec, CRB_SB, CRB_SB_spec] = SEMI_ULA(Nt, Nr, L, M, K, ratio);
    %export to WS
    Export2WS(SNR);
    Export2WS(CRB_op);
    Export2WS(CRB_op_spec);
    Export2WS(CRB_SB);
    Export2WS(CRB_SB_spec);
    %figure
    
    semilogy(handles_main.mainaxes, SNR,CRB_op,'-b>');
    hold (handles_main.mainaxes, 'on');
    semilogy(handles_main.mainaxes, SNR,CRB_op_spec,'-r+');
    hold (handles_main.mainaxes, 'on');
    semilogy(handles_main.mainaxes, SNR,CRB_SB,'-g');
    hold (handles_main.mainaxes, 'on');
    semilogy(handles_main.mainaxes, SNR,CRB_SB_spec,'-m');
    grid (handles_main.mainaxes, 'on');
    ylabel(handles_main.mainaxes, 'Normalized CRB');
    xlabel(handles_main.mainaxes, 'SNR(dB)');
    legend(handles_main.mainaxes, 'normal OP','spec OP','normal SB','spec SB');
    title(handles_main.mainaxes, 'CRB');
