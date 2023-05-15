function leg_parse = parseleg( mode, leg )

%% leg_parse = parseleg(mode, leg): Parse legend to latex format.
%
%% Input: 
    % 1. mode: (char) - current mode of toolbox 'Algo_Mode': Algorithm mode; 'CRB_Mode': CRB mode;
    % 'Demo_Mode': Demo mode
    % 2. leg: (char) - legend
%
%% Output: 
    % 1. leg_parse: formated legend
%
%% Require R2006A
%
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 20-Apr-2023 17:52:13 
    
switch (mode)
    case 'Algo_Mode'
        % Remove charactor "_"
        idx = strfind(leg, '_');
        for i=1:length(idx)
            if leg(idx(i)) == '_'; leg(idx(i)) = ' '; end
        end
        leg_parse = leg;
    case 'CRB_Mode'
        % Remove charactor "_"
        idx = strfind(leg, '_');
        for i=1:length(idx)
            if leg(idx(i)) == '_'; leg(idx(i)) = ' '; end
        end
        leg_parse = leg;
    case 'Demo_Mode'
end
    
end