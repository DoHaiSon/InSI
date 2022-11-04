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

% Last Modified by GUIDE v2.5 04-Nov-2022 10:46:52

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
