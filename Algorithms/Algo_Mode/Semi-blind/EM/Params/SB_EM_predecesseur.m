% Calcule le tableau des predecesseurs associes a chaque etat
%
% SYNTAXE  predess = predecesseur(P,M)
%
% P : est la taille de l'alphabet
% M : est la dimension du vecteur d'etat
%
% sortie : predess est un tableau (P^M X P) tq a chaque etat (indice ligne)
% on lui associe ses predecesseurs (indices colonnes)

function predess = SB_EM_predecesseur(P,M,Nt)

taille=P^(Nt*M);
x=P^(Nt*(M-1));
predess=zeros(taille,P^Nt);
for il=1:taille
  for ic=1:P^Nt
   y=il-1-fix((il-1)/x)*x;
   predess(il,ic)=y*(P^Nt)+ic;  
  end
end

end