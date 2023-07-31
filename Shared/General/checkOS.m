function os = checkOS ()

%% os = checkOS(): Determine Windows/Linux/MacOS platform.
%
%% Input: None
%
%% Output:
    % 1. os: (str) - windows/linux/macos
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


if ismac
    os = 'macos';
elseif isunix
    os = 'linux';
elseif ispc
    os = 'windows';
else
    error('Platform not supported.');
end

end