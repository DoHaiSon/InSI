classdef NB_ZF_params
    %Params Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Parameters
        num_params = 5
        params = {'N', 'Pilot_L', 'ChL', 'ChType', 'Modulation'}
        tooltips = {}
        % Type of the UIControl: edit_text   = 1
        %                        popup_menu  = 2
        %                        button      = 3
        params_type = [1, 1, 1, 1, 2]
        values = {1024, 64, 2, {'Real', 'Complex', 'Specular', 'Input'}, {'Bin', 'QPSK', 'QAM4'}}
        default_values = {1024, 64, 2, 2, 2}
        
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
        has_inter     = [false, false, false, false, false, false]
        rect = {}
        rect_position = {0, 0, 0, 0, 0, 0}
        rect_linewidth = {0, 0, 0, 0, 0, 0}
        rect_color     = {'b', 'b', 'b', 'b', 'b', 'b'}        
    end
    
    methods (Access = private)
        
    end

end