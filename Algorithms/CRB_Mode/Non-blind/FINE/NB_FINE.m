function [SNR, Err] = NB_FINE (Op, Monte, SNR)

% Initialize variables
data_size  = Op{1};    % Data size
delta_arr  = Op{2};    % delta
Epochs     = Op{3};    % max epochs
lr         = Op{4};    % learning-rate 

Monte   = Monte;
SNR     = SNR;

OS_support = {'OS_WINDOWS', 'OS_LINUX'};
ls_pkgs = {'numpy', 'torch', 'multiprocessing', 'tqdm', 'matplotlib'};

if ~Check_Installed_pkgs(OS_support, ls_pkgs)
    return
end

global main_path;
file_path = fullfile(main_path, 'Algorithms', 'CRB_Mode', 'Non-blind', 'FINE', 'NB_FINE.py');

Err_f = [];
for Monte_i = 1:Monte
    [status, ~, Err] = Run_py_script(file_path, data_size, delta_arr, Epochs, lr, Monte, SNR);
    if status == 1
        Err_f = [Err_f; Err];
    end
end

% Return
if Monte ~= 1
    Err = mean(Err_f);
else
    Err = Err_f;
end

end