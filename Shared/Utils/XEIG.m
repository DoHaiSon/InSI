function [vct,val]=XEIG(X,nb,lowest)
%        [vct,val]=XEIG(X,nb,lowest)
% extreme eigen vct and val x=[x1 .. xnb]
% xi are vct prop associated 
% to the lowest nb val prop x1<..<xnb
%        largest ...        x1>..>xnb
% of the hermitian X (so that eigen vct/val are real)

if nb<=0             
    input('XEIG error 1');
    exit;
end

if size(X)~=size(X') 
    input('XEIG error 1');
    exit;
end

dimX=max(size(X));

[vct,val]=eig(X);

vct=sortrows([real(diag(val)) vct'],1);

if lowest 
    val=vct(1:nb, 1);
    vct=vct(1:nb,2:dimX+1)';
else      
    val=vct(dimX:-1:dimX+1-nb,1);
    vct=vct(dimX:-1:dimX+1-nb,2:dimX+1)';
end
%[vct,val]=XSING(X,nb,1,lowest);