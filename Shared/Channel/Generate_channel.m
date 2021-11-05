function channel = Generate_channel(L, chL, type )
% Generate a channel
%   chL: length of the channel
%   type: [1, real], [2, complex], [3, specular], [4, input_channel]

    switch(type)
        case 1                  % Real channel
            channel = randn(L, chL + 1);

        case 2                  % Complex channel
            channel = (randn(L, chL + 1) + 1j*randn(L, chL + 1));        
            channel = channel / norm(channel);
        case 3

        case 4
        otherwise
    end
end

