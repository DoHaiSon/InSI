function loader (str, varargin)
%%     varargin:
%%     func: name of function
%%     time: declear time to waitbar

%% ~ = loader (str, varargin): Loading functions of InSI.
%
%% Input:
    % 1. str: (char) - name of function to be loaded
    % 2. varargin
%
%% Output: None
%
%% Require R2006A
%
% Author: Do Hai Son, Vietnam National University, Hanoi, Vietnam

% Last modified by Do Hai Son, 31-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless Communications
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


global InSI_waitbar;

if nargin == 2 && ~isempty(varargin{1})
    InSI_waitbar = waitbar(0, 'Please wait...', 'Tag', 'InSI_loader');
    pause(.2)

    waitbar(.33, InSI_waitbar, str);
    pause(.3)

    waitbar(.67, InSI_waitbar, str);
    pause(.1 * 5)

    % exec function
    eval(varargin{1});

    waitbar(.8, InSI_waitbar, str);
else
    InSI_waitbar = waitbar(0, 'Please wait...', 'Tag', 'InSI_loader', 'CreateCancelBtn',' setappdata(gcbf,''canceling'', 1)');
    p = get(InSI_waitbar, 'Position');
    set(InSI_waitbar, 'Position', [p(1) p(2) p(3) p(4)*1.2]);
    pause(.2)

    waitbar(.1, InSI_waitbar, str);
    pause(.3)
end   

end