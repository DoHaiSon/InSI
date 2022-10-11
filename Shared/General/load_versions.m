function vers = load_versions( model, default, name )
%load_versions Summary of this function goes here
%   Detailed explanation goes here
    global main_path;
    path  = fullfile(main_path, '/Algorithms/Algo_Mode/', model, name);
    sub   = dir(path);
    algos = {default};
    for i=1:length(sub)
        if ~sub(i).isdir
            switch (model)
                case 'Blind'
                    if strcmp(sub(i).name(1:2), 'B_')
                        algos{end+1} = sub(i).name(1:end-2);
                    end
                case 'Non-blind'
                    if strcmp(sub(i).name(1:3), 'NB_')
                        algos{end+1} = sub(i).name(1:end-2);
                    end
                case 'Semi-blind'
                    if strcmp(sub(i).name(1:3), 'SB_')
                        algos{end+1} = sub(i).name(1:end-2);
                    end
                otherwise
                    disp('The mode is not supported.')
            end
            
        end
    end
    vers = algos;
end