%
% script EstimeCov.m: estimation of the covariance matrix
% spatio-temporal 0 temporal lag
% Syntaxe R = EstimeCov(sig_cap,T,L,N)
% Entrees
%         sig_cap = number of signal samples
%         T = number of signal samples
%         L = no of receivers
%         N = size snapshots of each sensor ( correlation window
% Exits
%         R = spatio-temporal covariance matrix (dimension LN x LN)
%
function R = SB_EM_EstimeCov(sig_cap,T,L,N)

%
%... verification of entries
%
if (size(sig_cap) ~= [T L])
   error('Size of signals is incompatible with parameters');
end
%
%... Calculation of covariances
%
R = zeros(L*N);
for t=1:T-N+1
 x=sig_cap(t+N-1:-1:t,:);
 y=x(:);
 R=R+y*y';
end
R=(1/(T-N+1))*R;

end