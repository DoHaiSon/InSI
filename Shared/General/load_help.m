function help_ = load_help( algo )

%% help_ = load_help(algo): Load help of algorithms from its comments.
%
%% Input:
    % 1. algo: (char) - input algorithm name
%
%% Output:
    % 1. help_: (char) - output algorithm full help
%
%% Require R2006A
%
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 31-May-2023 18:52:13 

help_   = evalc(['help ' algo]);

end