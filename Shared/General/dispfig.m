function dispfig(font)
    global results;
    
    % Check empty figure
    if ~ishandle(results.fig)
        output = figure('Name', 'CE', 'Tag', 'channel_estimation', 'visible','off');
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
            semilogy(results.figaxes, results.figparams.data(end).x, results.figparams.data(end).y ...
                , results.figparams.marker);
%             hold (results.figaxes, 'on');
            legend(results.figaxes, results.figparams.legends, 'Interpreter', interpreter);
            grid (results.figaxes, results.figparams.gridmode);
            ylabel(results.figaxes, results.figparams.ylabel, 'Interpreter', interpreter);
            xlabel(results.figaxes, results.figparams.xlabel, 'Interpreter', interpreter);
            title(results.figaxes, results.figparams.title, 'Interpreter', interpreter, 'fontweight','bold','fontsize', 16);
            set(results.figaxes ,'TickLabelInterpreter', interpreter);
        case 2
            if results.trigger
                i=results.figparams.count; % Just plot the latest data per times.
                semilogy(results.figaxes, results.figparams.data(i).x, results.figparams.data(i).y ...
                    , results.figparams.marker);
                hold (results.figaxes, 'on');
            else
                for i=1:results.figparams.count % Plot all data.
                    semilogy(results.figaxes, results.figparams.data(i).x, results.figparams.data(i).y ...
                        , results.figparams.marker);
                    hold (results.figaxes, 'on');
                end
            end

            legend(results.figaxes, results.figparams.legends, 'Interpreter', interpreter);
            grid (results.figaxes, results.figparams.gridmode);
            ylabel(results.figaxes, results.figparams.ylabel, 'Interpreter', interpreter);
            xlabel(results.figaxes, results.figparams.xlabel, 'Interpreter', interpreter);
            title(results.figaxes, results.figparams.title, 'Interpreter', interpreter, 'fontweight','bold','fontsize', 16);
            set(results.figaxes ,'TickLabelInterpreter',interpreter);
        case 3
            num = results.figparams.count;
            for i=1:num
                subfig = subplot(1, num, i, 'Parent', results.fig); 
                semilogy(subfig, results.figparams.data(i).x, results.figparams.data(i).y ...
                    , results.figparams.marker);
                legend(subfig, results.figparams.legends, 'Interpreter', interpreter);
                grid (subfig, results.figparams.gridmode);
                ylabel(subfig, results.figparams.ylabel, 'Interpreter', interpreter);
                xlabel(subfig, results.figparams.xlabel, 'Interpreter', interpreter);
                title(subfig, results.figparams.title, 'Interpreter', interpreter, 'fontweight','bold','fontsize', 16);
                % TODO: set TickLabelInterpreter latex
%                 set(results.figaxes ,'TickLabelInterpreter', interpreter);
            end
        otherwise
    end
    
end