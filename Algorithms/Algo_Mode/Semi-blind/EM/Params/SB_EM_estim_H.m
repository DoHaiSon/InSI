function  H_init = SB_EM_estim_H(sig_cap,canaux,T,L,M,p)

%...mise en forme du canal exact pour test
can1 = canaux(:,1:M+1);
x1   = can1(:);
can2 = canaux(:,M+2:2*(M+1));
x2   = can2(:);
can = [x1,x2];

%... N : window lenght
N = p*M+1;
Nb = L*N- p*(M+N);

 %.. Estimation des statistiques
R = EstimeCov(sig_cap,T,L,N);
      
%.. Estimation of the noise-eigenvectors
[u,s,v] = svd(R);
Pi  = u(:,L*N-Nb+1:L*N);
      
%... algorithme MNS: Estimation of the channel filter up to a cte matrix
%
H_init = multi_fss(can,Pi,L,N,M,p); 
        
end