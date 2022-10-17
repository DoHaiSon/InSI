% Generation of a Phase modulation 4 constellation (standard samples at 1)
%
% T = number of samples to generate     
%
function [sig, data] = QAM4(T)
    %rand('seed',1234)
    data = randi([0 3], T, 1);
    sig  = qammod(data, 4);
end