%.... Generation d'une constellation MDP4 (echantillons normes a 1)
%
%     T = nombre d'echantillons a generer     
%-
function sig= mdp4(T);
%rand('seed',1234)
i= sqrt(-1);
cons=[1+i,3+i,1+(3*i),3+(3*i),-1+i,-3+i,-1+(3*i),-3+(3*i),1-i,3-i,1-(3*i),3-(3*i),-1-i,-3-i,-1-(3*i),-3-(3*i)];
cons=cons/sqrt(10);
sig=randsrc(T,1,cons);

