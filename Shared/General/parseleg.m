function leg_parse = parseleg( mode, leg )
    % Parse leg to latex format
    
    switch (mode)
        case 'Algo_Mode'
            % Remove prefix: B SB NB
            idx = find(ismember(leg,'_'), 1, 'first');
            if leg(idx) == '_'; leg = leg(idx+1:end); end 

            % Remove charactor "_"
            idx = strfind(leg, '_');
            for i=1:length(idx)
                if leg(idx(i)) == '_'; leg(idx(i)) = ' '; end
            end
            leg_parse = leg;
        case 'CRB_Mode'
            % Remove charactor "_"
            idx = strfind(leg, '_');
            for i=1:length(idx)
                if leg(idx(i)) == '_'; leg(idx(i)) = ' '; end
            end
            leg_parse = leg;
        case 'Demo_Mode'
    end
    
end

