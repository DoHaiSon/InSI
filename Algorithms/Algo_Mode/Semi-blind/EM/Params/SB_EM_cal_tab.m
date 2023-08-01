% calcul et stock les densites de proba gaussienne aux points (Yt_HEn)
%
% SYNTAXE tab=cal_tab(sig_cap,trans,H,sigma)
%
% sig_cap : tableau des signaux recus par les capteurs
% trans : tableau ((M+1) X P^(M+1)) des transitions
% H : la matrice de filtrage
% sigma : la puissance du bruit blanc
%
% sortie : tab=tableau (T X taille) de toutes les densites de proba
% taille : nbr de transitions
% T : taille de l'echantillon

function tab = SB_EM_cal_tab(sig_cap,trans,H,sigma)
%
%... calcul du nombre d'observations T et du nombre de capterus L 
%
T = max(size(sig_cap));
L = min(size(sig_cap));
A = zeros(L,T);
taille = max(size(trans));
Htrans = H*trans;
for itrans = 1:taille
 for icap = 1:L,
    A(icap,:) = sig_cap(:,icap).'-Htrans(icap,itrans);
 end
 tab(:,itrans) = real((1/pi/sigma)^L*exp(- sum(A.*conj(A),1).'/sigma));
end
clear A 
