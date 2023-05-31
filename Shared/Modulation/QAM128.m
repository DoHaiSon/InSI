% Generation of a QAM 128 constellation (standard samples at 1) 
%
% T = number of samples to generate 
%
function [sig, data] = QAM128(T)
    %rand('seed',1234)
    data = randi([0 127], T, 1);
    sig  = qammod(data, 128);
end