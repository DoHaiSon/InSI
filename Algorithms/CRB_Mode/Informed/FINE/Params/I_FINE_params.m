classdef I_FINE_params
    %Params Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Parameters
        num_params = 6
        params = {'Dimension', 'Data size', 'Modulation', 'Noise variance', 'Epoch', 'Learning rate'}
        notations = {'K', 'L', 'Mod', 'sigma_w', 'Epochs', 'lr'}
        tooltips = {}
        % Type of the UIControl: edit_text   = 1
        %                        popup_menu  = 2
        %                        button      = 3
        params_type = [1, 1, 2, 1, 1, 1]
        values = {2, 1000, {'Binary', 'QPSK', '4-QAM', '16-QAM'}, 0.1, 2000, 0.001}
        default_values = {2, 1000, 1, 0.1, 2000, 0.001}
        
        % Default SNR and Monte
        default_Monte = 1
        default_SNR = '-10:5:20'

        % Output
        % Type of the outputs: SER Sig = 1
        %                      BER Sig = 2
        %                      MSE Cha = 3
%         outputs = [1]
%         default_output = 1
        n_outputs = 3
        
        % Figure
        sys_model = 'CRB_B_FINE.png'
        title     = {'B-FINE'}
        xlabel    = {'SNR (dB)'}
        ylabel    = {'CRB'}
        legends   = {}
        trigger   = false 
        position
        linewidth = 1
        color     = 'k'
        
        % Triggers/Flags
        has_inter     = [false, true, false, true, false, false]
        rect = {}
        rect_position = {0, [1 1130 120 120], 0, [800 1110 400 200], 0, 0}
        rect_linewidth = {0, 2, 0, 2, 0, 0}
        rect_color     = {'b', 'b', 'b', 'r', 'b', 'b'}

        % Reference website
        web_url = 'https://ieeexplore.ieee.org/abstract/document/9909530'
    end
    
    methods (Access = private)
        
    end

end

