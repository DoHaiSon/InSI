function load_funcs(hObject, eventdata, handles, mode, method, algo )
%load_funcs Summary of this function goes here
%   Detailed explanation goes here
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
            for i=1:3
                if get(eval(strcat('handles.output', num2str(i))), 'Value') == 1 
                    Output_type  = i;
                    break;
                end
            end
        case 'CRB_Mode'
        case 'Demo_Mode'
    end
    
    % Get UIClass and value of params
        % Type of the UIControl: edit_text   = 1
        %                        popup_menu  = 2
        %                        button      = 3
    Op = {};
    for i = 1:params.num_params
        switch (params.params_type(i))
            case 1
                Op{end + 1} = str2num(get(eval(strcat('handles.Op_', num2str(i))), 'String'));
            case 2
                Op{end + 1} = get(eval(strcat('handles.Op_', num2str(i))), 'Value');
            case 3
        end
    end
    
    %% Exec algorithm
    loader('Execute function');
    switch (mode)
        case 'Algo_Mode'
            [SNR, Err] = eval(strcat(algo, '(Op, Monte, SNR, Output_type)'));
        case 'CRB_Mode'
            [SNR, Err] = eval(strcat(algo, '(Op, Monte, SNR)'));
        case 'Demo_Mode'
    end
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
%     TODO: Dynamic load these params
    switch mode
        case 'CRB_Mode'
            results.figparams.title = 'Performance bound';
            results.figparams.ylabel = 'CRB';
        otherwise
            results.figparams.title = 'Channel estimation';
            results.figparams.ylabel = 'BER';
    end
    results.figparams.xlabel = 'SNR(dB)';
    results.figparams.gridmode = 'on';
    results.figparams.marker = '-o';
    results.figparams.legends{end + 1} = parseleg(mode, algo);
    
    % Check figure mode: Clear/hold on/subfigure
    % Load system model
    handles_main = getappdata(0,'handles_main');
    
    fig_mode = checkfigmode(handles_main);
    switch(fig_mode)
        % TODO: switch from mode 3 to 1 is error in cla func: multi subfig
        case 1
            %clear old figure
%             cla(results.figaxes, 'reset');
            results.figparams.count = 0;
            results.mode = 1;
        case 2
            results.mode = 2;
        case 3
            results.mode = 3;
        otherwise
    end
    %% Display figure
    dispfig(true);
    
    %% Export data to Toolbox Workspace
    global toolboxws;
    title_toolboxes = algo;
    for i = 1:params.num_params
        title_toolboxes = strcat(title_toolboxes, '_', get(eval(strcat('handles.Text_', num2str(i))), 'String'), ...
            '_', num2str(get(eval(strcat('handles.Op_', num2str(i))), 'Value')));
    end
    switch(fig_mode)
        case 1
            toolboxws = [toolboxws; [{true, title_toolboxes, matrix2char(results.figparams.data(1).x), ...
                matrix2char(results.figparams.data(1).y), ...
                Op{1}}]];
        otherwise
            switch mode
                case 'CRB_Mode'
                    toolboxws = [toolboxws; [{true, title_toolboxes, matrix2char(results.figparams.data(results.figparams.count).x), ...
                        matrix2char(results.figparams.data(results.figparams.count).y)}]];
                otherwise
                    toolboxws = [toolboxws; [{true, title_toolboxes, matrix2char(results.figparams.data(results.figparams.count).x), ...
                        matrix2char(results.figparams.data(results.figparams.count).y), ...
                        Op{1}}]];
            end
    end
    set(handles_main.toolbox_ws, 'Data', toolboxws);
end