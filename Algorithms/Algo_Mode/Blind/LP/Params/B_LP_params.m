classdef B_LP_params
    %Params Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Parameters
        num_params = 6
        params = {'Num. bits', 'Num. channels', 'Channel order', 'Channel type', 'Modulation', 'Window length'}
        notations = {'N', 'Nr', 'ChL', 'ChType', 'Mod', 'L'}
        tooltips = {}
        % Type of the UIControl: edit_text   = 1
        %                        popup_menu  = 2
        %                        button      = 3
        params_type = [1, 1, 1, 2, 2, 1]
        values = {10000, 4, 4, {'Real', 'Complex', 'Input'}, {'Binary', 'QPSK', '4-QAM', '16-QAM', '64-QAM', '128-QAM', '256-QAM'}, 10}
        default_values = {10000, 4, 4, 2, 2, 10}
        
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
        sys_model = 'Default.png'
        title     = {'B-LP'}
        xlabel    = {'SNR (dB)', 'SNR (dB)', 'SNR (dB)', 'SNR (dB)'}
        ylabel    = {'SER', 'BER', 'MSE Signal (dB)', 'MSE Channel (dB)'}
        trigger   = false 
        position
        linewidth = 1
        color     = 'k'
        
        % Triggers/Flags
        has_inter     = [true, false, false, false, false, false]
        rect = {}
        rect_position = {[1 193 105 65], 0, 0, 0, [810 645 30 30], [405 355 45 45]}
        rect_linewidth = {2, 0, 0, 0, 2, 2}
        rect_color     = {'b', 'b', 'b', 'b', 'r', 'g'}    

        % Reference website
        web_url = ''
    end
    
    methods (Access = private)
        
    end

end

