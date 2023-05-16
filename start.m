function start()
    %% Close all InfoSysID_Toolbox windows
    open_warning = true;
    all_fig = findall(groot, 'Type', 'figure');
    for idx = 1:length(all_fig)
        fig = all_fig(idx);
        if(~isempty(strfind(fig.Tag, 'InfoSysID_Toolbox')) || ...
                ~isempty(strfind(fig.Name, 'System Identification')) || ...
                strcmp(fig.Name, 'Select Mode') || ...
                ~isempty(strfind(fig.Name, 'methods')) || ...
                ~isempty(strfind(fig.Tag, 'loader'))) 
            if (open_warning && fig.Visible)
                open_warning = ~mode_questdlg();
                if open_warning
                    return;
                end
            end
            close(fig);
        end
    end

    global main_path;
    main_path = mfilename('fullpath'); %   get path of active file
    main_path = main_path(1:end-6);
    addpath(fullfile(main_path, 'Shared', 'Utils'));
    addpath(genpath_exclude(main_path, {'.git'}));
    
    % Clear auto save file of matlab
    clear_asv_files(main_path);

    
%%  Declear global vars
    global results;
    results = Results;
    init_results();
    global pre_algo;
    pre_algo = '';
    global input_data;
    input_data = {};

    init_modtool();
    
%%  Load MODE GUI
    loader('Opening the application', 'InfoSysID_mode');
    try
        F = findall(0, 'type', 'figure', 'tag', 'loader');
        waitbar(1, F, 'Done!');
        close(F);
    catch ME
        disp(ME);
    end