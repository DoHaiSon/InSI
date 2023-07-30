function load_reactive(hObject, eventdata, handles, mode, model, algo )

%% ~ = load_reactive(hObject, eventdata, handles, mode, model, algo)
% Load reactive options from the class
%
%% Input:
    % 1. hObject: (hObject) - hObject of current GUI
    % 2. eventdata: (eventdata) - eventdata of current GUI
    % 3. handles: (handles) - handles of current GUI
    % 4. mode: (char) - current mode of toolbox 'Algo_Mode': 
    % Algorithm mode; 'CRB_Mode': CRB mode; 'Demo_Mode': Demo mode
    % 5. model: (char) - the selected method 'Non-blind': None-blind;
    % 'Semi-blind': Semi-blind; 'Blind': Blind
    % 6. algo: (char) - the name of selected algorithm
%
%% Output: None
%
%% Require R2006A
%
% Author: Do Hai Son, Vietnam National University, Hanoi, Vietnam

% Last modified by Do Hai Son, 30-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless communication systems
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