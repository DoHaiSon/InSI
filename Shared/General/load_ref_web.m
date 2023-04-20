function [] = load_ref_web()
%load_ref_web Summary of this function goes here
%   Detailed explanation goes here
    global params;
    
    try
        web_url = params.web_url;
        web(web_url, '-browser');
    catch 
        disp("This algorithm does not have any reference paper.");
    end
end