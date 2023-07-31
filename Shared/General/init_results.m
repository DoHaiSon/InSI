function init_results()

%% ~ = init_results():  Initialize figure of output.
%
%% Input: None
%
%% Output: None
%
%% Require R2006A
%
% Author: Do Hai Son, Vietnam National University, Hanoi, Vietnam

% Last modified by Do Hai Son, 30-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless Communications
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


global results;

output = figure('Tag', 'InSI_Figure');
results.fig = output;
output.Visible = 'off';
results.figaxes = axes;
results.figparams = Figparams;
results.pos = 'east';
movegui(results.figaxes, results.pos);

end