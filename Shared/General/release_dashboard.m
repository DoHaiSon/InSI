function release_dashboard ( hObject, cont )

%% index = release_dashboard(hObject, cont): Replace dashboard with title of algorithms
%
%% Input:
    % 1. hObject: (handles) - handles of current dashboard in InSI 
    % 2. cont: (char) - name of current algorithm
%
%% Output: 
    % 1. index: (int) - index of editable text
%
%% Require R2006A
%
% Author: Do Hai Son, Vietnam National University, Hanoi, Vietnam

% Last modified by Do Hai Son, 11-Aug-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless Communications
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France

global Text_handles;
global configs;
Position = hObject.Position;
x_0 = Position(1);
y_0 = Position(2);
width = Position(3);
height = Position(4);

try
    % Set font size
    default = configs.default_title_font_size;
    font_size = 0.15;
    if length(cont) ~= 14
        font_size = 0.15 / 1.8;
    end
    set(Text_handles, 'FontSize', font_size);
    
    % Set position
    set(Text_handles, 'HorizontalAlignment', 'center');
    set(Text_handles, 'Position', [x_0 + width * 12, y_0 - height / 2, 0]);

    % Set content
    set(Text_handles, 'String', cont);
catch ME
    disp(ME);
    return
end

end