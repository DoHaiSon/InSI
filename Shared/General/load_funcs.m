function load_funcs(hObject, eventdata, handles, mode, method, algo)

%% ~ = load_funcs(hObject, eventdata, handles, mode, method, algo)
% Load current parameters in Menu, run the function, and export results to
% figure and toolbox workspace.
%
%% Input:
    % 1. hObject: (hObject) - hObject of current GUI
    % 2. eventdata: (eventdata) - eventdata of current GUI
    % 3. handles: (handles) - handles of current GUI
    % 4. mode: (char) - current mode of toolbox 'Algo_Mode': Algorithm mode; 'CRB_Mode': CRB mode;
    % 'Demo_Mode': Demo mode
    % 5. method: (char) - the selected method 'Non-blind': None-blind;
    % 'Semi-blind': Semi-blind; 'Blind': Blind
    % 6. algo: (char) - the name of selected algorithm
%
%% Output: None
%
%% Require R2006A
%
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 20-Apr-2023 17:52:13 

global main_path;
param_file_name = strcat(algo, '_params');
params = eval(param_file_name);

if params.num_params == 0
    return
end

Monte   = str2num(get(handles.Monte, 'String'));
SNR     = str2num(get(handles.SNR, 'String'));

% Load output panel
switch (mode)
    case 'Algo_Mode'
        for i=1:4
            if get(eval(strcat('handles.output', num2str(i))), 'Value') == 1 
                Output_type  = i;
                break;
            end
        end
    case 'CRB_Mode'
        Output_type = 1;
    case 'Demo_Mode'
end

% Get UIClass and value of params
    % Type of the UIControl: edit_text   = 1
    %                        popup_menu  = 2
    %                        toggle      = 3
Op = {};
for i = 1:params.num_params
    switch (params.params_type(i))
        case 1
            Op{end + 1} = str2num(get(eval(strcat('handles.Op_', num2str(i))), 'String'));
        case 2
            Op{end + 1} = get(eval(strcat('handles.Op_', num2str(i))), 'Value');
        case 3
            Op{end + 1} = get(eval(strcat('handles.Op_', num2str(i))), 'Value');
    end
end

global InSI_time;
InSI_time = datetime('now');

%% Exec algorithm
loader('Execute function');
switch (mode)
    case 'Algo_Mode'
        [SNR, Err] = eval(strcat(algo, '(Op, Monte, SNR, Output_type)'));
    case 'CRB_Mode'
        [SNR, Err] = eval(strcat(algo, '(Op, Monte, SNR)'));
    case 'Demo_Mode'
end

runtime = datetime('now') - InSI_time;

try
    F = findall(0, 'type', 'figure', 'tag', 'loader');
    waitbar(1, F, 'Done!');
    close(F);
catch ME
    disp(ME);
end
        
%% Figure result
global results;         % Be careful 
    
% GUI to WS
GUI2WS(SNR);
GUI2WS(Err);

% Define Figure params
results.figparams.count = results.figparams.count + 1;
results.figparams.data(results.figparams.count).x = SNR;
results.figparams.data(results.figparams.count).y = Err;

% Load figure title
results.figparams.title{end+1} = load_title(algo);

switch mode
    case 'CRB_Mode'
        
        results.figparams.xlabel{end+1} = params.xlabel;
        results.figparams.ylabel{end+1} = params.ylabel;
    otherwise
        results.figparams.xlabel{end+1} = params.xlabel(Output_type);
        results.figparams.ylabel{end+1} = params.ylabel(Output_type);
end
results.figparams.gridmode = 'on';

% Random marker
all_marks = {'o','+','*','.','x','s','d','^','v','>','<','p','h'};
results.figparams.marker{end + 1} = ['-' all_marks{randi(length(all_marks))}];
results.Output_type = Output_type;
results.figparams.legends{end + 1} = parseleg(mode, algo);
results.figparams.fig_visible(end + 1) = true;

% Check figure mode: Clear/hold on/subfigure
% Load system model
handles_main = getappdata(0,'handles_main');

if (results.pre_output == 2 && results.mode == 2)
    results.trigger = true;
end

% If user changed the output type, we force change the fig mode to
% subfig
if (results.pre_output ~= Output_type && results.pre_output ~= 0)
    results.mode = 3;
end

%% Display figure
dispfig(true);

%% Store pre output mode
results.pre_output = Output_type;

%% Export data to Toolbox Workspace
global toolboxws;

name_ws = algo;
for i = 1:params.num_params
    switch get(eval(strcat('handles.Op_', num2str(i))), 'Style')
        case 'edit'
            name_ws = strcat(name_ws, '_', get(eval(strcat('handles.Text_', num2str(i))), 'String'), ...
                '_', num2str(get(eval(strcat('handles.Op_', num2str(i))), 'String')));
        case 'popupmenu'
            name_ws = strcat(name_ws, '_', get(eval(strcat('handles.Text_', num2str(i))), 'String'), ...
                '_', num2str(get(eval(strcat('handles.Op_', num2str(i))), 'Value')));
        case 'togglebutton'
            name_ws = strcat(name_ws, '_', get(eval(strcat('handles.Text_', num2str(i))), 'String'), ...
                '_', num2str(get(eval(strcat('handles.Op_', num2str(i))), 'Value')));
    end
end

switch(results.mode)
    case 1
        results.figparams.fig_visible(end - 1) = false;
        toolboxws = [toolboxws; {true, name_ws, datestr(runtime, 'HH:MM:SS')}];
    otherwise
        toolboxws = [toolboxws; {true, name_ws, datestr(runtime, 'HH:MM:SS')}];
end

% Modify toolboxws option here
if (results.figparams.count ~= 1)
    for i = 1:length(results.figparams.fig_visible)
        toolboxws{i, 1} = [logical(results.figparams.fig_visible(i))];
    end
end
set(handles_main.toolbox_ws, 'Data', toolboxws);

end