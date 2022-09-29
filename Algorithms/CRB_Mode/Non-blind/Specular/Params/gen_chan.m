function [H,h_vec] = gen_chan(fading,delay,DOA,N_r,L,N_t)
% fading, delay, DOA of size (M,Nt)
H = zeros(N_r,L,N_t);
M = size(DOA,1);  

% Suppose that d/lambda = 1/2

h_vec = [];
for r = 1 : N_r
    for jj = 1 : N_t
        for ll = 1 : L
            h = 0;
            for m = 1 : M 
                h = h + fading(m,jj) * sinc(ll-delay(m,jj)) * exp(-1i*pi*(r-1)*sin(DOA(m,jj)));
            end
            H(r,ll,jj) = h;
            h_vec      = [h_vec; h];
        end
    end
end

end

