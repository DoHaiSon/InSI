function arg_type = type_of (arg)

%% ~ = releasesysmodel(hobject, event): Return the type of input variable.
%
%% Input:
    % 1. arg: (any) - input variable
%
%% Output: 
    % 1. arg_type: (char) - type of input variable 'char': char; 
    % 'number': numeric; 'array': array of char or numeric; 
    % 'bool': boolean; 'str': string; 'cell': cell
%
%% Require R2016b
%
% Author: Do Hai Son, Vietnam National University, Hanoi, Vietnam

% Last modified by Do Hai Son, 30-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless Communications
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


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