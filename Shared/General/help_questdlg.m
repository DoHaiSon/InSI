function [] = help_questdlg( msg, algo )

%% ~ = help_questdlg(): Information box for help button in Menu GUIDE.
%
%% Input: 
    % 1. msg: (char) - message to be displayed
    % 2. algo: (char) - name of algorithm
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


answer = questdlg(msg, ...
['Help: ' load_title(algo)], ...
'Access paper', 'OK', 'OK');
% Handle response
switch answer
    case 'Access paper'
        load_ref_web();
        return
    case 'OK'
        return
    otherwise
        return
end

end