function V = unvecreal(v)
% function V = unvecreal(v)
%
% form matrix V from col vector v, where V has n columns.
% This version: make use of symmetry (inverse of vecreal() )

[m,N] = size(v);
n = sqrt(m);
m = m/n;

Y = zeros(m,n);

for i=1:m
   Y(i,:) = v((i-1)*m+1:i*m)';
end

Y1 = triu(Y,1);
Y2 = tril(Y,-1);
Yd = diag(Y)/sqrt(2);
Y1 = Y1 + diag(Yd);

V = (Y1 + Y1')/sqrt(2) + sqrt(-1)*(Y2' - Y2)/sqrt(2);