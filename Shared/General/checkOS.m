function os = checkOS ()
    % Determine if version is for Windows/Linux/MacOS platform
    if ismac
        os = "macos";
    elseif isunix
        os = "linux";
    elseif ispc
        os = "windows";
    else
        error("Platform not supported.");
    end
end