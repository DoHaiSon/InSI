function status = close_InSI()

%% status = close_InSI():  Close all old sessions of InSI.
%
%% Input: None
%
%% Output: 
    % 1. status (bool) - users confirm or not True: Confirm; 
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


status = true;
open_warning = true;
all_fig = findall(groot, 'Type', 'figure');
for idx = 1:length(all_fig)
    fig = all_fig(idx);
    if(~isempty(strfind(fig.Tag, 'InSI')) || ...
       ~isempty(strfind(fig.Name, 'InSI'))) 
        tmp_0 = char(fig.Visible);
        tmp_1 = 0;
        if (strcmp(tmp_0, 'on'))
            tmp_1 = 1;
        end
        if (open_warning && tmp_1)
            open_warning = ~mode_questdlg();
            if open_warning
                status = false;
                return;
            end
        end
        delete(fig);
    end
end

end