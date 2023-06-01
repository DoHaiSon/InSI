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
InSI_ws = get(hObject, 'Data');
plot_op = [InSI_ws{:, 1}];

% Get result fig data
global results;
fig =  results.fig;

if (results.mode == 1)
    pre_plot_op = results.figparams.fig_visible;
    if (sum(plot_op + pre_plot_op) ~= 1)
        plot_op = ~(plot_op == pre_plot_op);
    end
    for i=1:length(plot_op)
        hObject.Data{i, 1} = [plot_op(i)];
    end
end

if (results.mode == 2)
    ws_output = {InSI_ws{:, 3}};

    tmp = {};
    for i = 1:length(plot_op)
        if plot_op(i)
            tmp{end + 1} = ws_output{i};
        end
    end

    if (length(unique(tmp)) ~= 1)
        msgbox('Combine figure mode not available in multi output types.');
        for i=1:length(results.figparams.fig_visible)
            hObject.Data{i, 1} = [results.figparams.fig_visible(i)];
        end
        return;
    end
end

results.figparams.fig_visible = plot_op;
results.trigger = false;

dispfig(results.inter);

end