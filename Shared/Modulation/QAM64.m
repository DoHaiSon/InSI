% Generation of a QAM 64 constellation (standard samples at 1) 
%
% T = number of samples to generate 
%
function [sig, data] = QAM64(T)
    %rand('seed',1234)
    data = randi([0 63], T, 1);
    sig  = qammod(data, 64);
end