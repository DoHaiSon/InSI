function [confirm] = mode_questdlg()

%% confirm = mode_questdlg(): Warning box when users try to switch mode.
%
%% Input: None
%
%% Output:
    % 1. confirm: (bool) - users confirm or not True: Confirm; False:
    % Cancel
%
%% Require R2006A
%
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 20-Apr-2023 17:52:13 

answer = questdlg('WARNING: All data will be lost!!! Are you sure you want to switch the mode?', ...
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
end

end