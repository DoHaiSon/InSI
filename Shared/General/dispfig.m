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
% Author: Do Hai Son, Vietnam National University, Hanoi, Vietnam

% Last modified by Do Hai Son, 30-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless Communications
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


global results;
global params;

% Check empty figure
if ~ishandle(results.fig)
    output = figure('Tag', 'InSI_Figure', 'visible','off');
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

% figure
switch (results.mode)
    case 1
        % Reset the output figure before re-plot all data
        delete(results.fig);
        output = figure('Tag', 'InSI_Figure', 'visible','off');
        results.fig = output;
        results.figaxes = axes;
        movegui(results.figaxes, results.pos);
        set(results.fig, 'Visible', 'on');
        
        % Get the last one visible instead of the last value
        index = find(results.figparams.fig_visible, true, 'last');
        if (index ~= 0)
            if (results.Output_type == 1 || results.Output_type == 2)
                if iscell(results.figparams.data(index).y)
                    for n=1:length(results.figparams.data(index).y)
                            semilogy(results.figaxes, results.figparams.data(index).x, results.figparams.data(index).y{n} ...
                                , results.figparams.marker{index});
                            hold (results.figaxes, 'on');
                    end
                else
                    semilogy(results.figaxes, results.figparams.data(index).x, results.figparams.data(index).y ...
                        , results.figparams.marker{index});
                end
            else
                if iscell(results.figparams.data(index).y)
                    for n=1:length(results.figparams.data(index).y)
                        plot(results.figaxes, results.figparams.data(index).x, results.figparams.data(index).y{n} ...
                            , results.figparams.marker{index});
                        hold (results.figaxes, 'on');
                    end
                else
                    plot(results.figaxes, results.figparams.data(index).x, results.figparams.data(index).y ...
                    , results.figparams.marker{index});
                end
            end

            if iscell(results.figparams.legends{index})
                legends_tmps = {};
                legends_i = results.figparams.legends{index};
                for n=1:length(results.figparams.legends{index})
                    legends_tmps{end+1} = legends_i{n};
                end
                legend(results.figaxes, legends_tmps, 'Interpreter', interpreter);
            else
                legend(results.figaxes, results.figparams.legends{index}, 'Interpreter', interpreter);
            end

        else
            grid (results.figaxes, results.figparams.gridmode);
            set(results.figaxes ,'TickLabelInterpreter', interpreter);
            return;
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
               if iscell(results.figparams.data(i).y)
                    for n=1:length(results.figparams.data(i).y)
                        semilogy(results.figaxes, results.figparams.data(i).x, results.figparams.data(i).y{n} ...
                            , results.figparams.marker{i});
                        hold (results.figaxes, 'on');
                    end
                else
                    semilogy(results.figaxes, results.figparams.data(i).x, results.figparams.data(i).y ...
                        , results.figparams.marker{i});
                end
            else
                if iscell(results.figparams.data(i).y)
                    for n=1:length(results.figparams.data(i).y)
                        plot(results.figaxes, results.figparams.data(i).x, results.figparams.data(i).y{n} ...
                            , results.figparams.marker{i});
                        hold (results.figaxes, 'on');
                    end
                else
                    plot(results.figaxes, results.figparams.data(i).x, results.figparams.data(i).y ...
                        , results.figparams.marker{i});
                end
            end
            hold (results.figaxes, 'on');
        else
            % Reset the output figure before re-plot all data
            delete(results.fig);
            output = figure('Tag', 'InSI_Figure', 'visible','off');
            results.fig = output;
            results.figaxes = axes;
            movegui(results.figaxes, results.pos);
            set(results.fig, 'Visible', 'on');
            
            for i=1:results.figparams.count % Plot all data.
                if (results.figparams.fig_visible(i))
                    if (results.Output_type == 1 || results.Output_type == 2)
                        if iscell(results.figparams.data(i).y)
                            for n=1:length(results.figparams.data(i).y)
                                semilogy(results.figaxes, results.figparams.data(i).x, results.figparams.data(i).y{n} ...
                                    , results.figparams.marker{i});
                                hold (results.figaxes, 'on');
                            end
                        else
                            semilogy(results.figaxes, results.figparams.data(i).x, results.figparams.data(i).y ...
                                        , results.figparams.marker{i});
                        end
                    else
                        if iscell(results.figparams.data(i).y)
                            for n=1:length(results.figparams.data(i).y)
                                plot(results.figaxes, results.figparams.data(i).x, results.figparams.data(i).y{n} ...
                                    , results.figparams.marker{i});
                                hold (results.figaxes, 'on');
                            end
                        else
                            plot(results.figaxes, results.figparams.data(i).x, results.figparams.data(i).y ...
                                , results.figparams.marker{i});
                        end
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
        legends_tmps = {};
        for i=1:length(legends)
            if iscell(legends{i})
                legends_j = legends{i};
                for j=1:length(legends_j)
                    legends_tmps{end+1} = legends_j{j};
                end
            else
                legends_tmps{end+1} = legends{i};
            end
        end
        legend(results.figaxes, legends_tmps, 'Interpreter', interpreter);

        grid (results.figaxes, results.figparams.gridmode);
        ylabel(results.figaxes, results.figparams.ylabel{end}, 'Interpreter', interpreter);
        xlabel(results.figaxes, results.figparams.xlabel{end}, 'Interpreter', interpreter);
