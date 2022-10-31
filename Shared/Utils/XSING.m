function [vct,val]=XSING(X,nb,left,lowest)
%        [vct,val]=XSING(X,nb,left,lowest)
% extreme singular vct and val x=[x1 .. xnb]
% xi are vct sing associated 
% to the lowest nb val sing x1<..<xnb
%        largest ...        x1>..>xnb
% they are left sing if left==1

if left~=0 && left~=1 
    input('XSING error 1');
    exit;
end

if nb<=0           
    input('XSING error 2');
    exit;
end

[leftsingvct,val,rightsingvct] = svd(X);
dimX=size(X);

if left==1 
    vct=sortrows([[diag(val); 0*(1:dimX(1)-max(size(diag(val))))']  leftsingvct'],1);
    dimvct=dimX(1);
else       
    vct=sortrows([[diag(val);0*(1:dimX(2)-max(size(diag(val))))'] rightsingvct'],1);
    dimvct=dimX(2);
end

if lowest 
    val=vct(1:nb,1);
    vct=vct(1:nb,2:dimvct+1)';
else      
    val=vct(dimX:-1:dimX+1-nb,1);
    vct=vct(dimX:-1:dimX+1-nb,2:dimvct+1)';
end