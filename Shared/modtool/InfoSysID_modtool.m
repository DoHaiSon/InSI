function InfoSysID_modtool(mode, model, name, num_params, params, params_type, values, default_values, outputs)
%InfoSysID_modtool Summary of this function goes here
%
%Input 
% mode  (int): CRB / Algo / DEMO
% model (str): Blind / Semi-blind / Non-blind
% name  (str): name of the new module
% num_params (int): number of input params
% params (cell): names of input params 
% params_type (array): interface types of input params
% values (cell): values of input params
% default_values (cell): default value of input params
% outputs(array): SER / BER / MSE H 
% 
%Output:
% New module in the InfoSysID toolbox
%
%% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
%% Last Modified by Son 2-Nov-2022 12:52:13 
    
    %% Declear const variables
    model_value = {'B', 'SB', 'NB'};
    model_key   = {'Blind', 'Semi-blind', 'Non-blind'};
    model_dict  = containers.Map(model_key, model_value);

    params_value  = [5, 13, 16, 13, 9, 14, 9, 17, 10, 8, 12, 16, 17, 13];
    params_key    = {'flag', 'function_main', 'function_params', 'num_params', 'params', 'params_type', 'values', 'default_values', ...
        'outputs', 'title', 'has_inter', 'rect_position', 'rect_linewidth', 'rect_color'};
    params_set    = containers.Map(params_key, params_value);

    global main_path;
    switch mode
        case 1  %% CRB Mode
            %% Read template file
            template_dir    = fullfile(main_path, '/Shared/modtool/Template/CRB_Mode');
            function_main   = fileread(fullfile(template_dir, 'function_main.m'), Encoding='UTF-8');
            function_params = fileread(fullfile(template_dir, 'Params', 'function_params.m'), Encoding='UTF-8');

            %% Modify the template file
            %%% function_main file
            % Function name
            ind = strfind(function_main, 'function_main');
            function_main_tmp1   = function_main(1:ind-1);
            function_main_tmp2   = function_main(ind + params_set('function_main'):end);
            tmp                  = strcat(model_dict(model), '_', name);
            function_main        = [function_main_tmp1 ' ' tmp function_main_tmp2];

            % Find the flag index
            ind = strfind(function_main, 'flag');
            function_main_tmp1   = function_main(1:ind-1);
            function_main_tmp2   = function_main(ind + params_set('flag'):end);
            tmp = ['' newline];
            for i=1:num_params
                tmp = [tmp strcat('var_', num2str(i), ' = Op{', num2str(i), '};') ' % ' params{i} newline];
            end
            function_main      = [function_main_tmp1 ' ' tmp function_main_tmp2];

            %%% function_params file
            % Class name
            ind = strfind(function_params, 'function_params');
            function_params_tmp1 = function_params(1:ind-1);
            function_params_tmp2 = function_params(ind + params_set('function_params'):end);
            tmp                  = strcat(model_dict(model), '_', name, '_params');
            function_params      = [function_params_tmp1 ' ' tmp function_params_tmp2];

            % num_params
            ind = strfind(function_params, 'num_params');
            function_params_tmp1 = function_params(1:ind + params_set('num_params'));
            function_params_tmp2 = function_params(ind + params_set('num_params'):end);
            function_params      = strcat(function_params_tmp1, num2str(num_params), function_params_tmp2);

            % params
            ind = strfind(function_params, 'params');
            function_params_tmp1 = function_params(1:ind(3) + params_set('params'));
            function_params_tmp2 = function_params(ind(3) + params_set('params'):end);
            tmp                  = cell2char(params);
            function_params      = strcat(function_params_tmp1, tmp, function_params_tmp2);

            % params_type
            ind = strfind(function_params, 'params_type');
            function_params_tmp1 = function_params(1:ind + params_set('params_type'));
            function_params_tmp2 = function_params(ind + params_set('params_type'):end);
            tmp                  = arr2char(params_type);
            function_params      = strcat(function_params_tmp1, tmp, function_params_tmp2);

            % values
            ind = strfind(function_params, 'values');
            function_params_tmp1 = function_params(1:ind + params_set('values'));
            function_params_tmp2 = function_params(ind + params_set('values'):end);
            tmp                  = cell2char(values);
            function_params      = strcat(function_params_tmp1, tmp, function_params_tmp2);

            % default_values
            ind = strfind(function_params, 'default_values');
            function_params_tmp1 = function_params(1:ind + params_set('default_values'));
            function_params_tmp2 = function_params(ind + params_set('default_values'):end);
            tmp                  = cell2char(default_values);
            function_params      = strcat(function_params_tmp1, tmp, function_params_tmp2);

            % title
            ind = strfind(function_params, 'title');
            function_params_tmp1 = function_params(1:ind + params_set('title'));
            function_params_tmp2 = function_params(ind + params_set('title'):end);
            title                = strcat(model_dict(model), '_', name);
            function_params      = strcat(function_params_tmp1, '{''', title, '''}', function_params_tmp2);

            % has_inter
            ind = strfind(function_params, 'has_inter');
            function_params_tmp1 = function_params(1:ind + params_set('has_inter'));
            function_params_tmp2 = function_params(ind + params_set('has_inter'):end);
            tmp = '[';
            for i=1:num_params - 1
                tmp = strcat(tmp, 'false, ');
            end
            tmp = strcat(tmp, 'false]');
            function_params      = strcat(function_params_tmp1, tmp, function_params_tmp2);

            % rect_position
            ind = strfind(function_params, 'rect_position');
            function_params_tmp1 = function_params(1:ind + params_set('rect_position'));
            function_params_tmp2 = function_params(ind + params_set('rect_position'):end);
            tmp = '{';
            for i=1:num_params - 1
                tmp = strcat(tmp, '0, ');
            end
            tmp = strcat(tmp, '0}');
            function_params      = strcat(function_params_tmp1, tmp, function_params_tmp2);

            % rect_linewidth
            ind = strfind(function_params, 'rect_linewidth');
            function_params_tmp1 = function_params(1:ind + params_set('rect_linewidth'));
            function_params_tmp2 = function_params(ind + params_set('rect_linewidth'):end);
            tmp = '{';
            for i=1:num_params - 1
                tmp = strcat(tmp, '2, ');
            end
            tmp = strcat(tmp, '2}');
            function_params      = strcat(function_params_tmp1, tmp, function_params_tmp2);

            % rect_color
            ind = strfind(function_params, 'rect_color');
            function_params_tmp1 = function_params(1:ind + params_set('rect_color'));
            function_params_tmp2 = function_params(ind + params_set('rect_color'):end);
            tmp = '{';
            for i=1:num_params - 1
                tmp = strcat(tmp, '''b'', ');
            end
            tmp = strcat(tmp, '''b''}');
            function_params      = strcat(function_params_tmp1, tmp, function_params_tmp2);
            
            %% Create new module folder at des_dir
            des_dir         = fullfile(main_path, 'Algorithms/CRB_Mode', model);

            status          = mkdir(des_dir, name);
            func_main_dir   = fullfile(des_dir, name);

            status          = mkdir(func_main_dir, 'Params');
            func_params_dir = fullfile(func_main_dir, 'Params');

            %% Save module to des_dir
            f_name = strcat(model_dict(model), '_', name, '.m');
            f_main = fopen(fullfile(func_main_dir, f_name), 'w');
            fwrite(f_main, function_main);
            fclose(f_main);

            f_p_name = strcat(model_dict(model), '_', name, '_params', '.m');
            f_params = fopen(fullfile(func_params_dir, f_p_name), 'w');
            fwrite(f_params, function_params);
            fclose(f_params);
        case 2  %% Algo Mode
            %% Read template file
            template_dir    = fullfile(main_path, '/Shared/modtool/Template/Algo_Mode');
            function_main   = fileread(fullfile(template_dir, 'function_main.m'), Encoding='UTF-8');
            function_params = fileread(fullfile(template_dir, 'Params', 'function_params.m'), Encoding='UTF-8');

            %% Modify the template file
            %%% function_main file
            % Function name
            ind = strfind(function_main, 'function_main');
            function_main_tmp1   = function_main(1:ind-1);
            function_main_tmp2   = function_main(ind + params_set('function_main'):end);
            tmp                  = strcat(model_dict(model), '_', name);
            function_main        = [function_main_tmp1 ' ' tmp function_main_tmp2];

            % Find the flag index
            ind = strfind(function_main, 'flag');
            function_main_tmp1   = function_main(1:ind-1);
            function_main_tmp2   = function_main(ind + params_set('flag'):end);
            tmp = ['' newline];
            for i=1:num_params
                tmp = [tmp strcat('var_', num2str(i), ' = Op{', num2str(i), '};') ' % ' params{i} newline];
            end
            function_main      = [function_main_tmp1 ' ' tmp function_main_tmp2];

            %%% function_params file
            % Class name
            ind = strfind(function_params, 'function_params');
            function_params_tmp1 = function_params(1:ind-1);
            function_params_tmp2 = function_params(ind + params_set('function_params'):end);
            tmp                  = strcat(model_dict(model), '_', name, '_params');
            function_params      = [function_params_tmp1 ' ' tmp function_params_tmp2];

            % num_params
            ind = strfind(function_params, 'num_params');
            function_params_tmp1 = function_params(1:ind + params_set('num_params'));
            function_params_tmp2 = function_params(ind + params_set('num_params'):end);
            function_params      = strcat(function_params_tmp1, num2str(num_params), function_params_tmp2);

            % params
            ind = strfind(function_params, 'params');
            function_params_tmp1 = function_params(1:ind(3) + params_set('params'));
            function_params_tmp2 = function_params(ind(3) + params_set('params'):end);
            tmp                  = cell2char(params);
            function_params      = strcat(function_params_tmp1, tmp, function_params_tmp2);

            % params_type
            ind = strfind(function_params, 'params_type');
            function_params_tmp1 = function_params(1:ind + params_set('params_type'));
            function_params_tmp2 = function_params(ind + params_set('params_type'):end);
            tmp                  = arr2char(params_type);
            function_params      = strcat(function_params_tmp1, tmp, function_params_tmp2);

            % values
            ind = strfind(function_params, 'values');
            function_params_tmp1 = function_params(1:ind + params_set('values'));
            function_params_tmp2 = function_params(ind + params_set('values'):end);
            tmp                  = cell2char(values);
            function_params      = strcat(function_params_tmp1, tmp, function_params_tmp2);

            % default_values
            ind = strfind(function_params, 'default_values');
            function_params_tmp1 = function_params(1:ind + params_set('default_values'));
            function_params_tmp2 = function_params(ind + params_set('default_values'):end);
            tmp                  = cell2char(default_values);
            function_params      = strcat(function_params_tmp1, tmp, function_params_tmp2);

            % outputs
            ind = strfind(function_params, 'outputs');
            function_params_tmp1 = function_params(1:ind(2) + params_set('outputs'));
            function_params_tmp2 = function_params(ind(2) + params_set('outputs'):end);
            tmp                  = arr2char(outputs);
            function_params      = strcat(function_params_tmp1, tmp, function_params_tmp2);

            % title
            ind = strfind(function_params, 'title');
            function_params_tmp1 = function_params(1:ind + params_set('title'));
            function_params_tmp2 = function_params(ind + params_set('title'):end);
            title                = strcat(model_dict(model), '_', name);
            function_params      = strcat(function_params_tmp1, '{''', title, '''}', function_params_tmp2);

            % has_inter
            ind = strfind(function_params, 'has_inter');
            function_params_tmp1 = function_params(1:ind + params_set('has_inter'));
            function_params_tmp2 = function_params(ind + params_set('has_inter'):end);
            tmp = '[';
            for i=1:num_params - 1
                tmp = strcat(tmp, 'false, ');
            end
            tmp = strcat(tmp, 'false]');
            function_params      = strcat(function_params_tmp1, tmp, function_params_tmp2);

            % rect_position
            ind = strfind(function_params, 'rect_position');
            function_params_tmp1 = function_params(1:ind + params_set('rect_position'));
            function_params_tmp2 = function_params(ind + params_set('rect_position'):end);
            tmp = '{';
            for i=1:num_params - 1
                tmp = strcat(tmp, '0, ');
            end
            tmp = strcat(tmp, '0}');
            function_params      = strcat(function_params_tmp1, tmp, function_params_tmp2);

            % rect_linewidth
            ind = strfind(function_params, 'rect_linewidth');
            function_params_tmp1 = function_params(1:ind + params_set('rect_linewidth'));
            function_params_tmp2 = function_params(ind + params_set('rect_linewidth'):end);
            tmp = '{';
            for i=1:num_params - 1
                tmp = strcat(tmp, '2, ');
            end
            tmp = strcat(tmp, '2}');
            function_params      = strcat(function_params_tmp1, tmp, function_params_tmp2);

            % rect_color
            ind = strfind(function_params, 'rect_color');
            function_params_tmp1 = function_params(1:ind + params_set('rect_color'));
            function_params_tmp2 = function_params(ind + params_set('rect_color'):end);
            tmp = '{';
            for i=1:num_params - 1
                tmp = strcat(tmp, '''b'', ');
            end
            tmp = strcat(tmp, '''b''}');
            function_params      = strcat(function_params_tmp1, tmp, function_params_tmp2);
            
            %% Create new module folder at des_dir
            des_dir         = fullfile(main_path, 'Algorithms/Algo_Mode', model);

            status          = mkdir(des_dir, name);
            func_main_dir   = fullfile(des_dir, name);

            status          = mkdir(func_main_dir, 'Params');
            func_params_dir = fullfile(func_main_dir, 'Params');

            %% Save module to des_dir
            f_name = strcat(model_dict(model), '_', name, '.m');
            f_main = fopen(fullfile(func_main_dir, f_name), 'w');
            fwrite(f_main, function_main);
            fclose(f_main);

            f_p_name = strcat(model_dict(model), '_', name, '_params', '.m');
            f_params = fopen(fullfile(func_params_dir, f_p_name), 'w');
            fwrite(f_params, function_params);
            fclose(f_params);
        case 3  %% DEMO Mode
    end
end