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
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 20-Apr-2023 17:52:13 

    handles_main = getappdata(0,'handles_main');
    axes(handles_main.board);   % Not safe! Better get the handle explicitly!
    
    rect = findall(gcf, 'Type', 'Rectangle'); 
    if ~isempty(rect)
        delete(rect); 
    end
end
