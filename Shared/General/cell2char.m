function chr = cell2char ( cell_ )

%% chr = cell2char(cell_): Convert cell to char function.
%
%% Input:
    % 1. cell_: (numeric, char, str) - input cell
%
%% Output:
    % 1. chr: (char) - output character
%
%% Require R2006A
%
% Author: Do Hai Son, Vietnam National University, Hanoi, Vietnam

% Last modified by Do Hai Son, 30-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless communication systems
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


chr = '{';
for i=1:length(cell_) - 1
    cell_i = cell_(i);
    if sum(size(cell_i{:}) == 1) == 2 || ischar(cell_i{:})
        if isnumeric(cell_i{:})
            chr = strcat(chr, num2str(cell_i{:}), ', ');
        else
            chr = strcat(chr, '''', char(cell_i{:}), ''', ');
        end
    else
        chr = strcat(chr, cell2char(cell_i{:}), ', ');
    end
end

tmp = cell_(length(cell_));
if sum(size(tmp{:}) == 1) == 2 || ischar(tmp{:})
    if isnumeric(tmp{:})
        chr = strcat(chr, num2str(tmp{:}), '}');
    else
        chr = strcat(chr, '''', char(tmp{:}), '''}');
    end
else
    chr = strcat(chr, cell2char(tmp{:}), '}');
end

end