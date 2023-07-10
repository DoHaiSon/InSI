classdef NB_FINE_params
    %Params Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Parameters
        num_params = 4
        params = {'Data size', 'Delta', 'Epochs', 'Learning rate'}
        notations = {'data_size', 'delta_arr', 'Epochs', 'lr'}
        tooltips = {}
        % Type of the UIControl: edit_text   = 1
        %                        popup_menu  = 2
        %                        button      = 3
        params_type = [1, 1, 1, 1]
        values = {10000, 0.1, 2000, 0.0002}
        default_values = {10000, 0.1, 2000, 0.0002}
        
        % Default SNR and Monte
        default_Monte = 1
        default_SNR = '1:1:10'

        % Output
        % Type of the outputs: SER Sig = 1
        %                      BER Sig = 2
        %                      MSE Cha = 3
%         outputs = [1]
%         default_output = 1
        
        % Figure
        sys_model = 'nonblind_model.png'
        title     = {'NB-FINE'}
        xlabel    = {'SNR (dB)'}
        ylabel    = {'CRB'}
        trigger   = false 
        position
        linewidth = 1
        color     = 'k'
        
        % Triggers/Flags
        has_inter     = [false, false, false, false]
        rect = {}
        rect_position = {0, 0, 0, 0}
        rect_linewidth = {0, 0, 0, 0}
        rect_color     = {'b', 'b', 'b', 'b'}

        % Reference website
        web_url = 'https://ieeexplore.ieee.org/abstract/document/9909530'
    end
    
    methods (Access = private)
        
    end

end

