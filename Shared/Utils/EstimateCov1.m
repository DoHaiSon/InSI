function [R,Y]= EstimateCov1(sig_cap, T, L, N)

% script EstimeCov.m: estimation de la matrice de covariance
% spatio-temporelle avec 0 decalage temporels
% Syntaxe R = EstimeCov(sig_cap,T,L,N)
% Entrees
%         sig_cap = signaux capteurs
%         T = nombre d'echantillons des signaux
%         L = nombre de capteurs
%         N = taille des snapshots sur chaque capteur
% Sorties
%         R = matrice de covariance spatio-temporelle (dimension LN x LN)

%
%... verification des entrees
%
if (size(sig_cap) ~= [T L])
    error('Taille des signaux incompatibles avec les parametres');
end
%
%... Calcul des covariances
%
R = zeros(L*N);
Y=[];
for t=1:T-N+1
    x=sig_cap(t+N-1:-1:t,:);
    x=x.';
    y=x(:);
    R=R+y*y';
    Y=[Y,y];
end
R=(1/(T-N+1))*R;