function char = matrix2char( matrix )
    shape = size(matrix);
    row   = shape(1);
    col   = shape(2);
    strmatrix = string(matrix);
    if row == 1 || col == 1
        str = '[';
        for i=1:length(strmatrix)
          str = str + strmatrix(i) + ' ';
        end
        str  = strip(str);
        str  = str + ']'; 
        char = convertStringsToChars(str);
    end
end