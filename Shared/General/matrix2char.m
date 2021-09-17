function chr = matrix2char( matrix )
    shape = size(matrix);
    row   = shape(1);
    col   = shape(2);
    strmatrix = num2str(matrix);
    strmatrix = strsplit(strmatrix, {' '});
    if row == 1 || col == 1
        str = '[';
        for i=1:length(strmatrix)
          if i == length(strmatrix)
              str = strcat(str, strmatrix(i));
          else
              str = strcat(str, strmatrix(i), {' '});
          end
        end
        str  = strcat(str, ']');
        chr  = char(str);
    end
end