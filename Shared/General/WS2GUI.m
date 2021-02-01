function [ data ] = WS2GUI( name )
%   Get data variable from Workspace to GUI
try
    data = evalin('base', name);
catch
    err = [name, ' not exist in Workspace.'];
    disp(err);
    data = 0;   % TODO: Return NULL
end

