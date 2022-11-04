classdef function_params
    %Params Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Parameters
        num_params = 
        params = 
        tooltips = {}
        % Type of the UIControl: edit_text   = 1
        %                        popup_menu  = 2
        %                        toggle      = 3
        params_type = 
        values = 
        default_values = 
        
        % Default SNR and Monte
        default_Monte  = 10
        default_SNR    = '-10:5:20'

        % Output
        % Type of the outputs: SER Sig = 1
        %                      BER Sig = 2
        %                      MSE Cha = 3
        
        % Figure
        sys_model = 'Default.png'
        title = 
        xlabel    = {'SNR (dB)'}
        ylabel    = {'CRB (dB)'}
        trigger   = false 
        position  
        linewidth = 1
        color     = 'k'
        
        % Triggers/Flags
        has_inter = 
        rect = {}
        rect_position = 
        rect_linewidth = 
        rect_color = 
    end
    
    methods (Access = private)
        
    end

end

