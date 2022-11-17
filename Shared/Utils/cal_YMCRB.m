function Q = cal_YMCRB(sig_src,M)
% Syntaxe  Q = cal_YMCRB(sig_src,M)
%
% Input
%
% sig_src:  observations table of dimension T x q
% M : filter degre
%
% Output
%
% Q: is a  (M+1)q x q(M+1)  matrix. exp if sig_src=[y1  y2 y3]
% then Q=X.X^H where X =[-Y2; Y1; 0 ,  0; -Y3; Y2; -Y3, 0, Y1] where Yi is a  (M+1)x(T-M)
% hankel matrix.

[T,q]   = size(sig_src);

Hii_1   = hankel(sig_src(:,1));
x       = Hii_1(1:T-M,1+M:-1:1);
x0      = x;
Hii     = hankel(sig_src(:,2));
y       = Hii(1:T-M,1+M:-1:1);
Y       = [-y,x, zeros(T-M,(q-2)*(M+1))];

for ii=3:q
    Hii_1 = Hii;
    x     = Hii_1(1:T-M,1+M:-1:1);
    Hii   = hankel(sig_src(:,ii));
    y     = Hii(1:T-M,1+M:-1:1);
    Y     = [Y;[zeros(T-M,(ii-2)*(M+1)),-y,x,zeros(T-M,(q-ii)*(M+1))]];
end

D       = kron(diag([1;ones(q-2,1)/sqrt(2);1]),eye(M+1));
Q       = D*Y'*Y*D;