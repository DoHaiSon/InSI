function [Trans,y] = SB_EM_FindTransitionsPred(s1,s2,M, P )

% find the transitions vector : x(t)=s1 and x(t+1) = s2
% s1(t) ---> s1(t+1)=s2  s1 contains the predeccessors of s2

l=length(s1);
x2 =(dec2base(s2-1,P,M))';
for i=1:l
x1(:,i) =(dec2base(s1(i)-1,P,M))';
end

x=[];
for i=1:l
x=[x [x2(1);x1(:,i)]];
end
%x = [x2(1);x1];
for i=1:l
for j=1:M+1
   y(j,i)= str2double(x(j,i));
end
end
y=y';
Trans=zeros(1,l);
for i=1:l
 B = sum(y(i,:).*(10.^(numel(y(i,:))-1:-1:0)));   
 xx = num2str(B);
 Trans(1,i) = base2dec(xx,P)+1;  
end

end