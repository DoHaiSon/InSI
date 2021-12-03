function vers = load_versions( model, default, name )
%load_versions Summary of this function goes here
%   Detailed explanation goes here
%   TODO: Dynamic load version
    global main_path;
    path  = fullfile(main_path, '/Algorithms/Algo_Mode/', model, name);
    sub   = dir(path);
    algos = {default};
    for i=1:length(sub)
        if ~sub(i).isdir
            if strcmp(sub(i).name(1:6), 'B_CMA_')
                algos{end+1} = sub(i).name(1:end-2);
            end
        end
    end
    vers = algos;
end