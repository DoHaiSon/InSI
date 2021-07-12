function [H,h_vec] = gen_chan_specular(fading,delay,DOA_Phi,DOA_Theta,R_nor,Nr_ring,Nr_UCA,L,N_t)
% fading, delay, DOA of size (M,Nt)
H = zeros(Nr_ring*Nr_UCA,L,N_t);
M = size(DOA_Phi,1);  

% Suppose that d/lambda = 1/2

h_vec = [];
r=0;
for Nr_ring_index=1:Nr_ring    
for Nr_UCA_index=1:Nr_UCA
    r=r+1;
    for jj = 1 : N_t
        for ll = 1 : L
            h = 0;
            for mm = 1 : M 
                h = h + fading(mm,jj) * sinc((ll-1)-delay(mm,jj)) * exp(-1i*2*pi*R_nor(Nr_ring_index)*sin(DOA_Theta(mm,jj))*cos(DOA_Phi(mm,jj)-(Nr_UCA_index-1)*2*pi/Nr_UCA));
            end
            H(r,ll,jj) = h;
            h_vec      = [h_vec; h];
        end
    end
end
end

end

