function load_funcs(hObject, eventdata, handles, method, algo )

    % Get handes form main window
    handles_main = getappdata(0,'handles_main');
    
    param_file_name = strcat(algo, '_params');
    params = eval(param_file_name);
    if params.num_params == 0
        return
    end
    
    Monte   = str2num(get(handles.Monte, 'String'));
    SNR     = str2num(get(handles.SNR, 'String'));
    for i=1:3
        if get(eval(strcat('handles.output', num2str(i))), 'Value') == 1 
            Output_type  = i;
            break;
        end
    end
    Op = {};
    for i = 1:params.num_params
        Op{end + 1} = get(eval(strcat('handles.Op_', num2str(i))), 'Value');
    end
    
    %% Exec algorithm
    loader('Execute function');
    [SNR, Err] = eval(strcat(algo, '(Op, Monte, SNR, Output_type)'));
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
    results.figparams.title = 'Channel estimation';
    results.figparams.xlabel = 'SNR(dB)';
    results.figparams.ylabel = 'SER';
    results.figparams.gridmode = 'on';
    results.figparams.marker = '-o';
    results.figparams.legends{end + 1} = parseleg(algo);
    
    % Check figure mode: Clear/hold on/subfigure
    mode = checkfigmode(handles_main);
    switch(mode)
        case 1
            %clear old figure
            cla(results.figaxes, 'reset');
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
    toolboxws = [toolboxws; [{true, title_toolboxes, matrix2char(results.figparams.data(results.figparams.count).x), ...
        matrix2char(results.figparams.data(results.figparams.count).y), ...
        Op{1}}]];
    set(handles_main.toolbox_ws, 'Data', toolboxws);
end