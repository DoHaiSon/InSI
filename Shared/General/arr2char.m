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
% Author: Do Hai Son, Vietnam National University, Hanoi, Vietnam

% Last modified by Do Hai Son, 30-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless Communications
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


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