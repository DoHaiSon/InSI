function noiseng=noisengFROMSOS(c,R,m)
%        noiseng=noisengFROMSOS(c,R,m)
% R : cl-square (l+m)-rank std correl mtx Herm
% m : detected channel order
% 
% noiseng = mean of EVD

lncol=size(R);

if R~=R'
    input('noisengFROMSOS error 0');
    exit;
end

if lncol(1)~=lncol(2)
    input('noisengFROMSOS error 1');
    exit;
end

l=lncol(1)/c;

if floor(l)~=l
    input('noisengFROMSOS error 2');
    exit;
end

if c*l==l+m                 
    input('noisengFROMSOS error 3');
    exit;
end

noiseDIM=c*l-l-m;

[vct,val]=XEIG(R,noiseDIM,1);

noiseng=sum(val)/noiseDIM;