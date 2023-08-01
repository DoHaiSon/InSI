function mat = SB_EM_transitions(alphabet, dim )

P = length(alphabet);
taille = P^dim;
mat = zeros(dim,taille);
for il = 1:dim
   for x = 1:P^il
       mat(il,(x-1)*P^(dim-il)+1:x*P^(dim-il))=alphabet(mod(x-1,P)+1); 
   end
end

end