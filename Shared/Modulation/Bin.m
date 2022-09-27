% Generation of a Phase modulation 2 constellation (standard samples at 1)
%
% T = number of samples to generate     
%
function [sig, data]= Bin(T)
    
    data = ones(T, 1);
    sig  = sign(rand(T,1)-0.5);
    
    data = data == sig;