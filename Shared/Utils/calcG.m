function G = calcG(canaux, N)

% calcule la matrice G_N(h)^H des vecteurs bruit.
%
% SYNTAXE : G = calcG(canaux, N);
%
% N : Taille de la fenetre temporelle
% canaux : coefficients des canaux (tableau q x (M+1))
%
% G : Matrice des vecteurs engendrant le ss espace bruit

[q,M]=size(canaux);
M=M-1;
H1= calcH(canaux(1,:),1,M,N-M);
H2= calcH(canaux(2,:),1,M,N-M);
G=[-H2, H1];
H=[H1;H2];

if q > 2
    for ii=3:q
        Hii=  calcH(canaux(ii,:),1,M,N-M);
        X=kron(eye(ii-1), Hii);
        [nb_row,nb_col]=size(G);
        G=[G, zeros(nb_row,N);-X,H];
        H=[H;Hii];
    end
end