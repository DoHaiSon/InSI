% calcul les densites de probabilite L(Y,Xt=En)
%
% SYNTAXE proba=cal_prob(alpha,beta,tab,P,M,T)
%
% alpha,beta : les tableaux des coefficients alpha et beta.
% tab : tableau des densites normale de proba (aux points (Yt-HEn))
% M : degres des filtres
% P : taille de l'alphabet
% T : taille de l'echantillon
%
% proba : c'est un tableau (P^(M+1) X T) contenant toutes les densites de 
% probabilites.

function proba = SB_EM_cal_prob2(alpha,beta,tab,tableau,P,M,T,Nt)

nb_tran = P^(Nt*(M+1));

for itrans = 1:nb_tran
    proba(itrans,:) = (alpha(tableau(itrans,1),1:T).*beta(tableau(itrans,2),2:T+1).*tab(:,itrans).')/(P^(Nt));
end

