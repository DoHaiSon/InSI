function [] = load_ref_web()

%% ~ = load_ref_web(): Open the reference paper URL.
%
%% Input: None
%
%% Output: None
%
%% Require R2006A
%
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 20-Apr-2023 17:52:13 

global params;

try
    web_url = params.web_url;
    web(web_url, '-browser');
catch 
    disp("This algorithm does not have any reference paper.");
end

end