classdef B_FINE_params
    %Params Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Parameters
        num_params = 6
        params = {'Dimensional', 'Data size', 'Modulation', 'Noise variance', 'Epochs', 'Learning rate'}
        notations = {'K', 'L', 'Mod', 'sigma_w', 'Epochs', 'lr'}
        tooltips = {}
        % Type of the UIControl: edit_text   = 1
        %                        popup_menu  = 2
        %                        button      = 3
        params_type = [1, 1, 2, 1, 1, 1]
        values = {2, 1000, {'Binary', 'QPSK', '4-QAM', '16-QAM', '64-QAM', '256-QAM'}, 0.1, 2000, 0.001}
        default_values = {2, 1000, 1, 0.1, 2000, 0.001}
        
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
        sys_model = 'CRB_B_FINE.png'
        title     = {'B-FINE'}
        xlabel    = {'SNR (dB)'}
        ylabel    = {'CRB'}
        trigger   = false 
        position
        linewidth = 1
        color     = 'k'
        
        % Triggers/Flags
        has_inter     = [false, true, false, true, false, false]
        rect = {}
        rect_position = {0, [20 1130 150 150], 0, [1100 590 400 200], 0, 0}
        rect_linewidth = {0, 2, 0, 2, 0, 0}
        rect_color     = {'b', 'b', 'b', 'r', 'b', 'b'}

        % Reference website
        web_url = 'https://ieeexplore.ieee.org/abstract/document/9909530'
    end
    
    methods (Access = private)
        
    end

end

