function dispfig(font)

%% ~ = dispfig(font): Display current data to the main figure of GUI.
%
%% Input:
    % 1. font: (bool) - true: latex; false: helvetica
%
%% Output: None
%
%% Require R2006A
%
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 20-Apr-2023 17:52:13 


global results;

% Check empty figure
if ~ishandle(results.fig)
%   output = figure('Name', 'CE', 'Tag', 'channel_estimation', 'visible','off');
    output = figure('Tag', 'InfoSysID_Toolbox_Output', 'visible','off');
    results.fig = output;
    results.figaxes = axes;
    movegui(results.figaxes, results.pos);
    results.trigger = false;
end

set(results.fig, 'Visible', 'on');
% Switch font: latex/helvetica
if font
    interpreter = 'latex';
else
    interpreter = 'none';
end

%% TODO: Force keep subfig_mode when users swapped Output_type

% figure
switch (results.mode)
    case 1
        % Reset the output figure before re-plot all data
        delete(results.fig);
        output = figure('Tag', 'InfoSysID_Toolbox_Output', 'visible','off');
        results.fig = output;
        results.figaxes = axes;
        movegui(results.figaxes, results.pos);
        set(results.fig, 'Visible', 'on');
        
        % Get the last one visible instead of the last value
        index = find(results.figparams.fig_visible, true, 'last');
        if (index ~= 0)
            if (results.Output_type == 1 || results.Output_type == 2)
                semilogy(results.figaxes, results.figparams.data(index).x, results.figparams.data(index).y ...
                    , results.figparams.marker);
            else
                plot(results.figaxes, results.figparams.data(index).x, results.figparams.data(index).y ...
                    , results.figparams.marker);
            end
            legend(results.figaxes, results.figparams.legends(index), 'Interpreter', interpreter);
        end
        
        grid (results.figaxes, results.figparams.gridmode);
        ylabel(results.figaxes, results.figparams.ylabel{index}, 'Interpreter', interpreter);
        xlabel(results.figaxes, results.figparams.xlabel{index}, 'Interpreter', interpreter);
        title(results.figaxes, results.figparams.title{index}, 'Interpreter', interpreter, 'fontweight','bold','fontsize', 16);
        set(results.figaxes ,'TickLabelInterpreter', interpreter);
    case 2
        legends = results.figparams.legends;
        if results.trigger && results.pre_mode == results.mode
            i=results.figparams.count; % Just plot the latest data per times.

            if (results.Output_type == 1 || results.Output_type == 2)
                semilogy(results.figaxes, results.figparams.data(i).x, results.figparams.data(i).y ...
                    , results.figparams.marker);
            else
                plot(results.figaxes, results.figparams.data(i).x, results.figparams.data(i).y ...
                    , results.figparams.marker);
            end
            hold (results.figaxes, 'on');
        else
            % Reset the output figure before re-plot all data
            delete(results.fig);
            output = figure('Tag', 'InfoSysID_Toolbox_Output', 'visible','off');
            results.fig = output;
            results.figaxes = axes;
            movegui(results.figaxes, results.pos);
            set(results.fig, 'Visible', 'on');
            
            for i=1:results.figparams.count % Plot all data.
                if (results.figparams.fig_visible(i))
                    if (results.Output_type == 1 || results.Output_type == 2)
                        semilogy(results.figaxes, results.figparams.data(i).x, results.figparams.data(i).y ...
                            , results.figparams.marker);
                    else
                        plot(results.figaxes, results.figparams.data(i).x, results.figparams.data(i).y ...
                            , results.figparams.marker);
                    end
                    hold (results.figaxes, 'on');
                end
            end

            for i=results.figparams.count:-1:1 % Plot all data.
                if (~results.figparams.fig_visible(i))
                    % Drop invisible data legend
                    legends(i) = [];
                end
            end
        end

        legend(results.figaxes, legends, 'Interpreter', interpreter);

        grid (results.figaxes, results.figparams.gridmode);
        ylabel(results.figaxes, results.figparams.ylabel{end}, 'Interpreter', interpreter);
        xlabel(results.figaxes, results.figparams.xlabel{end}, 'Interpreter', interpreter);
%             title(results.figaxes, results.figparams.title{end}, 'Interpreter', interpreter, 'fontweight','bold','fontsize', 16);
        set(results.figaxes ,'TickLabelInterpreter',interpreter);
    case 3
        num = sum(results.figparams.fig_visible(:) == true);
        [p, n] = subplot_layout(num);
        index = 1;
        for j=1:results.figparams.count
            if (results.figparams.fig_visible(j))
                subfig = subplot(p(1), p(2), index, 'Parent', results.fig); 
                if (results.Output_type == 1 || results.Output_type == 2)
                    semilogy(subfig, results.figparams.data(j).x, results.figparams.data(j).y ...
                        , results.figparams.marker);
                else
                    plot(subfig, results.figparams.data(j).x, results.figparams.data(j).y ...
                    , results.figparams.marker);
                end
                legend(subfig, results.figparams.legends(j), 'Interpreter', interpreter);
                grid (subfig, results.figparams.gridmode);
                ylabel(subfig, results.figparams.ylabel{j}, 'Interpreter', interpreter);
                xlabel(subfig, results.figparams.xlabel{j}, 'Interpreter', interpreter);
                title(subfig, results.figparams.title{j}, 'Interpreter', interpreter, 'fontweight','bold','fontsize', 16);
                set(subfig , 'TickLabelInterpreter', interpreter);
                index = index + 1;
            end
        end
    otherwise
end
results.pre_mode = results.mode;

% Push fig windows on top
set(results.fig,'WindowStyle','modal');
set(results.fig,'WindowStyle','normal');

end