function varargout = mode(varargin)
% MODE MATLAB code for mode.fig
%      MODE, by itself, creates a new MODE or raises the existing
%      singleton*.
%
%      H = MODE returns the handle to a new MODE or the handle to
%      the existing singleton*.
%
%      MODE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODE.M with the given input arguments.
%
%      MODE('Property','Value',...) creates a new MODE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mode_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mode_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mode

% Last Modified by GUIDE v2.5 02-Dec-2021 13:04:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mode_OpeningFcn, ...
                   'gui_OutputFcn',  @mode_OutputFcn, ...
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


% --- Executes just before mode is made visible.
function mode_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mode (see VARARGIN)
global main_path;
jFrame=get(handle(handles.figure1), 'javaframe');
jicon=javax.swing.ImageIcon(fullfile(main_path,'/Resource/Icon/main_icon.png'));
jFrame.setFigureIcon(jicon);

% Choose default command line output for mode
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mode wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mode_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in crb_mode.
function crb_mode_Callback(hObject, eventdata, handles)
% hObject    handle to crb_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    % TODO: not yet support
    global switch_mode;
    switch_mode = 1;
    loader('Opening the Performance mode', 'CRB_main');
    try
        F = findall(0, 'type', 'figure', 'tag', 'loader');
        waitbar(1, F, 'Done!');
        close(F);
    catch ME
        disp(ME);
    end
    closereq(); 

% --- Executes on button press in algo_mode.
function algo_mode_Callback(hObject, eventdata, handles)
% hObject    handle to algo_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    %%  Load main GUI
    global switch_mode;
    switch_mode = 2;
    loader('Opening the Algorithms mode', 'Algo_main');
    try
        F = findall(0, 'type', 'figure', 'tag', 'loader');
        waitbar(1, F, 'Done!');
        close(F);
    catch ME
        disp(ME);
    end
    closereq(); 

    
% --- Executes on button press in demo_mode.
function demo_mode_Callback(hObject, eventdata, handles)
% hObject    handle to demo_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    % TODO: not yet support
    global switch_mode;
    switch_mode = 3;
