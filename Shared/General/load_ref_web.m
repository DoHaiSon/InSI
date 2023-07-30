function [] = load_ref_web()

%% ~ = load_ref_web(): Open the reference paper URL.
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
% Wireless communication systems
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


global params;

try
    if (strcmp(params.web_url, ''))
        disp('This algorithm does not have any reference paper.');
        return
    end
    web_url = params.web_url;
    web(web_url, '-browser');
catch 
    disp('This algorithm does not have any reference paper.');
end

end