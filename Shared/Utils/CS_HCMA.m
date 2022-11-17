function V=CS_HCMA(Z_N,L)

%  Z_N: Data matrix
%  R_Est_inv: inverse covariance matrix
%  U_L:  Kernet of the SS quadratic form
%  L: dimension of the above kernel
%  V: L dimensional vector that provides the linear combination
%	of the kernel vectors for the exact channel estimation

Z_N_old=Z_N;
encore=1;
V=[zeros(L-1,1);1];
seuil=0.00000000000000001;
d=length(Z_N(1,:));

while encore
    encore=0;
    for jj=1:L-1
   	 Y=[(Z_N(L,:).^2-Z_N(jj,:).^2)/2;-Z_N(jj,:).*Z_N(L,:)];
     G=Y*Y'/d;
     alpha=(Z_N(L,:).^2+Z_N(jj,:).^2)/2-1;
     g=Y*alpha.'/d;
     [U_G,Sigma_G]=eig(G);
     beta=(U_G.'*g).^2;
     p4=1;
     p3=2*(Sigma_G(1,1)+Sigma_G(2,2));
     p2=Sigma_G(1,1)^2+Sigma_G(2,2)^2+4*Sigma_G(1,1)*Sigma_G(2,2)-sum(beta);
     p1=2*(Sigma_G(2,2)^2*Sigma_G(1,1)+Sigma_G(1,1)^2*Sigma_G(2,2) - ...
 	 	beta(1)*Sigma_G(2,2)-beta(2)*Sigma_G(1,1));
     p0=(Sigma_G(2,2)^2*Sigma_G(1,1)^2-beta(1)*Sigma_G(2,2)^2 - ...
         beta(2)*Sigma_G(1,1)^2);
     P=[p4 p3 p2 p1 p0];
     racine=roots(P);

     old_crit=10^(10);
     %u=[1; 0];
     u=[0;1];
     for ii=1:4
 	 	if imag(racine(ii))<10^(-10)
            uu=-inv(G+real(racine(ii))*eye(2))*g;
            new_crit=uu'*G*uu+2*g'*uu;
            if new_crit < old_crit
                u=uu;
                old_crit=new_crit;
            end
        end
     end

     if g'*U_G(:,1)==0 && abs(U_G(:,2)'*g/(Sigma_G(2,2)-Sigma_G(1,1)))<=1
 	 	uu=-U_G(:,2)'*g/(Sigma_G(2,2)-Sigma_G(1,1))*U_G(2)+ ...
    	 	sqrt(1-(U_G(:,2)'*g/(Sigma_G(2,2)-Sigma_G(1,1)))^2)*U_G(:,1);
        new_crit=uu'*G*uu+2*g'*uu;
        if new_crit < old_crit
            u=uu;
            old_crit=new_crit;
        end
     end

     if g'*U_G(:,2)==0 && abs(U_G(:,1)'*g/(Sigma_G(1,1)-Sigma_G(2,2)))<=1
 	 	uu=-U_G(:,1)'*g/(Sigma_G(1,1)-Sigma_G(2,2))*U_G(1)+ ...
    	 	sqrt(1-(U_G(:,1)'*g/(Sigma_G(1,1)-Sigma_G(2,2)))^2)*U_G(:,2);
        new_crit=uu'*G*uu+2*g'*uu;
        if new_crit < old_crit
            u=uu;
            old_crit=new_crit;
        end
     end
     cos_theta=sqrt((1+u(1))/2);
     sin_theta=u(2)/(2*cos_theta);

     tmp=Z_N(jj,:);
     Z_N(jj,:)=cos_theta*Z_N(jj,:)+sin_theta*Z_N(L,:);
     Z_N(L,:)=-sin_theta*tmp+cos_theta*Z_N(L,:);

     xxx=V(jj);
     V(jj)=cos_theta*V(jj)-sin_theta*V(L);
     V(L)=sin_theta*xxx+cos_theta*V(L);

     encore=encore | (sin_theta)>seuil;
    end
end