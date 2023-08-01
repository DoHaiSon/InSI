% calcule de maniere recursive les tableaux des coefficients alpha et beta.
%
% SYNTAXE [alpha, beta]=alpha_beta(predess,success,tab,M,T)
%
% predess : c'est le tableau des predecesseurs
% success : c'est le tableau des successeurs
% tab : tableau des densites normales de probabilite
% M : degres des filtres
% T : taille d'echantillon
%
% sortie : alpha=tableau (P^M X T+1) des element alpha(i,t)
%        : beta=tableau (P^M X T+1) des element beta(i,t)

function [alpha, beta,Rho] = SB_EM_alpha_beta2(tableau,tab,M,T,Nt,P)


nb_etat = P^(Nt*M);
beta    = zeros(nb_etat,T+1);
alpha   = zeros(nb_etat,T+1);
Rho     = zeros(T+1,1);
alpha(:,1)  = ones(nb_etat,1)/nb_etat;
beta(:,T+1) = ones(nb_etat,1);
Rho(1)      = 1;

%%%%%%% Recursion forward 
for t = 2:T+1
 for il = 1:nb_etat
  itrans = find(tableau(:,2)==il);
  predecessors = tableau(itrans,1);
  alpha(il,t) = tab(t-1,itrans)*alpha(predecessors,t-1)/(P^Nt);
 end
 Rho(t)     = 1/sum(alpha(:,t));
 alpha(:,t) = Rho(t)*alpha(:,t);
end

%%%%%%% Recursion backward
for t = T:-1:1
 for il = 1:nb_etat
  jtrans = find(tableau(:,1)==il);
  successors =  tableau(jtrans,2);
  beta(il,t) = Rho(t)*tab(t,jtrans)*beta(successors,t+1)/(P^Nt);
 end
end
 
