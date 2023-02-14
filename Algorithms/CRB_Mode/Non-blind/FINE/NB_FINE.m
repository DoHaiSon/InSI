function [SNR, Err] = NB_FINE (Op, Monte, SNR)

% Initialize variables
Nt  = Op{1};    % number of transmit antennas
Nr  = Op{2};    % number of receive antennas
L   = Op{3};    % channel order
M   = Op{4};    % Number of multipaths 
K   = Op{5};    % OFDM subcarriers
ratio = Op{6};  % Pilot/Data Power ratio

Monte   = Monte;
SNR     = SNR;

OS_support = ["OS_WINDOWS", "OS_LINUX"];
ls_pkgs = ["numpy", "torch", "multiprocessing", "tqdm", "matplotlib", "test1"];

if ~Check_Installed_pkgs(OS_support, ls_pkgs)
    return

Err_f = [];
for Monte_i = 1:Monte
    
    Err_f = [Err_f; Err_SNR];
end

% Return
if Monte ~= 1
    Err = mean(Err_f);
else
    Err = Err_f;
end

end