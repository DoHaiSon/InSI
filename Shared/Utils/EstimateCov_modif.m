function [R,Xn] = EstimateCov_modif(sig_cap,T,q,N)

% script EstimeCov.m: estimation de la matrice de covariance
% spatio-temporelle avec 0 decalage temporels
% Syntaxe R = EstimeCov(sig_cap,T,L,N)
% Entrees
%         sig_cap = signaux capteurs
%         T = nombre d'echantillons des signaux
%         q = nombre de capteurs
%         N = taille des snapshots sur chaque capteur
% Sorties
%         R = matrice de covariance spatio-temporelle (dimension LN x LN)

%
%... verification des entrees
%
if (size(sig_cap) ~= [T q])
    error('Taille des signaux incompatibles avec les parametres');
end
%
%... Calcul des covariances
%
R = zeros(q*N);
Xn = [];
for t=1:T-N+1
    x=sig_cap(t+N-1:-1:t,:);
    x = x.';
    y = x(:);
    Xn = [Xn y];
    R = R + y*y';
end

R = (1/(T-N+1))*R;