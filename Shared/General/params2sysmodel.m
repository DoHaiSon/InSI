function params2sysmodel(hobject, event, Params)
    handles_main = getappdata(0,'handles_main');
    axes(handles_main.board);   % Not safe! Better get the handle explicitly!
    
    rect = findall(gcf, 'Type', 'Rectangle'); 
    if ~isempty(rect)
        delete(rect); 
    end
    
    hold (handles_main.board, 'on');
    Params.rect = rectangle('Position', Params.position, 'LineWidth', Params.linewidth, 'EdgeColor', Params.color);   % Start point (x, y) and (hight, width)
    set(gca,'XColor', 'none','YColor','none')
    set(hobject, 'Enable', 'on');
    uicontrol(hobject);