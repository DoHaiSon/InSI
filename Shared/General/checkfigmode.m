function mode = checkfigmode( handles )

%% mode = checkfigmode(handles_): Get figure current mode of handles.
%
%% Input:
    % 1. handles: (handles) - handles of Main GUI
%
%% Output:
    % 1. mode: (numeric) - 1: Clear; 2: Hold on; 3: Subfigure
%
%% Require R2006A
%
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 20-Apr-2023 17:52:13 

holdon_state = get(handles.holdon, 'Value');
sub_fig_state= get(handles.sub_fig, 'Value');

if ~holdon_state && ~sub_fig_state
    mode = 1;
end

if holdon_state && ~sub_fig_state
    mode = 2;
end

if ~holdon_state && sub_fig_state
    mode = 3;
end

if holdon_state && sub_fig_state
    disp('Can not plot in both of types on the same time.');
end

end