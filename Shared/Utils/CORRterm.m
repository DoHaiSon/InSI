function LEgamma=CORRterm(gammas,i,SOScomplete)
%        LEgamma=CORRterm(gammas,i,SOScomplete) : c-square gamma(i)
% gammas=[r(0)...r(M)], M not necesaarily the channel order <<<
% SOScomplete =1 iff M is the exact channel order

junk    = size(gammas);
c       = junk(1);
M       = junk(2)/c-1;
if SOScomplete && i>M 
    LEgamma = zeros(c,c);
end

if abs(i)>M 
    LEgamma=zeros(c,c);
else        
    LEgamma=gammas*kron(eVCT(M+1,abs(i)+1),eye(c));
    if i<0 
        LEgamma=LEgamma';
    end
end