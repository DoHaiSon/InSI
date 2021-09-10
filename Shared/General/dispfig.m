function dispfig(results)
    set(results.fig, 'Visible', 'on');
    % figure
    switch (results.mode)
        case 1
            semilogy(results.figaxes, results.figparams.data(end).x, results.figparams.data(end).y ...
                , results.figparams.marker);
            hold (results.figaxes, 'on');
            legend(results.figaxes, results.figparams.legends);
            grid (results.figaxes, results.figparams.gridmode);
            ylabel(results.figaxes, results.figparams.ylabel);
            xlabel(results.figaxes, results.figparams.xlabel);
            title(results.figaxes, results.figparams.title);
        case 2
            for i=1:results.figparams.count
                semilogy(results.figaxes, results.figparams.data(i).x, results.figparams.data(i).y ...
                    , results.figparams.marker);
                hold (results.figaxes, 'on');
            end

            legend(results.figaxes, results.figparams.legends);
            grid (results.figaxes, results.figparams.gridmode);
            ylabel(results.figaxes, results.figparams.ylabel);
            xlabel(results.figaxes, results.figparams.xlabel);
            title(results.figaxes, results.figparams.title);
        case 3
            num = results.figparams.count;
            for i=1:num
                subfig = subplot(1, num, i, 'Parent', results.fig); 
                semilogy(subfig, results.figparams.data(i).x, results.figparams.data(i).y ...
                    , results.figparams.marker);
                legend(subfig, results.figparams.legends);
                grid (subfig, results.figparams.gridmode);
                ylabel(subfig, results.figparams.ylabel);
                xlabel(subfig, results.figparams.xlabel);
                title(subfig, results.figparams.title);
            end
        otherwise
    end
    
end