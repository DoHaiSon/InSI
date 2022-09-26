classdef B_CMA_adap_params
    %Params Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Parameters
        num_params = 6
        params = {'N', 'ChL', 'ChType', 'Modulation', 'mu', 'CMA length'}
        tooltips = {}
        % Type of the UIControl: edit_text   = 1
        %                        popup_menu  = 2
        %                        button      = 3
        params_type = [1, 1, 2, 2, 1, 1]
        values = {10000, 2, {'Real', 'Complex', 'Specular', 'Input'}, {'Bin', 'QPSK', 'QAM4'}, 0.01, 50}
        default_values = {10000, 1, 2, 2, 0.01, 20}
        
        % Default SNR and Monte
        default_Monte = 10
        default_SNR = '-10:5:20'

        % Output
        % Type of the outputs: MSE Sig = 1
        %                      MSE Ch  = 2
        %                      Err rate= 3
        outputs = [1]
        default_output = 1
        
        % Figure
        sys_model = 'Algo_B_CMA.png'
        trigger   = false 
        position
        linewidth = 1
        color     = 'k'
        
        % Triggers/Flags
        has_inter     = [true, false, false, false, true, true]
        rect = {}
        rect_position = {[1 193 105 65], 0, 0, 0, [810 645 30 30], [405 355 45 45]}
        rect_linewidth = {2, 0, 0, 0, 2, 2}
        rect_color     = {'b', 'b', 'b', 'b', 'r', 'g'}        
    end
    
    methods (Access = private)
        
    end

end

