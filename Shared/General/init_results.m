function init_results()
    global results;
    output = figure('Name', 'CRB', 'Tag', 'outputCRB');
    results.fig = output;
    output.Visible = 'off';
    results.figaxes = axes;
    results.figparams = Figparams;
    results.figparams.legends = {};
    results.pos = 'east';
    movegui(results.figaxes, results.pos);
end