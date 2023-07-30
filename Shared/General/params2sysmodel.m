function params2sysmodel(hobject, event, handles, Params, i)

%% ~ = params2sysmodel(hobject, event, handles, Params, i): 
% Display the reactive of variable and algorithm system models.
%
%% Input: 
    % 1. hObject: (hObject) - hObject of current GUI
    % 2. event: (eventdata) - eventdata of current GUI
    % 3. handles: (handles) - handles of current GUI
    % 4. Params: (class) - UI class of current algorithm
    % 5. i (numeric) - index of current parameter in the Menu
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


handles_main = getappdata(0, 'handles_main');
axes(handles_main.board);   % Not safe! Better get the handle explicitly!

rect = findall(gcf, 'Type', 'Rectangle'); 
if ~isempty(rect)
    delete(rect); 
end

hold (handles_main.board, 'on');
Params.rect{end+1} = rectangle('Position', Params.rect_position{i}, 'LineWidth', Params.rect_linewidth{i}, 'EdgeColor', Params.rect_color{i});   % Start point (x, y) and (height, width)
set(gca,'XColor', 'none', 'YColor', 'none');
set(eval(strcat('handles.Op_', num2str(i))), 'Enable', 'on');
uicontrol(eval(strcat('handles.Op_', num2str(i))));

end