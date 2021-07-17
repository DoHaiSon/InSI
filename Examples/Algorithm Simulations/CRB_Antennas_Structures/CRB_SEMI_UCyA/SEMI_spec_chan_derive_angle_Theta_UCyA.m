function Br_angle_Theta= spec_chan_derive_angle_Theta(fading,delay,DOA_Phi,DOA_Theta,position_elements_nor,R_nor,d_ULA_nor,Nr_UCA_index,Nr_ULA_index,Nr_UCA,Nr_ULA,L,M,Nt)

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
Br_angle_Theta_tmp = zeros(M,L,Nt);
for jj = 1 : Nt
    for mm = 1 : M
        for l = 1 : L
            Br_angle_Theta_tmp(mm,l,jj)=fading(mm,jj)*exp(-1i*2*pi*R_nor*sin(DOA_Theta(mm,jj))*cos(DOA_Phi(mm,jj)-position_elements_nor))*exp(-1i*2*pi*d_ULA_nor*(Nr_ULA_index-1)*cos(DOA_Theta(mm,jj)))*sinc((l-1)-delay(mm,jj))*(-1i*2*pi*d_ULA_nor*(Nr_ULA_index-1)*(-sin(DOA_Theta(mm,jj)))-1i*2*pi*R_nor*cos(DOA_Phi(mm,jj)-position_elements_nor)*(cos(DOA_Theta(mm,jj)))); 
        end
    end
end
Br_angle_Theta_tmp1=cell(1,Nt);
for jj = 1 : Nt
Br_angle_Theta_tmp1{1,jj}=Br_angle_Theta_tmp(:,:,jj);
end
Br_angle_Theta=blkdiag(Br_angle_Theta_tmp1{:});
end

