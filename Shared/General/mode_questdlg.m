function [confirm] = mode_questdlg()

%% confirm = mode_questdlg(): Warning box when users try to switch mode.
%
%% Input: None
%
%% Output:
    % 1. confirm: (bool) - users confirm or not True: Confirm; 
    % False: Cancel
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


answer = questdlg('WARNING: All data will be lost!!!', ...
'Warning notification', ...
'Confirm','Cancel', 'Cancel');
% Handle response
switch answer
    case 'Confirm'
        confirm = true;
        return
    case 'Cancel'
        confirm = false;
        return
    otherwise
        confirm = false;
        return
end

end