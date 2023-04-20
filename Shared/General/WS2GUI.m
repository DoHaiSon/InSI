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
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 20-Apr-2023 18:52:13 

try
    data = evalin('base', name);
catch
    err = [name, ' not exist in Workspace.'];
    disp(err);
    data = 0;   % TODO: Return NULL
end

end

