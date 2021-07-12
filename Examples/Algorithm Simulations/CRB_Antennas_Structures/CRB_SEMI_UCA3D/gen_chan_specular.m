function [H,h_vec] = gen_chan_specular(fading,delay,DOA_Phi,DOA_Theta,R_nor,N_r,L,N_t)
% fading, delay, DOA of size (M,Nt)
H = zeros(N_r,L,N_t);
M = size(DOA_Phi,1);  

% Suppose that d/lambda = 1/2

h_vec = [];
for r = 1 : N_r
    for jj = 1 : N_t
        for ll = 1 : L
            h = 0;
            for mm = 1 : M 
                h = h + fading(mm,jj) * sinc(ll-delay(mm,jj)) * exp(-1i*2*pi*R_nor*sin(DOA_Theta(mm,jj))*cos(DOA_Phi(mm,jj)-(r-1)*2*pi/N_r));
            end
            H(r,ll,jj) = h;
            h_vec      = [h_vec; h];
        end
    end
end

end

