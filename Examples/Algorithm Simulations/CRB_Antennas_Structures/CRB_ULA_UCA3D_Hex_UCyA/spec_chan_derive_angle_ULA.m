function Br_angle= spec_chan_derive_angle(fading,delay,DOA,d_nor,Nr_index,L,M,Nt)

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
Br_angle_tmp = zeros(M,L,Nt);
for jj = 1 : Nt
    for mm = 1 : M
        for l = 1 : L
            Br_angle_tmp(mm,l,jj)=fading(mm,jj)*exp(-1i*2*pi*d_nor*(Nr_index-1)*sin(DOA(mm,jj)))*sinc((l-1)-delay(mm,jj))*(-1i*2*pi*d_nor*(Nr_index-1)*cos(DOA(mm,jj))); 
        end
    end
end
Br_angle_tmp1=cell(1,Nt);
for jj = 1 : Nt
Br_angle_tmp1{1,jj}=Br_angle_tmp(:,:,jj);
end
Br_angle=blkdiag(Br_angle_tmp1{:});
end

