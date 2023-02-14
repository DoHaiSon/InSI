function status = Check_Installed_pkgs ( OS_support,  ls_pkgs)

OS_support = strjoin(OS_support, " ");     
ls_pkgs = strjoin(ls_pkgs, " ");

cmd = "python ./Shared/Python/Check_Installed_pkgs.py ";

cmd = [cmd, OS_support, ls_pkgs];

cmd = strjoin(cmd, " ");

[~, stdout] = system(cmd);

if contains(stdout, 'True')
    status = true;
else
    error(stdout);
end