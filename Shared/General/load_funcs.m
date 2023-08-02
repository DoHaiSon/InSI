function load_funcs(hObject, eventdata, handles, mode, method, algo)

%% ~ = load_funcs(hObject, eventdata, handles, mode, method, algo)
% Load current parameters in Menu, run the function, and export 
% results to figure and toolbox workspace.
%
%% Input:
    % 1. hObject: (hObject) - hObject of current GUI
    % 2. eventdata: (eventdata) - eventdata of current GUI
    % 3. handles: (handles) - handles of current GUI
    % 4. mode: (char) - current mode of toolbox 'Algo_Mode': 
    % Algorithm mode; 'CRB_Mode': CRB mode; 'Demo_Mode': Demo 
    % mode
    % 5. method: (char) - the selected method 'Non-blind': None-blind;
    % 'Semi-blind': Semi-blind; 'Blind': Blind;
    % 'Side-information': Side-information; 'Informed': Informed
    % 6. algo: (char) - the name of selected algorithm
%
%% Output: None
%
%% Require R2006A
%
% Author: Do Hai Son, Vietnam National University, Hanoi, Vietnam

% Last modified by Do Hai Son, 30-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless Communications
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


global main_path;
param_file_name = strcat(algo, '_params');
params = eval(param_file_name);

if params.num_params == 0
    return
end

Monte   = str2num(get(handles.Monte, 'String'));
SNR     = str2num(get(handles.SNR, 'String'));

all_output_types = {'SER', 'BER', 'MSE Sig', 'MSE H', 'CRB'};

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
        for i=1:4
            if get(eval(strcat('handles.output', num2str(i))), 'Value') == 1 
                Output_type  = i;
                break;
            end
        end
        if strcmp(get(handles.btngroup, 'Visible'), 'off')
            Output_type = 5;
        end
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

% Declear the InSI_waitbar to update the progress
global InSI_waitbar; 

% The main function
xaxis = [];
try
    ER_f = {};
    for Monte_i = 1:Monte

        ER_SNR      = {};

        for SNR_i   = SNR
            tic

            try
                [xaxis, Err_i] = eval(strcat(algo, '(Op, SNR_i, Output_type)'));
            catch
                Err_i = eval(strcat(algo, '(Op, SNR_i, Output_type)'));
            end

            ER_SNR{end+1} = Err_i;

            if(getappdata(InSI_waitbar, 'canceling'))
                delete(InSI_waitbar);
                return
            end
            
            % Estimate the progress bar
            portion = ((Monte_i-1) * length(SNR) + find(SNR == SNR_i)) / (Monte * length(SNR));
            % Estimate the remaining time
            running_time = toc;
            remain_time = ((Monte * length(SNR)) - ((Monte_i-1) * length(SNR) + find(SNR == SNR_i))) * running_time;
    
            waitbar(portion * 0.89 + 0.1, InSI_waitbar, sprintf('Progress: %3.1f %%, \n Remaining time: %5.2f seconds.', [(portion * 0.89 + 0.1) * 100 remain_time]));
        end

        ER_f{end+1} = ER_SNR;
    end
    
    % Return
    ER_f = parse_outputs(ER_f);
    try
        if params.n_outputs > 1
            for n=1:params.n_outputs
                ER_f_n = ER_f{n}.';
                if Monte ~= 1
                    Err{n} = mean(ER_f_n);
                else
                    Err{n} = ER_f_n;
                end
            end
        end
    catch
        if Monte ~= 1
            Err = mean(ER_f);
        else
            Err = ER_f;
        end
    end

    % Close the progress bar
    waitbar(1, InSI_waitbar, sprintf('Done!'));
    pause(.3);
    delete(InSI_waitbar);
catch ME
    disp(ME);
    % Close the progress bar
    waitbar(1, InSI_waitbar, sprintf('Done!'));
    pause(.3);
    delete(InSI_waitbar);

    return
end

runtime = datetime('now') - InSI_time;
        
%% Figure result
global configs;
global results;         % Be careful 

% Define Figure params
results.figparams.count = results.figparams.count + 1;
if isempty(xaxis)
    results.figparams.data(results.figparams.count).x = SNR;
else
    results.figparams.data(results.figparams.count).x = xaxis;
end
results.figparams.data(results.figparams.count).y = Err;

% Load figure title
results.figparams.title{end+1} = load_title(algo);

