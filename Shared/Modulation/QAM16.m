% Generation of a QAM 16 constellation (standard samples at 1) 
%
% T = number of samples to generate 
%
function [sig, data] = QAM16(T)
    %rand('seed',1234)
    data = randi([0 3], T, 1);
    sig  = qammod(data, 16);
end