function [Q,Y] = cal_Y(sig_src,M)
% calcul de la forme quadratique associe au critere cr.
%
% SYNTAXE: Q = cal_Y(sig_src,M);
%
% Q: la matrice de la forme quadratique
%
% M: degres des canaux
% sig_src: observations T x q

[T,q]   = size(sig_src);

x       = hankel(sig_src(:,1));
Y1      = x(1:T-M,1+M:-1:1);
Han     = Y1;

x       = hankel(sig_src(:,2));
Y       = [x(1:T-M,1+M:-1:1), -Y1];
Han     = [Han;x(1:T-M,1+M:-1:1)];

if q > 2
    for ii=3:q
        x = hankel(sig_src(:,ii));
        x = x(1:T-M,1+M:-1:1);
        nb_row = length(Y(:,1));
        X = kron(eye(ii-1),x);
        Y = [Y,zeros(nb_row,M+1);X,-Han];
        Han = [Han; x];
    end
end
Q       = Y'*Y;