% Calcule le tableau des successeurs associes a chaque etat
%
% SYNTAXE  success = successeur(P,M)
%
% P : est la taille de l'alphabet
% M : est la dimension du vecteur d'etat
%
% sortie : success est un tableau (P^M X P) tq a chaque etat (indice ligne)
% on lui associe ses successeurs (indices colonnes)

function success = SB_EM_successeur(P,M,Nt)

taille=P^(Nt*M);
x=P^(Nt*(M-1));
success=zeros(taille,P^Nt);
for il=1:taille
  for ic=1:P^Nt
   success(il,ic)=fix((il-1)/(P^Nt))+(ic-1)*x+1;  
  end
end

end