function Err =  B_Fast_GCRB_SIMO (Op, SNR_i)

%% Fast computation of the Gaussian CRB for blind SIMO system identification
%
%% Input:
    % + 1. nber_of_channels: number of receive antennas
    % + 2. L: Channel order
    % + 3. N: number of data samples
    % + 4. SNR_i: signal noise ratio
%
%% Output:
    % + 1. Err: CRB
%
%% Algorithm:
    % Step 1: Initialize variables
    % Step 2: Return 
%
% Ref: M. Nait-Meziane, K. Abed-Meraim, Z. Zhao, and Nguyen Linh
% Trung, "On the Gaussian Cramér-Rao Bound for Blind Single-Input
% Multiple-Output System Identification: Fast and Asymptotic
% Computations," IEEE Access, vol. 8, pp. 166503-166512, 2020.
%
%% Require R2006A

% Author: M. Nait-Meziane

% Adapted for InSI by Do Hai Son, 29-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless communication systems
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


% Initialize variables
 
nber_of_channels    = Op{1}; % Num. receivers
L                   = Op{2}; % Channel order
N                   = Op{3}; % Num. samples
 

% Generate channel
h_columns = zeros(L+1, nber_of_channels);
H = zeros(N, N, nber_of_channels);
for ii = 1:nber_of_channels
    h_columns(:, ii) = Generate_channel(1, L, 2) * sqrt(2);
    tmp = h_columns(:, ii);
    H(:, :, ii) = toeplitz([tmp; zeros(N-(L+1), 1)], ...
        [tmp(1); zeros(N-1, 1)]); % Sylvester matrix
end

sigma2_s = 1;%var(s);
sigma2_noise = sigma2_s/10^(SNR_i/10);

%% Compute approximate FIM
h1 = h_columns(:,1).';
h2 = h_columns(:,2).';

%----------------------------------------------------------------
% compute a (same for all FIM_ij)
%----------------------------------------------------------------

sigma2_noise_zL = [zeros(1, L), sigma2_noise, zeros(1, L)];
c = conv(fliplr(conj(h1)), h1) + conv(fliplr(conj(h2)), h2);
d = sigma2_noise_zL + sigma2_s*c;
a = [conv(d, d), zeros(1, L+1)]; 

%----------------------------------------------------------------
% compute b along with FIM
%----------------------------------------------------------------

approx_FIM_hh = zeros(2*(L+1), 2*(L+1));
for jj = 1:2
    hj = h_columns(:, jj).';
    for ii = 1:2
        hi = h_columns(:, ii).';
        hi_hjs = conv(fliplr(conj(hj)), hi); % h_i h_j^*
        sigm_hH_h_hi_hjs = d - sigma2_s*hi_hjs;
        for mm = 0:L
            for ll = 0:L
                if ii~= jj
             
                    b_nonzero = conv(hi_hjs, c);
                    b = [zeros(1, 2*L), b_nonzero];                    
                    b = -sigma2_s^3/sigma2_noise*circshift(b, -(L+ll-mm));              
                else                    
                    b_nonzero = conv(sigm_hH_h_hi_hjs, c);
                    b = [zeros(1, 2*L), b_nonzero];
                    b = sigma2_s^2/sigma2_noise*circshift(b, -(L+ll-mm));
                end
                
                [r, p] = residue(b, a);   % compute residues                                
                [p_unique, idx_unique] = unique(p);
                r_unique = r(idx_unique);                    
                
                approx_FIM_hh((L+1)*(ii-1)+ll+1, (L+1)*(jj-1)+mm+1) = N*sum(r_unique(abs(p_unique)<1));
            end
        end
    end
end

d_approx_FIM_hh = real(diag(approx_FIM_hh));
approx_CRB_hh = inv(approx_FIM_hh);
d_approx_CRB_hh = real(diag(approx_CRB_hh));

% Return
Err = sum(d_approx_CRB_hh);

end