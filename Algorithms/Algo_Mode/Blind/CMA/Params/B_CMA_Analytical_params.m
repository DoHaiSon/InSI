classdef B_CMA_Analytical_params
    %Params Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Parameters
        num_params = 6
        params = {'Num. samples', 'Num. channels', 'Channel order', 'Channel type', 'Modulation', 'Window length'}
        notations = {'N', 'Nr', 'ChL', 'ChType', 'Mod', 'L'}
        tooltips = {}
        % Type of the UIControl: edit_text   = 1
        %                        popup_menu  = 2
        %                        button      = 3
        params_type = [1, 1, 1, 2, 2, 1, 1]
        values = {1000,  4, 4, {'Real', 'Complex', 'Parametric', 'Input'}, {'Binary', 'QPSK', '4-QAM'}, 20}
        default_values = {1000, 4, 4, 2, 2, 20}
        
        % Default SNR and Monte
        default_Monte = 10
        default_SNR = '-10:5:20'

        % Output
        % Type of the outputs: SER Sig = 1
        %                      BER Sig = 2
        %                      MSE Sig = 3
        %                      MSE Cha = 4
        outputs = [1, 2, 3]
        default_output = 1
        
        % Figure
        sys_model = 'Algo_B_CMA.png'
        title     = {'B-CMA analytical'}
        xlabel    = {'SNR (dB)', 'SNR (dB)', 'SNR (dB)', 'SNR (dB)'}
        ylabel    = {'SER (dB)', 'BER (dB)', 'MSE Signal (dB)', 'MSE Channel (dB)'}
        trigger   = false 
        position
        linewidth = 1
        color     = 'k'
        
        % Triggers/Flags
        has_inter     = [true, false, false, false, false, true]
        rect = {}
        rect_position = {[1 193 105 65], 0, 0, 0, 0, [405 355 45 45]}
        rect_linewidth = {2, 0, 0, 0, 0, 2}
        rect_color     = {'b', 'b', 'b', 'b', 'r', 'g'}       

        % Reference website
        web_url = 'https://ieeexplore.ieee.org/abstract/document/502327'
    end
    
    methods (Access = private)
        
    end

end

