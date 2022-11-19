function R= EstimateCov(sig_rec,num_sq,L,N)

% script EstimateCov.m: estimation de la matrice de covariance
% spatio-temporelle avec 0 decalage temporels
% Syntaxe R = EstimeCov(sig_rec,num_sq,L,N)
% Entrees
%         sig_rec = signaux capteurs
%         num_sq = nombre d'echantillons des signaux
%         L = nombre de capteurs
%         N = taille des snapshots sur chaque capteur
% Sorties
%         R = matrice de covariance spatio-temporelle (dimension LN x LN)

%
%... verification des entrees
%
if (size(sig_rec) ~= [num_sq L])
    error('Taille des signaux incompatibles avec les parametres');
end
%
%... Calcul des covariances
%
R = zeros(L*N);
for t=1:num_sq-N+1
    x=sig_rec(t+N-1:-1:t,:);
    y=x(:);
    R=R+y*y';
end
R=(1/(num_sq-N+1))*R;