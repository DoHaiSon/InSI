function init_modtool()

%% ~ = init_modtool():  Initialize the variable for InfoSysID_modtool.
%
%% Input: None
%
%% Output: None
%
%% Require R2006A
%
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 20-Apr-2023 18:54:13 

global modtool_inputs
modtool_inputs = struct();
modtool_inputs.params = {};
modtool_inputs.params_type = [];
modtool_inputs.values = {};
modtool_inputs.default_values = {};
modtool_inputs.outputs = [];
modtool_inputs.state = 0;
modtool_inputs.finish = false;
modtool_inputs.trigger = false;
modtool_inputs.trigger_1 = false;

end