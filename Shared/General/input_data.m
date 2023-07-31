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
% Author: Do Hai Son, Vietnam National University, Hanoi, Vietnam

% Last modified by Do Hai Son, 30-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless Communications
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


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