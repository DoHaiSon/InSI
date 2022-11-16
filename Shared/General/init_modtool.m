function init_modtool()
    global modtool_inputs
    modtool_inputs = struct();
    modtool_inputs.params = {};
    modtool_inputs.params_type = [];
    modtool_inputs.values = {};
    modtool_inputs.default_values = {};
    modtool_inputs.outputs = [];
    modtool_inputs.state = 0;
    modtool_inputs.finish = false;
end