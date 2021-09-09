function channel = Generate_channel(chL, type )
% Generate a channel
%   chL: length of the channel
%   type: [1, real], [2, complex], [3, specular], [4, input_channel]

    switch(type)
        case 1                  % Real channel
            channel = randn(1,chL);

        case 2                  % Complex channel
            channel = (randn(1, chL) + 1j*randn(1,chL));        
            channel = channel / norm(channel);
        case 3

        case 4
        otherwise
    end
end

