function [TransDec,Trans1] = SB_EM_FindTransitionsPredMIMO(s1,s2,M, P, Nt )

% find the transitions vector : x(t)=s1 and x(t+1) = s2
% s1(t) ---> s1(t+1)=s2  s1 contains the predeccessors of s2

x2 = (dec2base(s2-1,P,Nt*M))'; %conversion of state's value to P base 

l=length(s1);
for i=1:l
x1(:,i) =(dec2base(s1(i)-1,P,Nt*M))';
end
x21=x2(1:end/Nt);
x22=x2(end/Nt+1:end);

for i=1:l
   x11(:,i)= x1(1:end/Nt,i);
   x12(:,i)= x1(end/Nt+1:end,i);
end

for j=1:M
    y21(j,1)=str2double(x21(j));
    y22(j,1)=str2double(x22(j));
for i=1:l
    y11(j,i)= str2double(x11(j,i));
    y12(j,i)= str2double(x12(j,i));
end
end
y11=y11';
y12=y12';
y21=y21';
y22=y22';

 B = sum(y21.*(10.^(numel(y21)-1:-1:0)));   
 xx = num2str(B);
 xx21 = base2dec(xx,P)+1; 
 
 B = sum(y22.*(10.^(numel(y22)-1:-1:0)));   
 xx = num2str(B);
 xx22 = base2dec(xx,P)+1; 

for i=1:l
 B = sum(y11(i,:).*(10.^(numel(y11(i,:))-1:-1:0)));   
 xx = num2str(B);
 xx11(1,i) = base2dec(xx,P)+1;
 
 B = sum(y12(i,:).*(10.^(numel(y12(i,:))-1:-1:0)));   
 xx = num2str(B);
 xx12(1,i) = base2dec(xx,P)+1;
end

[Tr1Dec,Tr1]= SB_EM_FindTransitionsPred(xx11,xx21,M, P );
[Tr2Dec,Tr2]= SB_EM_FindTransitionsPred(xx12,xx22,M, P );

Trans1 = [Tr1';Tr2'];

Trans1 = Trans1';
TransDec = zeros(l,1);
for i=1:l
B = sum(Trans1(i,:).*(10.^(numel(Trans1(i,:))-1:-1:0)));   
 xx = num2str(B);
 TransDec(i,1) = base2dec(xx,P)+1;
end
TransDec = TransDec';
Trans1 = Trans1';

end