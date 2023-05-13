function hide_line(hObject)

%% ~ = hide_line(hObject): Hide the result of a algorithm in the main output figure.
%
%% Input:
    % 1. hObject: (hObject) - hObject of the main output figure
%
%% Output: None
%
%% Require R2006A
%
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 20-Apr-2023 18:52:13 

% Get plot options
plot_op = get(hObject, 'Data');
plot_op = [plot_op{:, 1}];

% Get result fig data
global results;
fig =  results.fig;

results.figparams.fig_visible = plot_op;
results.trigger = false;
dispfig(results.inter);

end