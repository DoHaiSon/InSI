function GUI2WS( data )

%% ~ = GUI2WS(data): Export variable to workspace Matlab.
%
%% Input:
    % 1. data: (any) - input data
%
%% Output: None
%
%% Require R2006A
%
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 20-Apr-2023 18:52:13 

assignin('base', inputname(1), data);

end

