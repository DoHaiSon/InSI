function [confirm] = mode_questdlg()
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