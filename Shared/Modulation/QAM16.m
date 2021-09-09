% Generation of a QAM 16 constellation (standard samples at 1) 
%
% T = number of samples to generate 
%
function sig= QAM16(T);
%rand('seed',1234)
i= sqrt(-1);
cons=[1+i,3+i,1+(3*i),3+(3*i),-1+i,-3+i,-1+(3*i),-3+(3*i),1-i,3-i,1-(3*i),3-(3*i),-1-i,-3-i,-1-(3*i),-3-(3*i)];
cons=cons/sqrt(10);
sig=randsrc(T,1,cons);

