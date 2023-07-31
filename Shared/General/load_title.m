function title = load_title( algo )

%% title = load_title(algo): Load title of algorithms from its help.
%
%% Input:
    % 1. algo: (char) - input algorithm name
%
%% Output:
    % 1. title: (char) - output algorithm full title
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


load_help   = evalc(['help ' algo]);
split_help  = strsplit(load_help, '\n');

title       = strtrim(split_help{1});

end