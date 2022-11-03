function chr = arr2char ( arr_ )
    % TODO: Recursive func
    
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