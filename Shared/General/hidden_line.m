function hidden_line(hObject, eventdata, handles)

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