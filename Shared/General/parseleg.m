function leg_parse = parseleg( leg )
    % Parse leg to latex format
    idx = find(ismember(leg,'_'),1,'last');
    if leg(idx) == '_'; leg(idx) = ' '; end 
    leg_parse = leg;
end

