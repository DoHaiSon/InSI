% calcule le tableau des transition pour un alphabet et une dimension donnes
%
% SYNTAXE trans=cal_trans(alphabet,dim)
%
% alphabet : vecteur complexe des valeurs effectives de l'alphabet
% dim : dimension du vecteur de transition
%
% trans : tableau des transition

function trans = SB_EM_cal_trans2(alphabet,M, Nt)

P = max(size(alphabet));
taille = P^(Nt*(M+1));

trans = zeros(Nt*(M+1),taille);
 for i=1:taille
trans(:,i)= Dec2Alphabet( i, alphabet, Nt*(M+1) );
end


end
