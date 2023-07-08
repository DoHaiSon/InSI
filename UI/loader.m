function loader (str, varargin)
%%     varargin:
%%     func: name of function
%%     time: declear time to waitbar
    
    global InSI_waitbar;

    if nargin == 2 && ~isempty(varargin{1})
        InSI_waitbar = waitbar(0, 'Please wait...', 'Tag', 'InSI_loader');
        pause(.2)

        waitbar(.33, InSI_waitbar, str);
        pause(.3)

        waitbar(.67, InSI_waitbar, str);
        pause(.1 * 5)

        % exec function
        eval(varargin{1});

        waitbar(.8, InSI_waitbar, str);
    else
        InSI_waitbar = waitbar(0, 'Please wait...', 'Tag', 'InSI_loader', 'CreateCancelBtn',' setappdata(gcbf,''canceling'', 1)');
        p = get(InSI_waitbar, 'Position');
        set(InSI_waitbar, 'Position', [p(1) p(2) p(3) p(4)*1.2]);
        pause(.2)

        waitbar(.1, InSI_waitbar, str);
        pause(.3)
    end   
end
