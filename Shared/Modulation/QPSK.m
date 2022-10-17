% Generation of a QPSK (standard samples at 1)
%
% T = number of samples to generate     
%
function [sig, data] = QPSK(T)
    %rand('seed',1234)
    data = randi([0 3], T, 1);
    sig  = pskmod(data, 4, pi/4);
end
