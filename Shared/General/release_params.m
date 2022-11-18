function release_params(handles, modtool_inputs)
    % panel title
    param_panel_tile = ['Interface: Parameter ' num2str(modtool_inputs.state)];
    set(handles.param_panel, 'Title', param_panel_tile);

    % name
    set(handles.param_name, 'String', 'edit');

    % input_type
    set(handles.input_type_edit, 'Value', 1);

    % input_value panel
    set(handles.input_value_panel, 'Visible', 'off');

    % input_value
    set(handles.input_value, 'Visible', 'off');
    set(handles.input_value, 'String', 'edit');

    % input_default
    set(handles.input_default, 'String', 'edit');
end
