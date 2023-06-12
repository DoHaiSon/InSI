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

% Last Modified by GUIDE v2.5 04-Jun-2023 00:24:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;

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
    jFrame=get(handle(handles.InSI_C), 'javaframe');
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
    % uiwait(handles.InSI_C);


% --- Outputs from this function are returned to the command line.
function varargout = CRB_main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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
    [msgicon, iconcmap] = imread('about.png');
    hm = msgbox({'InSI Toolbox v1.2.0.'; 'Copyright 2023 @ AVITECH-UET, PRISME-Orleans.'}, 'About', 'custom', msgicon, iconcmap);
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
        InSI_mode();
    end


% --- Executes during object creation, after setting all properties.
function dataaxes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dataaxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes on button press in Blindbutton.
function Blindbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Blindbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    CRB_Blind_Menu();


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


% --- Executes during object creation, after setting all properties.
function board_CreateFcn(hObject, eventdata, handles)
% hObject    handle to board (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

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

    [AVITECH_sample, ~, AVITECH_sample_alpha]   = imread(fullfile(main_path, '/Resource/Icon/AVITECH.png'));
    [Orleans_sample, ~, Orleans_sample_alpha]   = imread(fullfile(main_path, '/Resource/Icon/Orleans.png'));
    [Nafosted_sample, ~, Nafosted_sample_alpha] = imread(fullfile(main_path, '/Resource/Icon/Nafosted.png'));
    [PRIMSE_sample, ~, PRIMSE_sample_alpha]     = imread(fullfile(main_path, '/Resource/Icon/PRISME.png'));
    [M3_sample, ~, M3_sample_alpha]             = imread(fullfile(main_path, '/Resource/Icon/Viettel_M3.png'));
    [UET_sample, ~, UET_sample_alpha]           = imread(fullfile(main_path, '/Resource/Icon/VNU_UET.png'));

    ax1 = subplot(6, 6, 1);
    image(UET_sample, 'AlphaData', UET_sample_alpha);
    ax1.Position = [x_0 + width / 4, y_0 + height / 4, width /5, height /4.3];
    axis off;
    ax2 = subplot(6, 6, 2);
    image(Orleans_sample, 'AlphaData', Orleans_sample_alpha);
    ax2.Position = [x_0 + width / 1.9, y_0 + height / 4, width /5, height / 5];
    axis off;
    ax3 = subplot(6, 6, 3);
    image(AVITECH_sample, 'AlphaData', AVITECH_sample_alpha);
    ax3.Position = [x_0, y_0, width / 4.2, height / 4.2];
    axis off;
    ax4 = subplot(6, 6, 4);
    image(PRIMSE_sample, 'AlphaData', PRIMSE_sample_alpha);
    ax4.Position = [x_0 + width / 4, y_0, width / 4.2, height / 4.2];
    axis off;
    ax5 = subplot(6, 6, 5);
    image(M3_sample, 'AlphaData', M3_sample_alpha);
    ax5.Position = [x_0 + width / 2.1, y_0, width / 4.2, height / 4.2];
    axis off;
    ax6 = subplot(6, 6, 6);
    image(Nafosted_sample, 'AlphaData', Nafosted_sample_alpha);
    ax6.Position = [width / 1.3, y_0, width / 4.2, height / 4.2];
    axis off;
    
    ax = get(hfig,'children');
    %copy plotted subplots to the gui  
    copyobj(ax, board);
    close(hfig) % close the temporary figure

    
% --- Executes during object creation, after setting all properties.
function toolbox_ws_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toolbox_ws (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits', 'Normalized');
    set(hObject, 'FontSize', 0.0969044414483497);

    set(hObject, 'ColumnName', {'Plot', 'Name', 'Run time'});
    global toolboxws;
    toolboxws = {};
    set(hObject, 'Data', toolboxws);
    set(hObject, 'units','pixels');

    set(hObject.Parent, 'units','pixels');
    [x, y, w, h] = scale_InSI(hObject.Parent);
    set(hObject.Parent, 'Position', [x, y, w, h]);

    Position_p = hObject.Parent.Position;
    set(hObject, 'Position', [0, 0, Position_p(3), Position_p(4)/4]);
%     Set columns width when init main window
    Postion = hObject.Position;
    x_total = Postion(3);
    x_plot     = x_total / 19;
    x_name     = x_total / 1.3;
    x_runtime  = x_total / 7;
    set(hObject, 'ColumnWidth', {x_plot, x_name, x_runtime});


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

    hide_line(hObject);
    

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

    global configs;
    global results;
    if ~results.inter && results.figparams.count ~= 0
        % TODO: remove data instead of close recent figure
        close(results.fig);
%         output = figure('Name', 'CE', 'Tag', 'channel_estimation', 'visible','off');
        output = figure('Tag', 'InSI_Figure', 'visible','off');
        results.fig = output;
        results.figaxes = axes;
        movegui(results.figaxes, results.pos);
        results.trigger = false;
        set(hObject, configs.UI_container_Menu, 'x Latex');
        set(handles.inter_non_latex, configs.UI_container_Menu, '  Normal');
        dispfig(true);
        results.inter = true;
    end

% --------------------------------------------------------------------
function inter_non_latex_Callback(hObject, eventdata, handles)
% hObject    handle to inter_non_latex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    global configs;
    global results;
    if results.inter && results.figparams.count ~= 0
        % TODO: remove data instead of close recent figure
        close(results.fig);
%         output = figure('Name', 'CE', 'Tag', 'channel_estimation', 'visible','off');
        output = figure('Tag', 'InSI_Figure', 'visible','off');
        results.fig = output;
        results.figaxes = axes;
        movegui(results.figaxes, results.pos);
        results.trigger = false;
        set(handles.inter_latex, configs.UI_container_Menu, '  Latex');
        set(hObject, configs.UI_container_Menu, 'x Normal');
        dispfig(false);
        results.inter = false;
    end


% --------------------------------------------------------------------
function modtool_nav_Callback(hObject, eventdata, handles)
% hObject    handle to modtool_nav (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    modtool();


% --------------------------------------------------------------------
function Figure_options_Callback(hObject, eventdata, handles)
% hObject    handle to Figure_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function figmode_1_Callback(hObject, eventdata, handles)
% hObject    handle to figmode_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    global configs;
    global results;
    if(results.pre_mode ~= 1 && results.pre_mode ~= 0 && results.figparams.count > 0)
        results.mode = 1;
        % Set WS values
        % Get plot options
        ws_op = get(handles.toolbox_ws, 'Data');
        plot_op = [ws_op{:, 1}];
        last_true_i = find(plot_op, true, 'last');
        plot_op_new = false(1, length(plot_op));
        plot_op_new(1, last_true_i) = true;
        for i=1:length(plot_op_new)
            handles.toolbox_ws.Data{i, 1} = [plot_op_new(i)];
        end
        
        results.figparams.fig_visible = plot_op_new;
        set(hObject, configs.UI_container_Menu, 'x Single');
        set(handles.figmode_2, configs.UI_container_Menu, ' Combine');
        set(handles.figmode_3, configs.UI_container_Menu, ' Separate');
        dispfig(results.inter);
    end

    
% --------------------------------------------------------------------
function figmode_2_Callback(hObject, eventdata, handles)
% hObject    handle to figmode_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    global configs;
    global results;
    if(results.pre_mode ~= 2 && results.pre_mode ~= 0 && results.figparams.count > 0)
        results.mode = 2;
        set(handles.figmode_1, configs.UI_container_Menu, ' Single');
        set(hObject, configs.UI_container_Menu, 'x Combine');
        set(handles.figmode_3, configs.UI_container_Menu, ' Separate');
        dispfig(results.inter);
    end


% --------------------------------------------------------------------
function figmode_3_Callback(hObject, eventdata, handles)
% hObject    handle to figmode_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    global configs;
    global results;
    if(results.pre_mode ~= 3 && results.pre_mode ~= 0 && results.figparams.count > 0)
        results.mode = 3;
        set(handles.figmode_1, configs.UI_container_Menu, ' Single');
        set(handles.figmode_2, configs.UI_container_Menu, ' Combine');
        set(hObject, configs.UI_container_Menu, 'x Separate');
        dispfig(results.inter);
    end


% --- Executes during object creation, after setting all properties.
function selectmodel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selectmodel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.0399502876390316);
    

% --- Executes during object creation, after setting all properties.
function Blindbutton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Blindbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.24413362617038498);


% --- Executes during object creation, after setting all properties.
function SBbutton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SBbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.24413362617038498);


% --- Executes during object creation, after setting all properties.
function Pilotbutton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pilotbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.24413362617038498);


% --- Executes during object creation, after setting all properties.
function mode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    
    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.33198743829527205);


% --- Executes during object creation, after setting all properties.
function board_title_CreateFcn(hObject, eventdata, handles)
% hObject    handle to board_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'FontUnits','normalized');
    set(hObject, 'FontSize', 0.5882352941176471);


% --------------------------------------------------------------------
function bug_report_Callback(hObject, eventdata, handles)
% hObject    handle to bug_report (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    web('https://github.com/DoHaiSon/InSI/issues/new/choose', '-browser');


% --------------------------------------------------------------------
function LICENSE_Callback(hObject, eventdata, handles)
% hObject    handle to LICENSE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % // TODO: Load from .md file
    web('https://github.com/DoHaiSon/InSI/blob/master/LICENSE', '-browser');
