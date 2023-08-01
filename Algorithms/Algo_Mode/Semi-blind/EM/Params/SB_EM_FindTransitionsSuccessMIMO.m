function [TransDec,Trans1] = SB_EM_FindTransitionsSuccessMIMO(s1,s2,M, P, Nt )

% find the transitions vector : x(t)=s1 and x(t+1) = s2
% s1(t) ---> s1(t+1)=s2  s2 contains the successors of s1

x1 = (dec2base(s1-1,P,Nt*M))'; %conversion of state's value to P base 

l=length(s2);
for i=1:l
x2(:,i) =(dec2base(s2(i)-1,P,Nt*M))';
end
x11=x1(1:end/Nt);
x12=x1(end/Nt+1:end);

for i=1:l
   x21(:,i)= x2(1:end/Nt,i);
   x22(:,i)= x2(end/Nt+1:end,i);
end

for j=1:M
    y11(j,1)=str2double(x11(j));
    y12(j,1)=str2double(x12(j));
for i=1:l
    y21(j,i)= str2double(x21(j,i));
    y22(j,i)= str2double(x22(j,i));
end
end
y11=y11';
y12=y12';
y21=y21';
y22=y22';

 B = sum(y11.*(10.^(numel(y11)-1:-1:0)));   
 xx = num2str(B);
 xx11 = base2dec(xx,P)+1; 
 
 B = sum(y12.*(10.^(numel(y12)-1:-1:0)));   
 xx = num2str(B);
 xx12 = base2dec(xx,P)+1; 

for i=1:l
 B = sum(y21(i,:).*(10.^(numel(y21(i,:))-1:-1:0)));   
 xx = num2str(B);
 xx21(1,i) = base2dec(xx,P)+1;
 
 B = sum(y22(i,:).*(10.^(numel(y22(i,:))-1:-1:0)));   
 xx = num2str(B);
 xx22(1,i) = base2dec(xx,P)+1;
end

[Tr1Dec,Tr1]= SB_EM_FindTransitionsSuccess(xx11,xx21,M, P );
[Tr2Dec,Tr2]= SB_EM_FindTransitionsSuccess(xx12,xx22,M, P );

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