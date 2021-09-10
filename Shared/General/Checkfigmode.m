function mode = Checkfigmode( handles )
%Checkfigmode Summary of this function goes here
%   Input: handles of main GUI
%   Output: 1: Clear; 2: Hold on; 3: Subfigure
    
    holdon_state = get(handles.holdon, 'Value');
    sub_fig_state= get(handles.sub_fig, 'Value');
    
    if ~holdon_state && ~sub_fig_state
        mode = 1;
    end
    
    if holdon_state && ~sub_fig_state
        mode = 2;
    end
    
    if ~holdon_state && sub_fig_state
        mode = 3;
    end
    
    if holdon_state && sub_fig_state
        disp('Can not plot in both of types on the same time.');
    end
end

