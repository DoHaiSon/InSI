function InSI()

%% A MatLab Toolbox for Informed System Identification in Wireless Communications
%
%% Documents: https://avitech-vnu.github.io/InSI
%
%% Support R2014B or later
%
% Adapted for InSI by Do Hai Son, 28-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless Communications
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


global main_path;
main_path = mfilename('fullpath'); %   get path of active file
main_path = main_path(1:end-4);
addpath(fullfile(main_path, 'Shared', 'Utils'));
addpath(genpath_exclude(main_path, {'.git'}));

%% Close all InSI windows
if ~close_InSI()
    return
end

% Check MatLab version and load configs
global configs;

matlab_version = version('-release');
matlab_version = regexp(matlab_version,'(-)?\d+(\.\d+)?(e(-|+)\d+)?','match');
if (str2num(matlab_version{1}) < 2016)
    configs = Configs_R16;
else
    configs = Configs_R17;
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

%%  Load MODE GUI
loader('Opening InSI', 'InSI_mode');
try
    F = findall(0, 'type', 'figure', 'tag', 'InSI_loader');
    waitbar(1, F, 'Done!');
    delete(F);
catch ME
    disp(ME);
end

end
