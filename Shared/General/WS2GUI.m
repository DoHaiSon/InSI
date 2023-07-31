function [ data ] = WS2GUI( name )

%% ~ = GUI2WS(name):  Get data variable from Workspace to GUI.
%
%% Input:
    % 1. name: (char, str) - name of a variable in workspace panel
%
%% Output: 
    % 1. data: (any) - value of this variable
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


try
    data = evalin('base', name);
catch
    err = [name, ' not exist in Workspace.'];
    disp(err);
    data = 0;   % TODO: Return NULL
end

end

