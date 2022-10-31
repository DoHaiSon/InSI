function e=eVCT(dim,pst)
%          eVCT(dim,pst)
% column vector of length 'dim' and with 1 at 'pst' 

if pst>dim 
    input('eVCT error 1');
    exit;
end

for ln=1:dim 
    e(ln,1) = (ln==pst);
end
