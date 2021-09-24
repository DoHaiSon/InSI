% Generation of a Gaussian constellation (standard samples at 1)
%
% T = number of samples to generate     
%

function sig= Gauss(T)

sig = (randn(T,1)+1j*randn(T,1))/sqrt(2);
