function releasesysmodel(hobject, event)
    handles_main = getappdata(0,'handles_main');
    axes(handles_main.board);   % Not safe! Better get the handle explicitly!
    
    rect = findall(gcf, 'Type', 'Rectangle'); 
    if ~isempty(rect)
        delete(rect); 
    end
end
