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
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 31-May-2023 21:52:13 

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