function ER = ER_func(varargin)
    %% Symbol error rate
    % Input:
    % data_src: symbols at source
    % est_src: estimated signals 
    % Mod_type: Modulation types (Bin / QPSK / QAM4 / QAM16)
    % Output_type: (SER / BER / MSE H)
    % sig_src: (optional in blind mode) signals at souce 
    % ----------------------------------------------------------------------------------------
    
    data_src = varargin{1};
    est_src  = varargin{2};
    Mod_type = varargin{3};
    Output_type = varargin{4};
    if (nargin == 5)
        sig_src = varargin{5};
    end

    % Check mode blind/semi/non-blind
    stack = dbstack();
    called_file = stack(2).name;
    index = find(ismember(called_file, '_'), 1, 'first');
    switch (called_file(1:index-1))
        case 'B'
            if (Mod_type ~= 1)
                est_src  = est_src' * sig_src * est_src;    % remove the inherent scalar indeterminacy related to the blind processing
            end
        case 'SB'
        case 'NB'
    end

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

    ER = sum(X_demod ~= data_src) / length(data_src);
end