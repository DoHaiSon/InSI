function init_modtool()

%% ~ = init_modtool():  Initialize the variable for InSI_modtool.
%
%% Input: None
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


global modtool_inputs
modtool_inputs = struct();
modtool_inputs.params = {};
modtool_inputs.notations = {};
modtool_inputs.params_type = [];
modtool_inputs.values = {};
modtool_inputs.default_values = {};
modtool_inputs.outputs = [];
modtool_inputs.state = 0;
modtool_inputs.finish = false;
modtool_inputs.trigger = false;
modtool_inputs.trigger_1 = false;

end