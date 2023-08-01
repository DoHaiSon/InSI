% calcul iteratif de l'inverse de la matrice K = sigma*I+sum_{k} h_k*h_k^{T}

function K_1 = SB_EM_cal_K(sigma,can,T)

%%%% degres des filtres
M = length(can(1,:))-1;
%%%% nombre de canaux
L = length(can(:,1));
h=can(:);
K_1 = (1/sigma)*eye(T*L);


for ind=1:M
  k=h(L*(M+1-ind)+1:L*(M+1));
  il = 1:ind*L;
  x=K_1(:,il)*k;
  K_1 = K_1 - (x/(1+k'*x(il)))*x';
end


for ind=M+1:T
  il = (ind-M-1)*L+1:ind*L;
  x=K_1(:,il)*h;
  K_1 = K_1 - (x/(1+h'*x(il)))*x';
end;

for ind=T+1:T+M
  k = h(1:(M+1+T-ind)*L);
  il = (ind-M-1)*L+1:L*T;
  x=K_1(:,il)*k;
  K_1 = K_1 - (x/(1+k'*x(il)))*x';
end;
  
  

