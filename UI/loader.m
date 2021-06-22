function [f] = loader (time, str, varargin)
    %str = char(str);
    f = waitbar(0,'Please wait...');
    pause(.1)
    
    waitbar(.33, f, str);
    pause(.1)
    
    waitbar(.67, f, str);
    pause(.5)
    
    if nargin == 3
        eval(varargin{1});
    end
    
    waitbar(.8, f, str);
    t = tic();
    while toc(t) < 3
        pause(0.01);
        drawnow('limitrate');
    end
    
    waitbar(1, f, 'Done!');
    
    close(f)
end
