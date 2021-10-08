function load_reactive(hObject, eventdata, handles, method, algo )
%load_reactive Summary of this function goes here
%   Detailed explanation goes here
%     param_file_name = strcat(algo, '_params.m');
%     global main_path;
%     param_file = fullfile(main_path, '/Algorithms/Algo_Mode/', method, param_file_name);
    param_file_name = strcat(algo, '_params');
    params = eval(param_file_name);
    if params.num_params == 0
        return
    end
    for i=1:params.num_params
        if params.has_inter(i)
            set(eval(strcat('handles.Op_', num2str(i))), 'Enable', 'inactive');
        end
    end
    i = str2num(hObject.Tag(end));
    % Load interactiveness
    if params.has_inter(i)
        params2sysmodel(hObject, eventdata, handles, params, i);
    end
end