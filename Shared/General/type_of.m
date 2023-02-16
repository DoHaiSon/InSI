function arg_type = type_of (arg)
    %% Return type of arg in char
    %% Require R2016b

    if ischar(arg)                          % char 
        arg_type = 'char';
        return
    end

    if isscalar(arg)                        % scalar number
        arg_type = 'number';
        return
    end

    if ~isscalar(arg) && isnumeric(arg)     % number array
        arg_type = 'array';
        return
    end

    if islogical(arg)                       % true/false
        arg_type = 'bool';
    end

    if isstring(arg)                        % str /str array
        arg_type = 'str';
        return
    end

    if iscell(arg)                          % cell
       arg_type = 'cell';
       return
    end
end