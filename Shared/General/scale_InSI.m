function [x, y, w, h] = scale_InSI(hObject)

%% [x, y, w, h] = scale_InSI(hObject): Resize InSI according to your resolution and scale.
%
%% Input:
    % 1. hObject: (hObject) - hObject of the main output figure
%
%% Output: 
    % 1. x: (numberic) - start point of InSI x coordinate
    % 2. y: (numberic) - start point of InSI y coordinate
    % 3. w: (numberic) - width of InSI window
    % 4. h: (numberic) - height of InSI window
%
%% Require R2006A
%
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 03-Jun-2023 18:52:13 

% Sets the units of your root object (screen) to pixels
set(0,'units','pixels');
% Obtains this pixel information
Pix_Sc = get(0,'screensize');

Sc_w = Pix_Sc(3);
Sc_h = Pix_Sc(4);

% Init ouput
x = 0;
y = 0;
w = 0;
h = 0;


if (~(~isempty(strfind(hObject.Tag, 'InSI_C_')) || ~isempty(strfind(hObject.Tag, 'InSI_A_')) || ~isempty(strfind(hObject.Tag, 'InSI_D_'))))
    if (isempty(strfind(hObject.Tag, 'InSI_mode')))
        if (~isempty(strfind(hObject.Tag, 'InSI_modtool')))
            % modtool windows
            x = 0;
            y = 0;
            w = Sc_w * 0.2451388889;
            h = Sc_h * 0.7966666667;
        else
            % Main windows
            x = 0;
            y = 0;
            w = Sc_w * 0.5826388889;
            h = Sc_h * 0.8255555556;
        end
    else  
        % Loader window
        x = 0;
        y = 0;
        w = Sc_w * 0.2368055556;
        h = Sc_h * 0.5444444444;
    end
else
    % Menu windows
    x = 0;
    y = 0;
    w = Sc_w * 0.2180555556;
    h = Sc_h * 0.7666666667;
end

end