function R=CORRshift(l,k,gammas,outputspc)
%        R=CORRshift(l,k,gammas,outputspc)
% R is down-shifted (by k sub-blocks) cl-square
% if an error happens, that (probably) means that
% gammas does not contain all gamma necessary
% to built up the desired correlation

lncol=size(gammas);c=lncol(1);
for bigrow=0:l-1
    for bigcol=0:l-1
        R(c*(bigrow)+1:c*(bigrow)+c,c*(bigcol)+1:c*(bigcol)+c)=CORRterm(gammas,k+bigcol-bigrow,1);
    end
end

if outputspc==2 
    K=Kmtx(c,l);
    R=K*R*K';
end