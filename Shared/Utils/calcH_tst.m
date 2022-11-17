function [Taux_N, Taux_N_v]= calcH_tst(Mat_can,p,Mat_ins,N)

%  script: CalcH.m
%  C'est une fonction qui calcule la 
%	Matrice Sylvester + une base orth. a canal
%  
%  syntaxe: [Tau_N , Taux_N_v]= calcH(Mat_can,p,Mat_ins,N)
%
%  Input: 
%    
%	Mat_can = c'est la matrice de canal, ici H1,1= H1,2
%	p = Nb. de sources
%	Mat_ins = Matrice a inserer
%	N = contient les elements de taille de canal pour chaque etape
%
%  Output: 
%    
%	Tau_H = Sylvester matrix ontenu a partir du canal
%	Taux_N_v = Sylvester matrix ontenu a partir du espace orthogonal 

[q,L] = size(Mat_can);

%On obtient le nb des capteurs et le degre+1

last_N = length(N);
etape = last_N - 1;


Taux_N = [];
Taux_N_v_tmp = [];
Taux_N_v = [];

% ... calcul de matrice sylvester can


for index = 1:q

    Taux_tmp = gallery('circul', [Mat_can(index,:) zeros(1,N(last_N)-1)]);
    Taux = Taux_tmp(1:N(last_N),:);
    result = repmat(Taux,1,p);
    Taux_N = [Taux_N; result];

end

% ... calcul de matrice sylvester orth_can

if ~length(Mat_ins)
    Taux_N_v = zeros(1,1);

else


    for l = 0: (etape-1)

        Taux_N_v_tmp = [];
        vect = reshape(Mat_ins(:,l+1),N(last_N),q);
        vect_1 = [vect; zeros(N(l+1)-1,q)];
        if (N(last_N) ~= 1)

            for ii = 1:q
    			vect_2 = gallery('circul', vect_1(:,ii));
    			result_v = vect_2(1:N(last_N),:);
    			Taux_N_v_tmp = [Taux_N_v_tmp; result_v];
            end %end of q

            Taux_N_v = [Taux_N_v Taux_N_v_tmp];
        else
            Taux_N_v = Mat_ins;

        end %end of last_N

    end %end of etape

end %end of if