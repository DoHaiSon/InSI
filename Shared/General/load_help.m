function help_ = load_help( algo )

%% help_ = load_help(algo): Load help of algorithms from its comments.
%
%% Input:
    % 1. algo: (char) - input algorithm name
%
%% Output:
    % 1. help_: (char) - output algorithm full help
%
%% Require R2006A
%
% Author: Do Hai Son, Vietnam National University, Hanoi, Vietnam

% Last modified by Do Hai Son, 30-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless communication systems
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


if ~isempty(strfind(algo, 'Select version'))
    error('Please select a version of the algorithm.');
end

help_   = evalc(['help ' algo]);

end