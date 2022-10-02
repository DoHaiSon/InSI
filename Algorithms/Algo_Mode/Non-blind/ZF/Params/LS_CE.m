function [LS_est] = LS_CE(Y, Xp, P_loc, Np, Nfft)
% LS channel estimation function
% Inputs:
% Y = Frequency-domain received signal
% Xp = Pilot signal
% P_loc = location of pilots in signal
% Np = Number of pilots
% output:
% LS_est = LS Channel estimate
    k=1:Np;
    LS_est(k) = Y(k)./Xp(k); % LS channel estimation
    
    if Nfft ~= Np
        LS_est    = interpolate(LS_est, P_loc, Nfft, 'spline');
    end
end