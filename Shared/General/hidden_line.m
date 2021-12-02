function hidden_line(hObject, eventdata, handles)
    mode = checkfigmode(handles);
    switch (mode)
        case 1
        case 2
            plot_op = get(hObject, 'Data');
            plot_op = [plot_op{:, 1}];

            % Get result fig from init results class
            global results;
            fig =  results.fig;
            
            lines = get(get(fig, 'Children'), 'Children');
            lines = lines(2);
            lines = lines{1};

            len_op = length(plot_op);
            for i = 1:len_op
                if plot_op(i) == 0
                    set(lines(len_op - i + 1), 'Visible', 'off');
                else
                    set(lines(len_op - i + 1), 'Visible', 'on');
                end
            end
            % TODO: hide legends of hidden lines
        case 3
    end
end