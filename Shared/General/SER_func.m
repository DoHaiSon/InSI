function SER = SER_func(sig_src, est_src, Mod_type)
    %% Symbol error rate
    % ----------------------------------------------------------------------------------------
    switch Mod_type
        case 1
            X_demod     = qamdemod(est_src, 2);
        case 2
            X_demod     = pskdemod(est_src, 4, pi/4);         
        case 3
            X_demod     = qamdemod(est_src, 4); 
        case 4
            X_demod     = qamdemod(est_src, 16);
    end
    SER = sum(X_demod ~= sig_src) / length(sig_src);
end