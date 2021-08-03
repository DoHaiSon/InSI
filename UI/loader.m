function loader (str, varargin)
%     varargin:
%     func: name of function
%     time: declear time to waitbar

    % Master timer
    global time;
    
    if nargin == 3
        step = varargin{2} / 10;
        f = waitbar(0, 'Please wait...', 'Tag', 'loader');
        pause(step)

        waitbar(.33, f, str);
        pause(step)

        waitbar(.67, f, str);
        pause(step * 5)

        % exec function
        eval(varargin{1});

        waitbar(.8, f, str);
        
    elseif nargin == 2
        f = waitbar(0,'Please wait...', 'Tag', 'loader');
        pause(.1)

        waitbar(.33, f, str);
        pause(.1)

        waitbar(.67, f, str);
        pause(.5)

        % exec function
        eval(varargin{1});

        waitbar(.8, f, str);
    else
        f = waitbar(0, 'Please wait...', 'Tag', 'loader');
        pause(.1)

        waitbar(.33, f, str);
        pause(.1)

        waitbar(.67, f, str);
        pause(.5)

        waitbar(.8, f, str);
    end   
end
