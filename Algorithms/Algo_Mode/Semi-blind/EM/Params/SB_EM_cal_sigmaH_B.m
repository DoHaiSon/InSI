% calcul des reestimees de la matrice H et de la puissance de bruit sigma
%
% SYNTAXE [sigma,H]=cal_sigmaH(proba,sig_cap,trans)
%
% proba : tableau des densites de probabilites L(Y,Xt=En)
% sig_cap : signaux capteurs
% trans : tableau ((M+1) X P^(M+1)) des transitions
% M : degres des filtres
% P : taille de l'alphabet
%
% H : la reestimee de la matrice de filtrage
% sigma : la reestimee de la puissance du bruit

function [sigma,H] = SB_EM_cal_sigmaH_B(proba,sig_cap,trans,Nt)

T = max(size(sig_cap));
L = min(size(sig_cap));
M = min(size(trans))/(Nt*2)-1;
nb_trans = max(size(trans));
%Np = size(pilots,2);

%% ...normalization des probabilités
 for i=1:size(proba,2)
    proba(:,i)=proba(:,i)/sum(proba(:,i)); 
 end
 
%... vraisemblance de l'observation pour les parametres courants
%
Likelihood = sum(proba(:,1));
coeff = sum(proba.');

Rxx = zeros(Nt*2*(M+1));
Rxy = zeros(Nt*2*(M+1),L);
Ryy = zeros(L);

Ryy = Likelihood*sig_cap.'*conj(sig_cap);
%Rxx=trans*diag(sum(proba.'))*trans';
for n = 1:nb_trans 
  Rxx = Rxx+coeff(n)*trans(:,n)*trans(:,n)';
      x = trans(:,n);  
  for icap = 1:L,
      D(icap,:) = sig_cap(:,icap).'.*proba(n,:);
  end
  Rxy = Rxy + x*sum(D');
end
Ryx = Rxy';
fact = sum(proba(:,1))*L;
%% ... pilots
%Rxx_pilot = zeros(Nt*2*(M+1));
%Ryx_pilot = zeros(L,Nt*2*(M+1));
%Np = size(pilots,2);
%for i=1:Np
%  Rxx_pilot = Rxx_pilot + pilots(:,i)*pilots(:,i)'; 
%  Ryx_pilot = Ryx_pilot + sigcap_pilot(:,i)*pilots(:,i)'; 
%end
%% ...
H = (Ryx)*pinv(Rxx);

sigma = trace(Ryy-H*Rxy)/fact/T;
