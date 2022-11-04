function start()
%%  For testing, we close everything when the program startup
    close all hidden;

%%  TODO: Do not add everything 
    global main_path;
    main_path = mfilename('fullpath'); %   get path of active file
    main_path = main_path(1:end-6);
    addpath(genpath(main_path));
    
    % Clear auto save file of matlab
    clear_asv_files(main_path);
    
    % TODO: Close all BSI toolbox windows

%%  format master clock
    format shortg;
    global time;
    time = clock;
    
%%  Declear global vars
    global results;
    results = Results;
    init_results();
    global pre_algo;
    pre_algo = '';
    global input_data;
    input_data = {};

    global modtool_inputs
    modtool_inputs = struct();
    modtool_inputs.params = {};
    modtool_inputs.params_type = [];
    modtool_inputs.values = {};
    modtool_inputs.default_values = {};
    modtool_inputs.outputs = [];
    modtool_inputs.state = 0;
    modtool_inputs.finish = false;
    
%%  Load MODE GUI
    loader('Opening the application', 'mode');
    try
        F = findall(0, 'type', 'figure', 'tag', 'loader');
        waitbar(1, F, 'Done!');
        close(F);
    catch ME
        disp(ME);
    end