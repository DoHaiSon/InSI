function varargout = CRB_main(varargin)
% CRB_main MATLAB code for CRB_main.fig
%      CRB_main, by itself, creates a new CRB_main or raises the existing
%      singleton*.
%
%      H = CRB_main returns the handle to a new CRB_main or the handle to
%      the existing singleton*.
%
%      CRB_main('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CRB_main.M with the given input arguments.
%
%      CRB_main('Property','Value',...) creates a new CRB_main or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CRB_main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CRB_main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CRB_main

% Last Modified by GUIDE v2.5 02-Dec-2021 17:02:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;

% Master timer
global time;

% Path of start.m file
global main_path;

gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CRB_main_OpeningFcn, ...
                   'gui_OutputFcn',  @CRB_main_OutputFcn, ...
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


% --- Executes just before CRB_main is made visible.
function CRB_main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CRB_main (see VARARGIN)
global main_path;
jFrame=get(handle(handles.figure1), 'javaframe');
jicon=javax.swing.ImageIcon(fullfile(main_path,'/Resource/Icon/main_icon.png'));
jFrame.setFigureIcon(jicon);

% Choose default command line output for CRB_main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
setappdata(0,'handles_main', handles)

% Set position for this GUI
movegui(hObject, 'center');

% UIWAIT makes CRB_main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CRB_main_OutputFcn(hObject, eventdata, handles) 
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
    path = openfile();
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


% --- Executes on button press in mode.
function mode_Callback(hObject, eventdata, handles)
% hObject    handle to mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    if (mode_questdlg())
        global results;
        results = Results;
        init_results();
        closereq(); 
        other_wins = findall(0);
        if (~ isempty(other_wins(1, 1).CurrentFigure))
            delete(other_wins);
        end
        mode();
    end


% --- Executes during object creation, after setting all properties.
function dataaxes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dataaxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate dataaxes

% --- Executes on button press in Blindbutton.
function Blindbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Blindbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%     Not support yet
%     CRB_Blind_Menu();


% --- Executes on button press in SBbutton.
function SBbutton_Callback(hObject, eventdata, handles)
% hObject    handle to SBbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    CRB_Semi_Blind_Menu();

    
% --- Executes on button press in Pilotbutton.
function Pilotbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Pilotbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    CRB_Non_Blind_Menu();

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

    if holdon_state
        global results;
        if(results.pre_mode ~= 2 && results.pre_mode ~= 0)
            results.mode = 2;
            dispfig(results.inter);
        end
    end

    if ~holdon_state && ~sub_fig_state
        global results;
        if(results.pre_mode ~= 1 && results.pre_mode ~= 0)
            results.mode = 1;
            dispfig(results.inter);
        end
    end


% --- Executes during object creation, after setting all properties.
function board_CreateFcn(hObject, eventdata, handles)
% hObject    handle to board (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate board
    global main_path;
    axesH = hObject;  % Not safe! Better get the handle explicitly!
    axis off;
    Position = hObject.Position;
    x_0 = Position(1);
    y_0 = Position(2);
    width = Position(3);
    height = Position(4);
    set(axesH, 'Tag', 'board');

    %get the GUI handles
    board = gcf;
    set(board, 'MenuBar', 'none');
    set(board, 'ToolBar', 'none');

    hfig = figure();
    set(hfig,'position', Position);

    [AVITECH_sample, ~, AVITECH_sample_alpha] = imread(fullfile(main_path, '/Resource/Icon/AVITECH.png'));
    [Orleans_sample, ~, Orleans_sample_alpha] = imread(fullfile(main_path, '/Resource/Icon/Orleans.png'));
    [Nafosted_sample, ~, Nafosted_sample_alpha] = imread(fullfile(main_path, '/Resource/Icon/Nafosted.png'));

    ax1 = subplot(3, 4, 1);
    text(0, 0, 0, 'InfoSysID Toolbox', 'Color', 'blue','FontSize', 20);
    ax1.Position = [x_0 + width / 3, y_0 + height/1.2, width / 5, height / 5];
    axis off;

    ax2 = subplot(3, 4, 5);
    image(AVITECH_sample, 'AlphaData', AVITECH_sample_alpha);
    ax2.Position = [x_0 + width / 25, y_0, width / 3.2, height / 3.2];
    axis off;
    ax3 = subplot(3, 4, 6);
    image(Orleans_sample, 'AlphaData', Orleans_sample_alpha);
    ax3.Position = [width / 2.4, y_0 + height / 15, width / 5, height / 5];
    axis off;
    ax4 = subplot(3, 4, 7);
    ax4.Position = [width / 1.5, y_0, width / 3, height / 3];
    image(Nafosted_sample, 'AlphaData', Nafosted_sample_alpha);
    axis off;
    
    ax = get(hfig,'children');
    %copy plotted subplots to the gui  
    copyobj(ax, board);
    close(hfig) % close the temporary figure


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

    if sub_fig_state
        global results;
        if(results.pre_mode ~= 3 && results.pre_mode ~= 0)
            results.mode = 3;
            dispfig(results.inter);
        end
    end

    if ~holdon_state && ~sub_fig_state
        global results;
        if(results.pre_mode ~= 1 && results.pre_mode ~= 0)
            results.mode = 1;
            dispfig(results.inter);
        end
    end
    
% --- Executes during object creation, after setting all properties.
function toolbox_ws_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toolbox_ws (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
%     set(hObject, 'ColumnName', {'Plot', 'Name', '$E_b$ / $N_o$ (dB)', 'BER', '# of Bits'});
    global toolboxws;
    toolboxws = {};
    set(hObject, 'Data', toolboxws);
    set(hObject, 'units','pixels');
%     Set columns width when init main window
    Postion = hObject.Position;
    x_total = Postion(3);
    x_plot = x_total / 20;
    x_name = x_total / 3;
    x_snr  = x_total / 4;
    x_err  = x_total / 3.1;
    set(hObject, 'ColumnWidth', {x_plot, x_name, x_snr, x_err});


% --- Executes when entered data in editable cell(s) in toolbox_ws.
function toolbox_ws_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to toolbox_ws (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
    hidden_line(hObject, eventdata, handles);
    


% --------------------------------------------------------------------
function Interpreter_Callback(hObject, eventdata, handles)
% hObject    handle to Interpreter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    


% --------------------------------------------------------------------
function inter_latex_Callback(hObject, eventdata, handles)
% hObject    handle to inter_latex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global results;
    if ~results.inter && results.figparams.count ~= 0
        % TODO: remove data instead of close recent figure
        close(results.fig);
%         output = figure('Name', 'CE', 'Tag', 'channel_estimation', 'visible','off');
        output = figure('Tag', 'channel_estimation', 'visible','off');
        results.fig = output;
        results.figaxes = axes;
        movegui(results.figaxes, results.pos);
        results.trigger = false;
        dispfig(true);
        results.inter = true;
    end

% --------------------------------------------------------------------
function inter_non_latex_Callback(hObject, eventdata, handles)
% hObject    handle to inter_non_latex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global results;
    if results.inter && results.figparams.count ~= 0
        % TODO: remove data instead of close recent figure
        close(results.fig);
%         output = figure('Name', 'CE', 'Tag', 'channel_estimation', 'visible','off');
        output = figure('Tag', 'channel_estimation', 'visible','off');
        results.fig = output;
        results.figaxes = axes;
        movegui(results.figaxes, results.pos);
        results.trigger = false;
        dispfig(false);
        results.inter = false;
    end
