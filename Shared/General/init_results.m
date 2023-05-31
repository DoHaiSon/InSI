function init_results()

%% ~ = init_modtool():  Initialize figure of output.
%
%% Input: None
%
%% Output: None
%
%% Require R2006A
%
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 20-Apr-2023 18:54:13 

global results;

output = figure('Tag', 'InSI_Figure');
results.fig = output;
output.Visible = 'off';
results.figaxes = axes;
results.figparams = Figparams;
results.figparams.legends = {};
results.pos = 'east';
movegui(results.figaxes, results.pos);

end