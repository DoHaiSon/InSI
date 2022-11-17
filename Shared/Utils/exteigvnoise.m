function [E,sigma]= exteigvnoise(R,M)

%    script: exteignoise.m: extraction des vecteurs propres et la puissance du %bruit 
%    syntaxe: [E,sigma]= exteignoise(R,M)
%    Entree
%       R= matrice (symetrique definie positive)
%       M= nombre de valeurs propres a extraire
%    Sortie
%       E= matrice des vecteurs propres bruit
%       sigma = puissance du bruit

l       = length(R(1,:));
%
%... decomposition en valeurs propres de R
%
[u,s,v] = svd(R);
E       = u(:,l-M+1:l);
sigma   = real( mean(diag(s(l-M+1:l,l-M+1:l))));