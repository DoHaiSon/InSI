function  [PredecessorsDec,Predecessors] = SB_EM_PredecessorsSIMO( S ,P, M )

% state S = [s1 s2 ... sM] = [s(t-1) s(t-2)...s(t-M)]
% predecessors of state S are of type [s2... sM x] where
% x takes all possible alphabets

NumbPredc = P;
Predecessors = zeros(M,NumbPredc); % in P base
PredecessorsDec = zeros(1,NumbPredc); % in decimal base

x = (dec2base(S-1,P,M))'; %conversion of state's value to P base 
yp = zeros(M,1);
for j = 1:M
   yp(j) = str2double(x(j,1));
end

for i = 1:NumbPredc
    Predecessors(:,i) = [yp(2:end);i-1];
end
% convertion to decimal base
for i=1:NumbPredc
 A = Predecessors(:,i)';
 B = sum(A.*(10.^(numel(A)-1:-1:0)));   
 x = num2str(B);
 PredecessorsDec(1,i)= base2dec(x,P)+1;   
end

end