
%.... Generation d'une constellation MDP4 (echantillons normes a 1)
%
%     T = nombre d'echantillons a generer     
%-
function sig= mdp4(T);
%rand('seed',1234)
i= sqrt(-1);
sig= (sign(rand(T,1)-0.5) + i*sign(rand(T,1)-0.5))/sqrt(2);

