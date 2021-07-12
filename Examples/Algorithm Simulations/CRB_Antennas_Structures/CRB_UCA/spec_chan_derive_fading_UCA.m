function Br_fading= spec_chan_derive_fading(fading,delay,DOA,R_nor,Nr_index,Nr,L,M,Nt)

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
Br_fading_tmp = zeros(M,L,Nt);
for jj = 1 : Nt
    for mm = 1 : M
        for l = 1 : L
            Br_fading_tmp(mm,l,jj)=sinc((l-1)-delay(mm,jj))*exp(-1i*2*pi*R_nor*cos(DOA(mm,jj)-(Nr_index-1)*2*pi/Nr)); 
        end
    end
end
Br_fading_tmp1=cell(1,Nt);
for jj = 1 : Nt
Br_fading_tmp1{1,jj}=Br_fading_tmp(:,:,jj);
end
Br_fading=blkdiag(Br_fading_tmp1{:});
end

