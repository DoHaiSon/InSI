function Mat=matrice_data(vect,N,M)

% function Mat=matrice_data(vec,L,M)
%   construit une matrice rearrangee d'observations ou d'entrees
%   pour avoir une equation du type matrice_observation=A*matrice_d'entree
%   
%   [capteur1(1) capteur2(1) ... capteurM(1) ..... capteurM(N)]T
% entrees:
%       vect : vecteur de donnees ou d'entree concatenation des vecteurs
%       d'observation aux differents instants
%       M   : nombre d'observations
%       N   : smoothing factor
K=floor(length(vect)/M);

Mat=[];
for jj=1:K-N+1
    Mat=[Mat,vect((jj-1)*M+1:N*M+(jj-1)*M)];
end