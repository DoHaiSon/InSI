classdef SB_MRE_params
    %Params Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Parameters
        num_params = 9
        params = {'Num. samples', 'Num. transmitters', 'Num. receivers', 'Channel order', 'Channel type', 'Modulation', 'Window length', 'Num. pilots', 'Blind ratio'}
        notations = {'Ns', 'T', 'L', 'M', 'ChType', 'Mod', 'N', 'Np', 'lambda'}
        tooltips = {}
        % Type of the UIControl: edit_text   = 1
        %                        popup_menu  = 2
        %                        button      = 3
        params_type = [1, 1, 1, 1, 2, 2, 1, 1, 1]
        values = {256, 2, 4, 4, {'Real', 'Complex', 'Input'}, {'Binary', 'QPSK', '4-QAM', '16-QAM', '64-QAM', '128-QAM', '256-QAM'}, 256, 32, 0.1}
        default_values = {256, 2, 4, 4, 2, 2, 10, 32, 0.1}
        
        % Default SNR and Monte
        default_Monte = 10
        default_SNR = '-10:5:20'

        % Output
        % Type of the outputs: SER Sig = 1
        %                      BER Sig = 2
        %                      MSE Sig = 3
        %                      MSE Cha = 4
        outputs = [1, 2, 3]
        default_output = 1
        
        % Figure
        sys_model = 'Algo_SB_MRE.png'
        title     = {'SB-MRE'}
        xlabel    = {'SNR (dB)', 'SNR (dB)', 'SNR (dB)', 'SNR (dB)'}
        ylabel    = {'SER', 'BER', 'MSE Signal (dB)', 'MSE Channel (dB)'}
        trigger   = false 
        position
        linewidth = 1
        color     = 'k'
        
        % Triggers/Flags
        has_inter     = [true, true, true, false, false, false, false, false, false]
        rect = {}
        rect_position = {[120 480 100 100], [260 1130 290 100], [1470 1130 290 100], 0, 0, 0, 0, 0, 0}
        rect_linewidth = {2, 2, 2, 2, 2, 2, 2, 2, 2}
        rect_color     = {'b', 'g', 'r', 'b', 'r', 'g', 'g', 'b', 'b'}      

        % Reference website
        web_url = ''
    end
    
    methods (Access = private)
        
    end

end