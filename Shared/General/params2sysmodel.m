function params2sysmodel(hobject, event, handles, Params, i)
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