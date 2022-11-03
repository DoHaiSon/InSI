function V = unvec(v,n)
% function V = unvec(v,n)
%
% form matrix V from col vector v, where V has n columns.
% If n is not specified, V is made square

[m,N] = size(v);
if (nargin == 1)
   n = sqrt(m);
end

m = m/n;
V = zeros(m,n);
for i = 0:n-1
    V(:,i+1) = v(i*m+1:i*m+m);
end
