function Br_delay= spec_chan_derive_delay(fading,delay,DOA_Phi,DOA_Theta,R_nor,Nr_UCA_index,Nr_ring_index,Nr_UCA,L,M,Nt)

%Nt = 4;    % number of transmit antennas
%Nr = 4;    % number of receive antennas
%L   = 4;    % channel order
%M   = 2;    % Number of multipaths (assumption: M  = L)   
%fading = rand(M,Nt)+1i*rand(M,Nt);
%fading = rand(M,Nt);
%delay  = rand(M,Nt);
%DOA    = pi * rand(M,Nt);
%d_nor=1/2;
%Nr_index=1;
%Br_fading=zeros()
Br_delay_tmp = zeros(M,L,Nt);
for jj = 1 : Nt
    for mm = 1 : M
        for l = 1 : L
            Br_delay_tmp(mm,l,jj)=fading(mm,jj)*exp(-1i*2*pi*R_nor(Nr_ring_index)*sin(DOA_Theta(mm,jj))*cos(DOA_Phi(mm,jj)-(Nr_UCA_index-1)*2*pi/Nr_UCA))*((sin((l-1)-delay(mm,jj))/(((l-1)-delay(mm,jj))^2))-(cos((l-1)-delay(mm,jj))/((l-1)-delay(mm,jj)))); 
        end
    end
end
Br_delay_tmp1=cell(1,Nt);
for jj = 1 : Nt
Br_delay_tmp1{1,jj}=Br_delay_tmp(:,:,jj);
end
Br_delay=blkdiag(Br_delay_tmp1{:});
end
