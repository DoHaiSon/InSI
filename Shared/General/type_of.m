function arg_type = type_of (arg)

%% ~ = releasesysmodel(hobject, event): Return the type of input variable.
%
%% Input:
    % 1. arg: (any) - input variable
%
%% Output: 
    % 1. arg_type: (char) - type of input variable 'char': char; 'number':
    % numeric; 'array': array of char or numeric; 'bool': boolean; 'str':
    % string; 'cell': cell
%
%% Require R2016b
%
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 20-Apr-2023 17:52:13 

if ischar(arg)                          % char 
    arg_type = 'char';
    return
end

if isscalar(arg)                        % scalar number
    arg_type = 'number';
    return
end

if ~isscalar(arg) && isnumeric(arg)     % number array
    arg_type = 'array';
    return
end

if islogical(arg)                       % true/false
    arg_type = 'bool';
end

if isstring(arg)                        % str /str array
    arg_type = 'str';
    return
end

if iscell(arg)                          % cell
   arg_type = 'cell';
   return


end