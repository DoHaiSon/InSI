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
% Author: Do Hai Son, Vietnam National University, Hanoi, Vietnam

% Last modified by Do Hai Son, 30-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless communication systems
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


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

    if length(InSI_ws) ~= 3
        if (length(unique(tmp)) ~= 1 && ~isempty(unique(tmp)))
            msgbox('Combine figure mode not available in multi output types.');
            for i=1:length(results.figparams.fig_visible)
                hObject.Data{i, 1} = [results.figparams.fig_visible(i)];
            end
            return;
        end
    end
end

results.figparams.fig_visible = plot_op;
results.trigger = false;

dispfig(results.inter);

end