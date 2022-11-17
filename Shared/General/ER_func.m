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
    
    % Output types: 1: SER
    %               2: BER 
    %               3: MSE Signal 
    %               4: MSE Channel 

    switch Output_type
        case 1  % SER
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
                    data_est     = qamdemod(est_src, 2);
                case 2
                    data_est     = pskdemod(est_src, 4, pi/4);         
                case 3
                    data_est     = qamdemod(est_src, 4); 
                case 4
                    data_est     = qamdemod(est_src, 16);
            end
        
            ER = sum(data_est ~= data_src) / length(data_src);
        
        case 2  % BER
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
                    data_est     = qamdemod(est_src, 2);
                case 2
                    data_est     = pskdemod(est_src, 4, pi/4);         
                case 3
                    data_est     = qamdemod(est_src, 4); 
                case 4
                    data_est     = qamdemod(est_src, 16);
            end
            % Dec to bin
            bin_src = dec2bin(data_src);
            bin_src = bin_src(:);
            bin_est = dec2bin(data_est);
            bin_est = bin_est(:);

            ER = sum(bin_est ~= bin_src) / length(bin_src);
        
        case 3  % MSE Signal
            roo    = abs(est_src' * sig_src) / (norm(est_src,'fro')*norm(sig_src,'fro'));
            ER     = 1 - (roo^2);
            ER     = 10*log10(ER);

        case 4  % MSE Channel
            h      = varargin{1};       % Generated channel
            h_est  = varargin{2};       % Estimated channel

            h      = h.';
            h      = h(:);
            
            h_tmp  = h * exp(-1i*angle(h(1)));
            alpha  = h_est' * h_tmp / norm(h_est)^2;
            h_est  = alpha * h_est;

            ER     = sum(abs((h_est - h_tmp).^2));
            ER     = 10*log10(ER);
    end
end