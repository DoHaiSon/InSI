function start()
%   add path to this toolbox
    toolbox_path = matlab.desktop.editor.getActiveFilename; %   get path of active file
    addpath(genpath(toolbox_path(1:end-8)));
    loader();
    