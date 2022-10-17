% script Estimate.m: estimation de la matrice de covariance
% spatio-temporelle avec 0 decalage temporels
% Syntaxe R = EstimeCov(X, N, Num_Ch, L)
% Input
%         X = observed signals
%         N = number of sig_src
%         Num_Ch = number of channels (sensors)
%         L = window length
% Output
%         R = matrice de covariance spatio-temporelle (dimension Num_Ch*L x Num_Ch*L)
%
function [R,Y]= EstimateCor(X, N, Num_Ch, L)
    %
    %... verification inputs
    %
    if (size(X) ~= [N Num_Ch])
       error('Shape of signals incompatible with the parameters');
    end
    %
    %... Calculate the covariances 
    %
    R   = zeros(Num_Ch*L);
    Y   = [];
    y1  = zeros(L*Num_Ch,1);
    for t = 1:N-L+1
        x = X(t+L-1:-1:t,:);
        x = x.';
        y2= x(:);
        R = R+y2*y1';
        y1= y2;
        Y = [Y,y1];
    end
    R=(1/(N-L+1))*R;
end