function [] = input_data(hObject)

%% ~ = input_data(hObject): Import the data from file into toolbox variables.
%
%% Input:
    % 1. hObject: (hObject) - hObject of the current algorithms Menu
%
%% Output: None
%
%% Require R2006A
%
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 20-Apr-2023 18:52:13 

if (strcmp(hObject.Style, 'popupmenu'))
    list_ops = get(hObject, 'String');
    selected = get(hObject, 'Value');
    if (strcmp(list_ops(selected), 'Input'))
        % Get name of input data
        op_num  = str2num(hObject.Tag(4:end));
        global params;
        op_name = cell2mat(params.params(op_num));

        openfile(op_name);
    end
end

end