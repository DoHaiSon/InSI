% calcul des expressions
%
% alpha_ij-------->tableau alpha  , i< j<=i+M
% beta_ij --------> tableau beta  , i< j<=i+M
% gamma_ij-------->tableau gamma  , i< j<=i+M
% rho_ij ---------> tableau rho   , i< j<=i+M
% lambda_ij------->tableau lambda , i< j<=i+M
%
% SYNTAXE [alpha,beta,gamma,rho,lambda]=cal_parametres(tab1,tab2,tab3);
%
% tab1 : tableau des hj'*Ki^(-1)hj , i<=j<=i+M
% tab2 : tableau des hi'*Ki^(-1)hj , i<=j<=i+M
% tab3 : tableau des hj'*Ki^(-1)y ,  i<=j<=i+M

function [alpha,beta,gamma,rho,lambda] = SB_EM_cal_parametres(tab1,tab2,tab3)

[dim1,dim2] = size(tab1); % dim1=T+M
M=dim2-1;

for ind1=1:dim1
 for ind2=ind1+1:min(ind1+M,dim1)
  ind = ind2-ind1;
  alpha(ind1,ind) = tab1(ind1,1)+abs(tab2(ind1,ind+1))^2/(1-tab1(ind1,ind+1));
  beta(ind1,ind)  = tab1(ind1,ind+1)/(1-tab1(ind1,ind+1));
  gamma(ind1,ind) = tab2(ind1,ind+1)/(1-tab1(ind1,ind+1));
  rho(ind1,ind) = tab3(ind1,1)+tab2(ind1,ind+1)*tab3(ind1,ind+1)/ ...
                                                  (1-tab1(ind1,ind+1));
  lambda(ind1,ind) = tab3(ind1,ind+1)/(1-tab1(ind1,ind+1)) ;
 end;
end;
