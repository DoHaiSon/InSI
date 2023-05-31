function InSI()

%% A MatLab Toolbox for Informed System IDentification in Wireless communication systems
%
%% Support R2014b or later
%
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 31-May-2023 17:52:13 

global main_path;
main_path = mfilename('fullpath'); %   get path of active file
main_path = main_path(1:end-4);
addpath(fullfile(main_path, 'Shared', 'Utils'));
addpath(genpath_exclude(main_path, {'.git'}));

%% Close all InSI windows
if ~close_InSI()
    return
end

% Clear auto save file of matlab
clear_asv_files(main_path);

%%  format master clock
format shortg;
global InSI_time;
InSI_time = datetime('now');

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
loader('Opening the application', 'InSI_mode');
try
    F = findall(0, 'type', 'figure', 'tag', 'loader');
    waitbar(1, F, 'Done!');
    close(F);
catch ME
    disp(ME);
end

end