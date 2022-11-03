function W = supereig(y)
% function W = supereig(y)
%
% from y = [y1 ... y_d1], where yi : d*d,
% find lambda_ij s.t. lambda_i1 y1 + ... + lambda_id yd = w_i' w_i (rank 1)

% Alle-Jan van der Veen, Stanford Univ, April 1994
% allejan@isl.stanford.edu


[d,d2] = size(y);

if d2==0
   W=[];
   return
end

d1=d2/d;

% INIT
Q = eye(d,d);
Z = eye(d,d);

% if d1 > 2, use QZ of Y1 and Y2 to initialize
if d1 > 1
    y1 = y(:,1:d);
    y2 = y(:,d+1:2*d);
    [AA,BB,Q,Z,V] = qz(y1,y2);
end

r = y;

err2=0;
for i=1:d1				% apply Q and Z to r
    yi = y(:,d*(i-1)+1:d*i);
    ri = Q*yi*Z;
    r(:,d*(i-1)+1:d*i) = ri;
    err2 = err2 + norm(tril(ri,-1),'fro')^2;
end

%disp('---err2 indicates convergence of QZ iteration:')
% Do a generalized QZ iteration, with SVD in inner loop
for k=1:5
    q = eye(d,d);
    for i=1:d-1		% minimize below-diag norm of ri, using Q
	    p = q*r;
	    p = p(i:d,i:d:d2);
	    [u,s,v]=svd(p);
	    q(i:d,:) = u'*q(i:d,:);
    end
    r = q*r;
    Q = q*Q;

    z = eye(d,d);
    for i=d:-1:2		% minimize below-diag norm of ri, using Z
	p = unvec(r(i,:)',d1)';
	p = p*z;
	p = p(:,1:i);
	[u,s,v]=svd(p);
	z(:,1:i) = z(:,1:i)*reverse(v);
    end
    Z = Z*z;
    err2 = 0;
    for i=1:d1			% apply q and z to y
	    yi = y(:,d*(i-1)+1:d*i);
	    ri = Q*yi*Z;
	    r(:,d*(i-1)+1:d*i) = ri;
	    err2 = err2 + norm(tril(ri,-1),'fro')^2;
    end
    %err2	% show convergence
end


% r = [r1 ... r_d1] is st  yi = Q ri Z, with ri approx upper triang

R = [];
for i = 1:d1
  ri = r(:,d*(i-1)+1:d*i);
  R = [R; diag(ri).'];
end

if d1<d
    % select cols of R with largest norm
    normR =  diag(R'*R);
    [nn,index]=sort(normR);
    R=R(:,index(d-d1+1:d));
end
L = pinv(R);

% factor lambda_i1 y1 + ... + lambda_id yd = w_i' w_i,
% then s_i = w_i * V1 are the CM signals
% disp('---Show how close  lin combination of Y_k is to rank 1:')
W = [];
sing = [];
for i = 1:size(L,1)
    LYi = zeros(d,d);
    for j = 1:d1
      LYi = LYi + L(i,j)*y(:,d*(j-1)+1:d*j);
    end
    [u,s,v] = svd(LYi);		% if no noise, LYi = w_i' w_i (rank 1)
    sing(i)=s(1,1);
    % diag(s)'			% indicates how close LYi is to rank 1
    w = u(:,1)';
    W = [W;w];
end