%             title(results.figaxes, results.figparams.title{end}, 'Interpreter', interpreter, 'fontweight','bold','fontsize', 16);
        set(results.figaxes ,'TickLabelInterpreter',interpreter);

        results.trigger = true;
    case 3
        if (sum(results.figparams.fig_visible) == 0)
            % Reset the output figure before re-plot all data
            delete(results.fig);
            output = figure('Tag', 'InSI_Figure', 'visible','off');
            results.fig = output;
            results.figaxes = axes;
            movegui(results.figaxes, results.pos);
            set(results.fig, 'Visible', 'on');
            grid (results.figaxes, results.figparams.gridmode);
            
            set(results.figaxes ,'TickLabelInterpreter',interpreter);
            return;
        end

        num = sum(results.figparams.fig_visible(:) == true);
        [p, n] = subplot_layout(num);
        index = 1;
        for j=1:results.figparams.count
            if (results.figparams.fig_visible(j))
                subfig = subplot(p(1), p(2), index, 'Parent', results.fig); 
                if (results.Output_type == 1 || results.Output_type == 2)
                    if iscell(results.figparams.data(j).y)
                        for n=1:length(results.figparams.data(j).y)
                            semilogy(subfig, results.figparams.data(j).x, results.figparams.data(j).y{n} ...
                                , results.figparams.marker{j});
                            hold (subfig, 'on');
                        end
                    else
                        semilogy(subfig, results.figparams.data(j).x, results.figparams.data(j).y ...
                            , results.figparams.marker{j});
                    end
                else
                    if iscell(results.figparams.data(j).y)
                        for n=1:length(results.figparams.data(j).y)
                                plot(subfig, results.figparams.data(j).x, results.figparams.data(j).y{n} ...
                                    , results.figparams.marker{j});
                                hold (subfig, 'on');
                        end
                    else
                        plot(subfig, results.figparams.data(j).x, results.figparams.data(j).y ...
                            , results.figparams.marker{j});
                    end
                end

                legends_tmps = {};
                legends_i = results.figparams.legends{j};
                if iscell(legends_i)
                    for n=1:length(legends_i)
                        legends_tmps{end+1} = legends_i{n};
                    end
                    legend(subfig, legends_tmps, 'Interpreter', interpreter);
                else
                    legend(subfig, results.figparams.legends{j}, 'Interpreter', interpreter);
                end

%                 legend(subfig, results.figparams.legends(j), 'Interpreter', interpreter);
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