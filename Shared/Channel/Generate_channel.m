function channel = Generate_channel(L, chL, type, N_t, N_r, fading, delay, DOA)

%% channel = Generate_channel(L, chL, type, N_t, N_r, fading, delay, DOA): Generation of wireless channels.
%
%% Input:
    % 1. L: (int) - number of channels (sensors)
    % 2. chL: (int) - length of the channels
    % 3. type: (int) - [1, real], [2, complex], [3, parametric], [4, input_channel]
%
%% Output:
    % 1. channel: (numeric) - output channel matrix
%
%% Require R2006A
%
% Author: Do Hai Son, Vietnam National University, Hanoi, Vietnam

% Last modified by Do Hai Son, 31-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless Communications
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


switch(type)
    case 1                  % Real channel
        channel = randn(L, chL + 1);

    case 2                  % Complex channel
        channel = (randn(L, chL + 1) + 1i*randn(L, chL + 1));        
        channel = channel / sqrt(2);
    case 3                  % Parametric channel
        % fading, delay, DOA of size (M,Nt)
        channel = zeros(N_r, chL, N_t);
        M       = size(DOA, 1);  
        
        % Suppose that d/lambda = 1/2
        for r = 1 : N_r
            for jj = 1 : N_t
                for ll = 1 : chL
                    h = 0;
                    for m = 1 : M 
                        h = h + fading(m,jj) * sinc(ll-delay(m,jj)) * exp(-1i*pi*(r-1)*sin(DOA(m,jj)));
                    end
                    channel(r,ll,jj) = h;
                end
            end
        end
    case 4                  % Input channel
        global input_data;
        Ch_type = input_data.ChType;
        if (strcmp(Ch_type(1), {'Trigger_input'}))
            % TODO: check shape of input channel
            channel = cell2mat(Ch_type(2));
        else
            fprintf('Input file not supported.');
        end
    otherwise
end

end