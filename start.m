function start()
%%  add path to this toolbox
    global main_path;
    main_path = matlab.desktop.editor.getActiveFilename; %   get path of active file
    main_path = main_path(1:end-8);
    addpath(genpath(main_path));

%%  format master clock
    format shortg;
    global time;
    time = clock;
    
%%  Declear global vars
    global legends;
    legends = {};
    output = figure('Name', 'CRB', 'Tag', 'output1');
    output.Visible = 'off';
    global output_axes;
    output_axes = axes;
    
%%  Load main GUI
    loader('Opening the application', 'main');
    try
        F = findall(0, 'type', 'figure', 'tag', 'loader');
        waitbar(1, F, 'Done!');
        close(F);
    catch ME
        disp(ME);
    end