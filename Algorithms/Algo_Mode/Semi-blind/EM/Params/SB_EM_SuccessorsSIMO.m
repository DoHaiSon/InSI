function [SuccessorsDec,Successors] = SB_EM_SuccessorsSIMO( S ,P, M )

% state S = [s1 s2 ... sM] = [s(t-1) s(t-2)...s(t-M)]
% successors of state S are of type [x s1 ... sM-1] where
% x takes all possible alphabets

NumbSucc = P;
Successors = zeros(M,NumbSucc); % in P base
SuccessorsDec = zeros(1,NumbSucc); % in decimal base

x = (dec2base(S-1,P,M))';
ys = zeros(M,1);
for j = 1:M
   ys(j,1) = str2double(x(j,1));
end

for i = 1:NumbSucc
Successors(:,i) = [i-1;ys(1:end-1)];
end

for i=1:NumbSucc
 A = Successors(:,i)';
 B = sum(A.*(10.^(numel(A)-1:-1:0)));   
 x = num2str(B);
 SuccessorsDec(1,i)= base2dec(x,P)+1;   
end
%SuccessorsDec

end