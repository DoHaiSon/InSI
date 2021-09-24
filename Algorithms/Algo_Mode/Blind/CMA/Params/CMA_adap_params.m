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
        values = {10000, 2, {'Real', 'Complex', 'Specular', 'Input'}, {'Gauss', 'Bin', 'QAM4', 'QAM16'}, 0.01, 50}
        default_values = {10000, 2, 2, 3, 0.01, 50}
        
        % Figure
        sys_model = ''
        trigger = false 
        position
        linewidth = 1
        color = 'k'
        rect
        
        % Triggers/Flags
        trigger_scale = false
    end
    
    methods (Access = private)
        
    end

end

