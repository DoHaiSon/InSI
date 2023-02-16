function py_arg = parse_arg2py (arg)
    %% Return char arg for python script

    switch type_of(arg)
        case 'number'
            py_arg = num2str(arg);
        case 'array'
            parsed = sprintf('%.0f,' , arg);
            py_arg = ['[' parsed(1:end-1) ']'];         % Use ast.literal_eval in python
        case 'char'
            py_arg = arg;
        case 'str'
            py_arg = char(arg);
        case 'bool'
            if arg
                py_arg = '1';
            else
                py_arg = '0';
            end
        case 'cell'
            
        otherwise
            error('Unexpected input type.');
    end
end