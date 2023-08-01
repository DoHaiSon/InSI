% calcul des reestimees de la matrice H et de la puissance de bruit sigma ainsi % que des probabilites a posteriori des symbols
%
% SYNTAXE  [proba,estsigma,estcan] = 
% cal_theta(alpha,beta,gamma,rho,lambda,sig_cap,alphabet);
%
% alpha,beta,gamma,rho,lambda:  parametres pour calculer la proba a posteriori
% sig_cap : tableau des signaux recus par les capteurs
% alphabet : ensemble des valeurs discretes prises par les symboles sources.
%
% sortie:
% proba : tableau des densites de probabilites a posteriori des symbols L(x(t)|Y) a la fin des iterations.
% estsigma : reestimee de sigma a la fin des iterations
% estcan : reestimee de can a la fin des iterations
%
 
function [proba,estsigma,estcan] = SB_EM_cal_theta(alpha,beta,gamma,rho,lambda,sig_cap,alphabet)

[dim1,M]=size(alpha); % dim1=T+M 
dim3=length(alphabet(1,:));
T=max(size(sig_cap));
L=min(size(sig_cap));


Rxx=zeros(M+1);
Ryx=zeros(L,M+1);
Ryy=sig_cap.'*conj(sig_cap);
giga=zeros(dim3*dim1,dim3*M);
ponderation=zeros(dim1,M);
proba = zeros(dim1,dim3);
x_moy = zeros(dim1,1);

for it=1:dim3
 at=alphabet(it);
 x=zeros(dim1,1);
 for is=1:dim3
  as=alphabet(is);
  tmp=exp(-alpha*abs(as)^2 - beta*abs(at)^2 + ...
          2*real(-gamma*as'*at+rho*as'+lambda*at'));
  mat((is-1)*dim1+1:is*dim1,(it-1)*M+1:it*M) = tmp;
  ponderation = ponderation + tmp;
  x = x + tmp(:,1);
 end;
 proba(:,it) = x;
end;


%%%%%% Calcul de Rxx
for is=1:dim3
 as=alphabet(is);
 proba(:,is) = proba(:,is)./ponderation(:,1);
 for it=1:dim3
  at=alphabet(it);
  tmp = mat((is-1)*dim1+1:is*dim1,(it-1)*M+1:it*M)./ponderation;
  if (it==is), probabilite = sum(proba(1:T,is)); 
  else probabilite = 0; end;
  tmp1 = [probabilite,sum(tmp(1:T,:))];
  Rxx = Rxx + toeplitz(tmp1*as'*at) ;
 end;
 x_moy = x_moy + proba(:,is)*as;
end


%%%%%% Calcul de Ryx
for t=1+M:T
 y=sig_cap(t-M,:).';
 x=x_moy(t:-1:t-M);
 Ryx = Ryx + y*x';
end;
%Ryx=Ryx/(T-M);
Rxy=Ryx';

%%%%%%% Calcul des parametres
estcan=Ryx*inv(Rxx);
estsigma=trace(Ryy-estcan*Rxy)/(T*L);
proba=proba(M:T+M-1,:);
  



