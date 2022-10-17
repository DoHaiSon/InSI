classdef B_MRE_quadratic_params
    %Params Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Parameters
        num_params = 6
        params = {'N_bits', 'Sensors', 'ChL', 'ChType', 'Modulation', 'Window length'}
        tooltips = {}
        % Type of the UIControl: edit_text   = 1
        %                        popup_menu  = 2
        %                        button      = 3
        params_type = [1, 1, 1, 2, 2, 1]
        values = {1000, 4, 4, {'Real', 'Complex', 'Specular', 'Input'}, {'Bin', 'QPSK', 'QAM4', 'QAM16'}, 2, 10}
        default_values = {1000, 4, 4, 2, 2, 10}
        
        % Default SNR and Monte
        default_Monte = 10
        default_SNR = '-10:5:20'

        % Output
        % Type of the outputs: SER Sig = 1
        %                      BER Sig = 2
        %                      MSE Cha = 3
        outputs = [1, 2]
        default_output = 1
        
        % Figure
        sys_model = 'Algo_B_CMA.png'
        title     = {'Blind-MRE'}
        xlabel    = {'SNR (dB)', 'SNR (dB)', 'SNR (dB)'}
        ylabel    = {'SER (dB)', 'BER (dB)', 'MSE Channel (dB)'}
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
    end
    
    methods (Access = private)
        
    end

end

