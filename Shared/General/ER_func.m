function ER = ER_func(varargin)

%% ER = ER_func(varargin): Calculate the output of algorithms.
%
%% Input: (varargin)
    % 1. data_src: (numeric) - symbols at source
    % 2. est_src: (numeric) - estimated signals 
    % 3. Mod_type: (numeric) - type of modulation 1- Bin; 2 - QPSK; 3 - QAM4; 4 - QAM16
    % 4. Output_type: (numeric) - type of output  1- SER; 2 - BER; 3 - MSE Signal; 4 - MSE Channel 
    % 5. sig_src (optional in blind mode): (numeric) - signals at source 
%
%% Output: 
    % 1. ER: (numberic) - estimated error in terms of Output_type 
%
%% Require R2006A
%
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 20-Apr-2023 18:52:13 

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
        % Transpose to row vector
        if length(est_src) ~= 1
            est_src = est_src.';
        end
        if length(sig_src) ~= 1
            sig_src = sig_src.';
        end

        roo    = abs(est_src' * sig_src) / (norm(est_src,'fro')*norm(sig_src,'fro'));
        ER     = 1 - (roo^2);
        ER     = 10*log10(ER);

    case 4  % MSE Channel
        h      = varargin{1};       % Generated channel
        h_est  = varargin{2};       % Estimated channel

        if (nargin == 6)
            h      = h(:);
            ER = 10*log10(norm(h-h_est)^2);
            return
        end

        h      = h.';
        h      = h(:);

        h_tmp  = h * exp(-1i*angle(h(1)));
        alpha  = h_est' * h_tmp / norm(h_est)^2;
        h_est  = alpha * h_est;

        ER     = sum(abs((h_est - h_tmp).^2));
        ER     = 10*log10(ER);
end

end