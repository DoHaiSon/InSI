% calcul de la fraction rationnelle f^(-1)fi'f^(-1)fj'
% 
% SYNTAXE : [b,a]=cal_frac(sigma,canaux,ipapam,jparam);
%
% entrees :
%          sigma: la puissance du bruit
%          canaux: tableau des coefficients des filtres des differents canaux
%          iparam,jparam: indices des parametres consideres
%
% sorties :
%          b: coefficients du polynome au numerateur
%          a: coefficients du polynome au denominateur

function [b,a] = SB_EM_cal_frac(sigma,canaux,ipapam,jparam);

L = length(canaux(:,1));            %L : taille de l'antenne
M = length(canaux(1,:))-1;          %M : degre des filtres pour chaque canaux 
nb_param=2*L*(M+1)-1;               %nb_param : nombre de parametres a estimer