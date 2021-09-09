function varargout = main(varargin)
% main MATLAB code for main.fig
%      main, by itself, creates a new main or raises the existing
%      singleton*.
%
%      H = main returns the handle to a new main or the handle to
%      the existing singleton*.
%
%      main('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in main.M with the given input arguments.
%
%      main('Property','Value',...) creates a new main or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 27-Aug-2021 11:06:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;

% Master timer
global time;

% Path of start.m file
global main_path;

gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    % Disable the Java-related warnings after 2019b
    TurnOffWarnings;
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)
global main_path;
jFrame=get(handle(handles.figure1), 'javaframe');
jicon=javax.swing.ImageIcon(fullfile(main_path,'/Resource/Icon/main_icon.png'));
jFrame.setFigureIcon(jicon);

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
setappdata(0,'handles_main', handles)

% Set position for this GUI
movegui(hObject, 'center');

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function Options_Callback(hObject, eventdata, handles)
% hObject    handle to Options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Window_Callback(hObject, eventdata, handles)
% hObject    handle to Window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Help_Callback(hObject, eventdata, handles)
% hObject    handle to Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function About_Callback(hObject, eventdata, handles)
% hObject    handle to About (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global main_path;
[msgicon, iconcmap] = imread('AV.png');
hm = msgbox({'Blind system identification 1.0.'; 'Copyright 2020 AVITECH.'}, 'About', 'custom', msgicon, iconcmap);
jframe=get(hm, 'javaframe');
jIcon=javax.swing.ImageIcon(fullfile(main_path, '/Resource/Icon/about.png'));
jframe.setFigureIcon(jIcon);


% --------------------------------------------------------------------
function Open_Callback(hObject, eventdata, handles)
% hObject    handle to Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path = Openfile();
disp(path);


% --------------------------------------------------------------------
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Close_Callback(hObject, eventdata, handles)
% hObject    handle to Close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq();
    
% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function model_CreateFcn(hObject, eventdata, handles)
% hObject    handle to model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

state = get(hObject,'Value');
if state
    disp('Switch to Demo');
    set(handles.togglebutton1, 'String' , 'CRB Mode');
else
    disp('Switch to CRB');
    set(handles.togglebutton1, 'String' , 'Demo Mode');
end


% --- Executes during object creation, after setting all properties.
function dataaxes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dataaxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate dataaxes


% --------------------------------------------------------------------
% function save_fig_ClickedCallback(hObject, eventdata, handles)
% % hObject    handle to save_fig (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
%     % Save recently axes to .fig file
%     Fig_tmp = figure('Visible','on');
%     copyobj(handles.mainaxes, Fig_tmp);
%     global main_path;
%     output_file = fullfile(main_path, 'CRB.fig');
%     saveas(Fig_tmp, output_file, 'fig');
%     fprintf('Saved fig to: %s.\n', output_file);


% --- Executes on button press in Pilotbutton.
function Pilotbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Pilotbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    None_Blind_Menu();


% --- Executes on button press in SBbutton.
function SBbutton_Callback(hObject, eventdata, handles)
% hObject    handle to SBbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    Semi_Blind_Menu();


% --- Executes on button press in holdon.
function holdon_Callback(hObject, eventdata, handles)
% hObject    handle to holdon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of holdon
    holdon_state = get(hObject,'Value');
    sub_fig_state= get(handles.sub_fig, 'Value');
    if holdon_state && sub_fig_state
        set(handles.sub_fig, 'Value', 0);
    end


% --- Executes during object creation, after setting all properties.
function board_CreateFcn(hObject, eventdata, handles)
% hObject    handle to board (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate board
    global main_path;
    axesH = hObject;  % Not safe! Better get the handle explicitly!
    img = imread(fullfile(main_path, '/Resource/Dashboard/Dashboard.png'));
    imshow(img);
    set(axesH, 'Tag', 'board');


% --- Executes on button press in Blindbutton.
function Blindbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Blindbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in sub_fig.
function sub_fig_Callback(hObject, eventdata, handles)
% hObject    handle to sub_fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sub_fig
    holdon_state = get(hObject,'Value');
    sub_fig_state= get(handles.sub_fig, 'Value');
    if holdon_state && sub_fig_state
        set(handles.holdon, 'Value', 0);
    end
