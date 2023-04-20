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
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 20-Apr-2023 17:52:13 

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