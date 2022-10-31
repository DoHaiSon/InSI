function J=Jmtx(l)
%          Jmtx(l)

J=[(1:1:l-1)'*0 eye(l-1)
              0 (1:1:l-1)*0];
