function leg_parse = parseleg( mode, leg )

%% leg_parse = parseleg(mode, leg): Parse legend to latex format.
%
%% Input: 
    % 1. mode: (char) - current mode of toolbox 'Algo_Mode': 
    % Algorithm mode; 'CRB_Mode': CRB mode; 'Demo_Mode': Demo mode
    % 2. leg: (char) - legend
%
%% Output: 
    % 1. leg_parse: formated legend
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
        % Remove 'Demo_'
        leg = leg(6:end);

        % Remove charactor "_"
        idx = strfind(leg, '_');
        for i=1:length(idx)
            if leg(idx(i)) == '_'; leg(idx(i)) = ' '; end
        end
        leg_parse = leg;
end
    
end