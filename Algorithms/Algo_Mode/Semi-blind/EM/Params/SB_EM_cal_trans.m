    % calcule le tableau des transition pour un alphabet et une dimension donnes
%
% SYNTAXE trans=cal_trans(alphabet,dim)
%
% alphabet : vecteur complexe des valeurs effectives de l'alphabet
% dim : dimension du vecteur de transition
%
% trans : tableau des transition

function trans = SB_EM_cal_trans(alphabet,dim)

P=max(size(alphabet));
M=dim/2-1;
taille=P^dim;
for it=1:taille
  x=it-1;
  y=taille;
  for il=1:dim
    y=y/P;
    ind=fix(x/y);
    trans(il,it)=alphabet(ind+1);
    x=x-ind*y;
  end
end

end