switch mode
    case 'CRB_Mode'
        
        results.figparams.xlabel{end+1} = params.xlabel;
        results.figparams.ylabel{end+1} = params.ylabel;
    otherwise
        try
            results.figparams.xlabel{end+1} = params.xlabel(Output_type);
            results.figparams.ylabel{end+1} = params.ylabel(Output_type);
        catch
            results.figparams.xlabel{end+1} = params.xlabel;
            results.figparams.ylabel{end+1} = params.ylabel;
        end
end
results.figparams.gridmode = 'on';

% Random marker
all_marks = {'o','+','*','.','x','s','d','^','v','>','<','p','h'};
results.figparams.marker{end + 1} = ['-' all_marks{randi(length(all_marks))}];
results.Output_type = Output_type;
try
    if params.n_outputs > 1
        results.figparams.legends{end + 1} = params.legends;
    end
catch
    results.figparams.legends{end + 1} = parseleg(mode, algo);
end
results.figparams.fig_visible(end + 1) = true;
results.figparams.output_types(end + 1) = Output_type;

% GUI to WS
for i = 1:params.num_params
    eval([algo '.' params.notations{i} '= Op{i};']);
end
eval([algo '.SNR' '= SNR;']);
eval([algo '.Err' '= Err;']);
eval([algo '.Monte' '= Monte;']);

ws_index = -1;
for i = 1:results.figparams.count
    try
        if strcmp(results.figparams.title{end}, results.figparams.title{i})
            ws_index = ws_index + 1;
        end
    catch ME
        disp(ME);
    end
end
if ws_index == 0
    ws_name  = algo;
else
    ws_name  = [algo '_' num2str(ws_index)];
end

GUI2WS(ws_name, eval(algo));

% Check figure mode: Clear/hold on/subfigure
% Load system model
handles_main = getappdata(0,'handles_main');

if (results.pre_output == 2 && results.mode == 2)
    results.trigger = true;
end

% If user changed the output type, we force change the fig mode 
% to subfig
if (results.pre_output ~= Output_type && results.pre_output ~= 0)
    set(handles_main.figmode_1, configs.UI_container_Menu, ' Single');
    set(handles_main.figmode_2, configs.UI_container_Menu, ' Combine');
    set(handles_main.figmode_3, configs.UI_container_Menu, 'x Separate');
    results.mode = 3;
end

if ~strcmp(mode, 'CRB_Mode')
    for i=1:4
        if get(eval(strcat('handles.output', num2str(i))), 'Value') == 1 
            Output_type  = i;
            break;
        end
    end
    if Output_type == 4
        Output_type = 1;
    end
end

%% Display figure
dispfig(true);

if ~strcmp(mode, 'CRB_Mode')
    for i=1:4
        if get(eval(strcat('handles.output', num2str(i))), 'Value') == 1 
            Output_type  = i;
            break;
        end
    end
end

%% Store pre output mode
results.pre_output = Output_type;

%% Export data to Toolbox Workspace
global toolboxws;

name_ws = algo;
for i = 1:params.num_params
    switch get(eval(strcat('handles.Op_', num2str(i))), 'Style')
        case 'edit'
            name_ws = strcat([name_ws ' ' params.notations{i}], ...
                '=', num2str(get(eval(strcat('handles.Op_', num2str(i))), 'String')));
        case 'popupmenu'
            list_values = params.values{i};
            if iscell(list_values)
                name_ws = strcat([name_ws ' ' params.notations{i}], ...
                    '=', list_values{Op{i}});
            else
                name_ws = strcat([name_ws ' ' params.notations{i}], ...
                    '=', list_values);
            end
        case 'togglebutton'
            name_ws = strcat([name_ws ' ' params.notations{i}], ...
                '=', num2str(get(eval(strcat('handles.Op_', num2str(i))), 'Value')));
    end
end

switch(results.mode)
    case 1
        results.figparams.fig_visible(end - 1) = false;
    case 2

    case 3
end

switch (mode)
    case 'Algo_Mode' 
        toolboxws = [toolboxws; {true, name_ws, all_output_types{Output_type}, datestr(runtime, 'HH:MM:SS')}];
    case 'CRB_Mode'
        toolboxws = [toolboxws; {true, name_ws, datestr(runtime, 'HH:MM:SS')}];
    case 'Demo_Mode'
        toolboxws = [toolboxws; {true, name_ws, all_output_types{Output_type}, datestr(runtime, 'HH:MM:SS')}];
end

% Modify toolboxws option here
if (results.figparams.count ~= 1)
    for i = 1:length(results.figparams.fig_visible)
        toolboxws{i, 1} = [logical(results.figparams.fig_visible(i))];
    end
end
set(handles_main.toolbox_ws, 'Data', toolboxws);

end