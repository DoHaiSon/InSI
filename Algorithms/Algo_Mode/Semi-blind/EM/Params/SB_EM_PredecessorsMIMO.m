function [PredecessorsDec,tot] = SB_EM_PredecessorsMIMO( S ,P, M, Nt )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here



x = (dec2base(S-1,P,Nt*M))'; %conversion of state's value to P base 
yp = zeros(Nt*M,1);
for j = 1:Nt*M
   yp(j) = str2double(x(j,1));
end
S1 = yp(1:end/Nt,1);
S2 = yp(end/Nt+1:end,1);

 B1 = sum(S1'.*(10.^(numel(S1)-1:-1:0)));   
 x1 = num2str(B1);
 S11= base2dec(x1,P)+1;
 
 B2 = sum(S2'.*(10.^(numel(S2)-1:-1:0)));   
 x2 = num2str(B2);
 S22= base2dec(x2,P)+1;
 
NumbPredc = P^Nt;
PredecessorsDec = zeros(1,NumbPredc);
[~,Pred1] = SB_EM_PredecessorsSIMO( S11 ,P, M) ;

[~,Pred2] = SB_EM_PredecessorsSIMO( S22 ,P, M) ;
tot = [];
for i=1:P

tot = [tot [Pred1;repmat(Pred2(:,i),1,P)]];
end

% conversion to decimal base
for i=1:NumbPredc
 A = tot(:,i)';
 B = sum(A.*(10.^(numel(A)-1:-1:0)));   
 x = num2str(B);
 PredecessorsDec(1,i)= base2dec(x,P)+1;   
end

end