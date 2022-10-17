function load_params(hObject, eventdata, handles, mode, method, algo )
%load_params Summary of this function goes here
%   Detailed explanation goes here
    global main_path;
    param_file_name = strcat(algo, '_params');
    global params;
    params = eval(param_file_name);
    
    global pre_algo;
    if ( ~ strncmp(pre_algo, param_file_name, length(param_file_name)) )
        trigger_scale = true;
        pre_algo = param_file_name;
    else
        trigger_scale = false;
    end

    if params.num_params == 0
        return
    end
    
    set(handles.panelparams, 'Visible', 'on');
    
    % Turn off unuse params
    if params.num_params < 10
        for i=10:-1:params.num_params + 1
            set(eval(strcat('handles.Text_', num2str(i))), 'Visible', 'off');
            set(eval(strcat('handles.Op_', num2str(i))), 'Visible', 'off');
        end
    end
    
    % Set texts for using params
    for i=1:params.num_params
        set(eval(strcat('handles.Text_', num2str(i))), 'String', params.params{i});
    end
    
    % Set UIClass and default value for using params
        % Type of the UIControl: edit_text   = 1
        %                        popup_menu  = 2
        %                        button      = 3
    for i=1:params.num_params
        switch (params.params_type(i))
            case 1
                set(eval(strcat('handles.Op_', num2str(i))), 'Style', 'edit');
                set(eval(strcat('handles.Op_', num2str(i))), 'Enable', 'on');
                
                % Set default values for using params
                set(eval(strcat('handles.Op_', num2str(i))), 'String', params.default_values{i});
            case 2
                set(eval(strcat('handles.Op_', num2str(i))), 'Style', 'popupmenu');
                % Scale droplist box
                if (trigger_scale)
                    set(eval(strcat('handles.Op_', num2str(i))), 'units','pixels');
                    old_pos    = get(eval(strcat('handles.Op_', num2str(i))), 'Position');
                    if (old_pos(3) <= 60)
                        new_pos    = old_pos;
                        new_pos(1) = old_pos(1) - old_pos(3)/2;
                        new_pos(3) = old_pos(3) * 2;
                        set(eval(strcat('handles.Op_', num2str(i))), 'Position', new_pos);
                    end
                end

                % Set default values for using params
                set(eval(strcat('handles.Op_', num2str(i))), 'String', params.values{i});
                set(eval(strcat('handles.Op_', num2str(i))), 'Value', params.default_values{i});
            case 3
                set(eval(strcat('handles.Op_', num2str(i))), 'Style', 'pushbutton');
        end
    end

    % Load default SNR range and the number of monte
    set(handles.Monte, 'String', params.default_Monte);
    set(handles.SNR, 'String', params.default_SNR);
    
    % Load system model
    handles_main = getappdata(0, 'handles_main');
    axesH        = handles_main.board;  % Not safe! Better get the handle explicitly!

    releasesysmodel();

    img          = imread(fullfile(main_path, '/Resource/Dashboard', params.sys_model));
    imshow(img, 'Parent', axesH);
    
    % Load interactiveness
    for i=1:params.num_params
        if params.has_inter(i)
            set(eval(strcat('handles.Op_', num2str(i))), 'Enable', 'inactive');
        end
    end
    
    % Load output panel
    switch (mode)
        case 'Algo_Mode'
            set(handles.btngroup, 'Visible', 'on');
            if length(params.outputs) ~= 3
               for i=1:3
                   if any(params.outputs(:) == i)
                       set(eval(strcat('handles.output', num2str(i))), 'Enable', 'on');
                   else
                       set(eval(strcat('handles.output', num2str(i))), 'Enable', 'off');
                   end
               end
            end
            set(eval(strcat('handles.output', num2str(params.default_output))), 'Value', 1);
        case 'CRB_Mode'
        case 'Demo_Mode'
    end
end