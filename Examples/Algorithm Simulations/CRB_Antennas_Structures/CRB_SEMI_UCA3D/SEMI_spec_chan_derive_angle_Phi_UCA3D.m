function Br_angle_Phi= spec_chan_derive_angle_Phi(fading,delay,DOA_Phi,DOA_Theta,R_nor,Nr_index,Nr,L,M,Nt)

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
Br_angle_Phi_tmp = zeros(M,L,Nt);
for jj = 1 : Nt
    for mm = 1 : M
        for l = 1 : L
            Br_angle_Phi_tmp(mm,l,jj)=fading(mm,jj)*exp(-1i*2*pi*R_nor*sin(DOA_Theta(mm,jj))*cos(DOA_Phi(mm,jj)-(Nr_index-1)*2*pi/Nr))*sinc((l-1)-delay(mm,jj))*(-1i*2*pi*R_nor*sin(DOA_Theta(mm,jj))*(-sin(DOA_Phi(mm,jj)))); 
        end
    end
end
Br_angle_Phi_tmp1=cell(1,Nt);
for jj = 1 : Nt
Br_angle_Phi_tmp1{1,jj}=Br_angle_Phi_tmp(:,:,jj);
end
Br_angle_Phi=blkdiag(Br_angle_Phi_tmp1{:});
end

