function methods = load_methods( default, mode, name )
%load_methods Summary of this function goes here
%   Detailed explanation goes here
    global main_path;
    path = fullfile(main_path, '/Algorithms/', mode, name);
    sub  = dir(path);
    sub_folder = {default};
    for i=1:length(sub)
        if sub(i).isdir
            if ~strcmp(sub(i).name(1), '.')
                sub_folder{end+1} = sub(i).name;
            end
        end
    end
    methods = sub_folder;
end

