% calcul des reestimees de la matrice H et de la puissance de bruit sigma
%
% SYNTAXE [sigma,H]=cal_param(proba,sig_cap,trans)
%
% prob_red : tableau des plus forte densites de probabilites L(Y,Xt=En)
% sig_cap : signaux capteurs
% trans : tableau ((M+1) X P^(M+1)) des transitions
% selec_trans : tableau des transitions selectionnees (celles de plus forte proba)
% M : degres des filtres
% P : taille de l'alphabet
%
% H : la reestimee de la matrice de filtrage
% sigma : la reestimee de la puissance du bruit

function [sigma,H] = SB_EM_cal_param(prob_red,sig_cap,trans,selec_trans)


L=min(size(sig_cap));
M=min(size(trans))-1;
[nbtr,T]=size(selec_trans);
%
%... vraisemblance approximee de l'observation pour les parametres courants
%
Likelihood= sum(prob_red(:,1));

Rxx=zeros(M+1);
Rxy=zeros(M+1,L);
Ryy=zeros(L);

Ryy=Likelihood*sig_cap.'*conj(sig_cap);
for t=1:T
   slice=selec_trans(:,t);
   Rxx=Rxx+trans(:,slice)*diag(prob_red(:,t))*trans(:,slice)';
   for icap=1:L
     x=trans(:,slice)*diag(prob_red(:,t))*conj(sig_cap(t,L));
     Rxy(:,icap)=Rxy(:,icap)+sum(x.').';
   end
end   
Ryx=Rxy';

H=Ryx*inv(Rxx);
sigma=trace(Ryy-H*Rxy)/(Likelihood*T*L);
