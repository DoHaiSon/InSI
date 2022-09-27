function SER = SER_func(Y, data, L, Mod_type)
    %% Symbol error rate
    % ----------------------------------------------------------------------------------------
    switch Mod_type
        case 1
            X_demod     = qamdemod(Y, 2);
        case 2
            X_demod     = pskdemod(Y, 4, pi/4);         
        case 3
            X_demod     = qamdemod(Y, 4); 
    end
    data_t      = data(L:end);                  % Remove padding (FIR length)
    correct     = sum(data_t == X_demod);       % Number of the symbols Errs
    SER         = 1-correct/length(X_demod);
end