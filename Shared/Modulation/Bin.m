% Generation of a Phase modulation 2 constellation (standard samples at 1)
%
% T = number of samples to generate     
%
function sig= Binary(T)

sig= sign(rand(T,1)-0.5);

