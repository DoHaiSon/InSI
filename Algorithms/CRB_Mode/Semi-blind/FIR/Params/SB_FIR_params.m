classdef SB_FIR_params
    %Params Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Parameters
        num_params = 6
        params = {'Nt', 'Nr', 'ChL', 'Multipaths', 'Sub-carriers', 'Pilot/Data Power ratio'}
        tooltips = {}
        % Type of the UIControl: edit_text   = 1
        %                        popup_menu  = 2
        %                        button      = 3
        params_type = [1, 1, 1, 1, 1, 1]
        values = {2, 16, 4, 2, 64, 0.3}
        default_values = {2, 16, 4, 2, 64, 0.3}
        
        % Default SNR and Monte
        default_Monte = 10
        default_SNR = '-10:5:20'

        % Output
%         Type of the outputs: MSE Sig = 1
%                              MSE Ch  = 2
%                              Err rate= 3
%         outputs = [1]
%         default_output = 1
        
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
    end
    
    methods (Access = private)
        
    end

end

