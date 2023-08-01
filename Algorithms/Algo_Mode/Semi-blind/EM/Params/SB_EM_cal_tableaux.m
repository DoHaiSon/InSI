% Calcul des expressions :
%
% hj'*Ki^(-1)hj , i<=j<=i+M -------> tab1
%
% hi'*Ki^(-1)hj , i<=j<=i+M -------> tab2
%
% hj'*Ki^(-1)y ,  i<=j<=i+M -------> tab3
%
% SYNTAXE [tab1,tak2,tab3] = cal_tableaux(sigma,can,K_1,sig_cap);
%
% can : estimee initiale des coefficients des canaux
% sigma : estimmee initiale de la puissance du bruit
% K_1 : inverse de la matrice K = sigma*I+sum_{k} h_k*h_k^{T}
% sig_cap : tableau des signaux recus par les capteurs

function [tab1,tab2,tab3] = SB_EM_cal_tableaux(sigma,can,K_1,sig_cap)

%%%% degres des filtres
M = length(can(1,:))-1;
%%%% nombre de canaux
L = length(can(:,1));
%%%% Nombre d'echantillons
T = length(sig_cap(:,1));
h = can(:);
tmp = sig_cap.';
y = tmp (:);


for ind1 = 1 : T+M
%%%% calcul de h_i
  if (ind1<=M),
   hi = h(L*(M+1-ind1)+1:L*(M+1));
   il = 1:ind1*L;
  elseif(M<ind1 & ind1<=T),
   hi=h;
   il = (ind1-M-1)*L+1:ind1*L;
  else
   hi = h(1:(M+1+T-ind1)*L);
   il = (ind1-M-1)*L+1:L*T;
  end;
  x0=hi'*K_1(il,il)*hi;
  %x4=hi'*K_1(il,:)*y;
%%%%Boucle sur j
  for ind2=ind1:min(ind1+M,T+M)
%%%% calcul de hj
   if (ind2<=M),
    hj = h(L*(M+1-ind2)+1:L*(M+1));
    jl = 1:ind2*L;
   elseif(M<ind2 & ind2<=T),
    hj=h;
    jl = (ind2-M-1)*L+1:ind2*L;
   else
    hj = h(1:(M+1+T-ind2)*L);
    jl = (ind2-M-1)*L+1:L*T;
   end;
   x1=hj'*K_1(jl,jl)*hj;
   x2=hi'*K_1(il,jl)*hj;
   x3=hj'*K_1(jl,:)*y;
   if (ind2==ind1), x4=x3; end;
   
  
%%%% Calcul des tableaux tab1, tab2 et tab3
   tab1(ind1,ind2-ind1+1) = x1 + abs(x2)^2/(1-x0);
   tab2(ind1,ind2-ind1+1) = x2/(1-x0);
   tab3(ind1,ind2-ind1+1) = x3 + x2'*x4/(1-x0);
  end;
end;
