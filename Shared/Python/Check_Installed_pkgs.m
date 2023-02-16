function status = Check_Installed_pkgs ( OS_support,  ls_pkgs)

    OS_support = strjoin(OS_support, " ");     
    ls_pkgs = strjoin(ls_pkgs, " ");
    
    % Determine if version is for Windows/Linux/MacOS platform
    if ismac
        python = 'python3 ';
    elseif isunix
        python = 'python3 ';
    elseif ispc
        python = 'python ';
    else
        error('Platform not supported');
    end
    
    script = "./Shared/Python/Check_Installed_pkgs.py ";
    
    cmd = [python, script, OS_support, ls_pkgs];
    
    cmd = strjoin(cmd, " ");
    
    [~, stdout] = system(cmd);
    
    if contains(stdout, 'True')
        status = true;
    else
        error(stdout);
    end

end