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
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 20-Apr-2023 17:52:13 

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