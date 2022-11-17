function M = Hae(gamma)

lncol=size(gamma);
c=lncol(1);
m=lncol(2)/c-1;
if floor(m)~=m 
    input('Hae error 1');
    exit;
end

M=zeros(c*(m+1),c*(m+1));
M(1:c,:)=gamma;

for bigln =[c*(1:m            )+1]
    for bigcol=[c*(0:m-(bigln-1)/c)+1]
        M(bigln  :bigln+c-1,bigcol  :bigcol+  c-1)= ...
            M(bigln-c:bigln  -1,bigcol+c:bigcol+2*c-1);
    end
end