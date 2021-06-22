function GUI2WS( data )
    % Export variable to workspace Matlab
    assignin('base', inputname(1), data);
end

