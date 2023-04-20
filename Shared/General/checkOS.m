function os = checkOS ()

%% os = checkOS(): Determine Windows/Linux/MacOS platform.
%
%% Input: None
%
%% Output:
    % 1. os: (str) - windows/linux/macos
%
%% Require R2006A
%
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 20-Apr-2023 17:52:13 

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