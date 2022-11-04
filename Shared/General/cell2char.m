function chr = cell2char ( cell_ )

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
    if sum(size(tmp{:}) == 1) == 2 || ischar(cell_i{:})
        if isnumeric(cell_i{:})
            chr = strcat(chr, num2str(tmp{:}), '}');
        else
            chr = strcat(chr, '''', char(tmp{:}), '''}');
        end
    else
        chr = strcat(chr, cell2char(tmp{:}), '}');
    end
end