function close_InSI()

%% ~ = close_InSI():  Close all old sessions of InSI.
%
%% Input: None
%
%% Output: None
%
%% Require R2006A
%
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 31-May-2023 18:54:13 

open_warning = true;
all_fig = findall(groot, 'Type', 'figure');
for idx = 1:length(all_fig)
    fig = all_fig(idx);
    if(~isempty(strfind(fig.Tag, 'InSI')) || ...
       ~isempty(strfind(fig.Name, 'InSI')) || ...
       ~isempty(strfind(fig.Tag, 'loader'))) 
        if (open_warning && fig.Visible)
            open_warning = ~mode_questdlg();
            if open_warning
                return;
            end
        end
        close(fig);
    end
end

end