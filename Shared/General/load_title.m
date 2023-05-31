function title = load_title( algo )

%% title = load_title(algo): Load title of algorithms from its help.
%
%% Input:
    % 1. algo: (char) - input algorithm name
%
%% Output:
    % 1. title: (char) - output algorithm full title
%
%% Require R2006A
%
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 31-May-2023 18:52:13 

load_help   = evalc(['help ' algo]);
split_help  = strsplit(load_help, '\n');

title       = strtrim(split_help{1});

end