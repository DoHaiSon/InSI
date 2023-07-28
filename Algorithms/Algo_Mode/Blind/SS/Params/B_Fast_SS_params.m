classdef B_Fast_SS_params
    %Params Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Parameters
        num_params = 7
        params = {'No. samples', 'No. transmitters', 'No. receivers', 'No. paths', 'No. sub-carriers', 'Channel type', 'Modulation'}
        notations = {'Ns', 'Nt', 'Nr', 'N', 'K', 'ChType', 'Mod'}
        tooltips = {}
        % Type of the UIControl: edit_text   = 1
        %                        popup_menu  = 2
        %                        button      = 3
        params_type = [1, 1, 1, 1, 1, 2, 2]
        values = {100, 2, 4, 5, 64, {'Real', 'Complex', 'Input'}, {'Binary', 'QPSK', '4-QAM', '16-QAM', '64-QAM', '128-QAM', '256-QAM'}}
        default_values = {100, 2, 4, 5, 64, 2, 3}
        
        % Default SNR and Monte
        default_Monte = 100
        default_SNR = '-10:5:20'

        % Output
        % Type of the outputs: SER Sig = 1
        %                      BER Sig = 2
        %                      MSE Sig = 3
        %                      MSE Cha = 4
        outputs = [4]
        default_output = 4
        
        % Figure
        sys_model = 'Algo_B_Fast_SS.png'
        title     = {'B-Fast_SS'}
        xlabel    = {'SNR (dB)', 'SNR (dB)', 'SNR (dB)', 'SNR (dB)'}
        ylabel    = {'SER', 'BER', 'MSE Signal (dB)', 'MSE Channel (dB)'}
        trigger   = false 
        position
        linewidth = 1
        color     = 'k'
        
        % Triggers/Flags
        has_inter     = [false, true, true, false, true, false, false]
        rect = {}
        rect_position = {0, [880 1180 70 70], [1107 1180 70 70], 0, [1850 1235 170 80], 0, 0}
        rect_linewidth = {0, 2, 2, 0, 2, 0, 0}
        rect_color     = {'b', 'r', 'b', 'b', 'g', 'b', 'b'}        

        % Reference website
        web_url = ''
    end
    
    methods (Access = private)
        
    end

end