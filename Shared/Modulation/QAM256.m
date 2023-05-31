% Generation of a QAM 256 constellation (standard samples at 1) 
%
% T = number of samples to generate 
%
function [sig, data] = QAM256(T)
    %rand('seed',1234)
    data = randi([0 255], T, 1);
    sig  = qammod(data, 256);
end