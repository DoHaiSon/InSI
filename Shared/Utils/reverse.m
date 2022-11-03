function X=reverse(x)
% function X=reverse(x)		(in ~allejan/matlab)
% form reverse vector. When used on matrices, flip the matrix along
% vertical axis

X=zeros(size(x));
[n m]=size(x);

if ((m==1) & (n > 1))
     X = reverse(x')';
else 
    for i=1:m
	 X(:,m-i+1) = x(:,i);
    end
end