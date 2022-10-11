function [] = input_data(hObject, eventdata, handles)
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