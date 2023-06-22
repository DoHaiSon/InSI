function loader (str, varargin)
%%     varargin:
%%     func: name of function
%%     time: declear time to waitbar
    
    if nargin == 2 && ~isempty(varargin{1})
        f = waitbar(0, 'Please wait...', 'Tag', 'InSI_loader');
        pause(.2)

        waitbar(.33, f, str);
        pause(.3)

        waitbar(.67, f, str);
        pause(.1 * 5)

        % exec function
        eval(varargin{1});

        waitbar(.8, f, str);
    else
        f = waitbar(0, 'Please wait...', 'Tag', 'InSI_loader');
        pause(.2)

        waitbar(.33, f, str);
        pause(.3)

        waitbar(.67, f, str);
        pause(.5)

        waitbar(.8, f, str);
    end   
end
