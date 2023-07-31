function releasesysmodel(hobject, event)

%% ~ = releasesysmodel(hobject, event): Remove all boxs of reactive in algorithm system model.
%
%% Input:
    % 1. hObject: (hObject) - hObject of current GUI
    % 2. event: (eventdata) - eventdata of current GUI
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


handles_main = getappdata(0,'handles_main');
axes(handles_main.board);   % Not safe! Better get the handle explicitly!

% remove old algorithm model on the dashboard
list_axes = findall(gcf, 'Type', 'axes');
for axes_i = 1:length(list_axes)
%     if (isempty(strfind(list_axes(axes_i).Units, 'normalized')))
        cla(list_axes(axes_i));
%     end
end


rect = findall(gcf, 'Type', 'Rectangle'); 
if ~isempty(rect)
    delete(rect); 
end

end