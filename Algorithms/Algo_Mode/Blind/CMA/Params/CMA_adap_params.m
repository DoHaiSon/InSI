classdef CMA_adap_params
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
        
        % Output
%         Type of the outputs: MSE Sig = 1
%                              MSE Ch  = 2
%                              Err rate= 3
        outputs = [1]
        default_output = 1
        
        % Figure
        sys_model = 'nonblind_model.png'
        trigger   = false 
        position
        linewidth = 1
        color     = 'k'
        
        % Triggers/Flags
        has_inter     = [true, true, false, false, false, false]
        rect = {}
        rect_position = {[5 290 60 60], [1025 620 60 60], 0, 0, 0, 0}
        rect_linewidth = {2, 2, 0, 0, 0, 0}
        rect_color     = {'b', 'r', 'b', 'b', 'b', 'b'}
        
        trigger_scale = false
    end
    
    methods (Access = private)
        
    end

end

