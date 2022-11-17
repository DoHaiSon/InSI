function [R,Y]= EstimateCov(X, N, Num_Ch, L)
%
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
    %
    %... verification inputs
    %
    if (size(X) ~= [N Num_Ch])
       error('Shape of signals incompatible with the parameters');
    end
    %
    %... Calcul des covariances 
    %
    R     = zeros(Num_Ch*L);
    Y     = [];
    for t = 1:N-L+1
        x = X(t+L-1:-1:t,:);
        x = x.';
        y = x(:);
        R = R+y*y';
        Y = [Y,y];
    end
    R=(1/(N-L+1))*R;
end