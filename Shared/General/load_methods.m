function menu = load_methods( default, name )
%load_method Summary of this function goes here
%   Detailed explanation goes here
    global main_path;
    path = fullfile(main_path, '/Algorithms/Algo_Mode/', name);
    sub  = dir(path);
    sub_folder = {default};
    for i=1:length(sub)
        if sub(i).isdir
            if sub(i).name(1) ~= '.'
                sub_folder{end+1} = sub(i).name;
            end
        end
    end
    menu = sub_folder;
end

