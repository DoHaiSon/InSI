function chr = arr2char ( arr_ )

%% chr = arr2char(arr_): Convert array to char function.
%
%% Input:
    % 1. arr_: (numeric, char, str) - input array
%
%% Output:
    % 1. chr: (char) - output character
%
%% Require R2006A
%
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 20-Apr-2023 17:52:13 

% TODO: Recursive func; N-D array

chr = '[';
for i=1:length(arr_) - 1
    if isnumeric(arr_(i))
        chr = strcat(chr, num2str(arr_(i)), ', ');
    else
        chr = strcat(chr, char(arr_(i)), ', ');
    end
end

if isnumeric(arr_(length(arr_)))
    chr = strcat(chr, num2str(arr_(length(arr_))), ']');
else
    chr = strcat(chr, char(arr_(length(arr_))), ', ');
end

end