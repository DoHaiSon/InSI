function v = vecreal(V)
% function v = vecreal(V)
%
% kronecker vec operation: makes vector out of V
% v = stack of cols of V
% This version: modification to make use of symmetry in V

[m,N]=size(V);

v = zeros(m*N,1);

sqrt2 = sqrt(2);
k=0;
for i = 1:N
    for j = 1:N
       k = k+1;
       if (i==j)
          v(k) = V(i,i);
       elseif (i < j)
          v(k) = real(V(i,j))*sqrt2;
       else
          v(k) = imag(V(j,i))*sqrt2;
       end
    end
end