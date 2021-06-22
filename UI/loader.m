function [f] = loader (time, str, varargin)
    %str = char(str);
    f = waitbar(0,'Please wait...');
    pause(.1)
    
    waitbar(.33, f, str);
    pause(.1)
    
    waitbar(.67, f, str);
    pause(time)
    
    if nargin == 3
        eval(varargin{1});
    end
    
    waitbar(1, f, str);
    pause(0.1)

    close(f)
end