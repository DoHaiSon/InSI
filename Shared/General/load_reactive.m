function load_reactive(hObject, eventdata, handles, mode, model, algo )

%% ~ = load_reactive(hObject, eventdata, handles, mode, model, algo)
% Load reactive options from the class
%
%% Input:
    % 1. hObject: (hObject) - hObject of current GUI
    % 2. eventdata: (eventdata) - eventdata of current GUI
    % 3. handles: (handles) - handles of current GUI
    % 4. mode: (char) - current mode of toolbox 'Algo_Mode': Algorithm mode; 'CRB_Mode': CRB mode;
    % 'Demo_Mode': Demo mode
    % 5. model: (char) - the selected method 'Non-blind': None-blind;
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

set(hObject, 'Enable', 'on');

end