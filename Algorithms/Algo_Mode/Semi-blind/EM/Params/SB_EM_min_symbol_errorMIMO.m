%  detection des symboles d'information
%
% SYNTAXE estsig_source= min_symbol_error(proba,alphabet,M)
%
%%
% Entree
%   proba : tableau (P^(M+1) X T) contenant toutes la vraisemblance  conditionelle
%   des observations connaissant les transitions a l'instant t
%   M : degres des filtres
%   P : taille de l'alphabet
%   T : taille de l'echantillon
%   alphabet : vecteur complexe des valeurs effectives de l'alphabet
%

function estsig_source= SB_EM_min_symbol_errorMIMO(proba,alphabet,M,Nt)

P=max(size(alphabet));
nb_etat=P^(Nt*(M+1)-1);
T=max(size(proba(1,:)));


symb_prob=zeros(P,T);
estsig_source=zeros(T,1);
%
%%%% calculate of L(Y,At=alpha)
%
for isymb=1:P
    symb_prob(isymb,:)=sum(proba((isymb-1)*nb_etat+1:isymb*nb_etat,:));
end


[~, b] = max(symb_prob);
clear a  symb_prob ;
for it=1:T
    estsig_source(it)=alphabet(b(it));
end

end