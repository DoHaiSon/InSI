
%.... Generation d'une constellation MDP4 (echantillons normes a 1)
%
%     T = nombre d'echantillons a generer     
%-
function sig= mdp2(T);

sig= sign(rand(T,1)-0.5);

