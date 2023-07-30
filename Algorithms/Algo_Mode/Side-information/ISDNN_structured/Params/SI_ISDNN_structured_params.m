classdef SI_ISDNN_structured_params
    %Params Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Parameters
        num_params = 3
        params = {'Data size', 'Configuration', 'Error rate'}
        notations = {'N_test', 'config', 'sigma'}
        tooltips = {}
        % Type of the UIControl: edit_text   = 1
        %                        popup_menu  = 2
        %                        button      = 3
        params_type = [1, 2, 1]
        values = {1000, {'ULA', 'UCyA'}, 0}
        default_values = {1000, 2, 0}
        
        % Default SNR and Monte
        default_Monte = 5
        default_SNR = '-10:5:20'

        % Output
        % Type of the outputs: SER Sig = 1
        %                      BER Sig = 2
        %                      MSE Cha = 3
        outputs = [2]
        default_output = 2
        
        % Figure
%         sys_model = 'Algo_SI_ISDNN_structured.png'
        sys_model = 'Default.png'
        title     = {'SI-ISDNN structured'}
        xlabel    = {'SNR (dB)', 'SNR (dB)', 'SNR (dB)', 'SNR (dB)'}
        ylabel    = {'SER', 'BER', 'MSE Signal (dB)', 'MSE Channel (dB)'}
        trigger   = false 
        position
        linewidth = 1
        color     = 'k'
        
        % Triggers/Flags
        has_inter     = [false, false, false]
        rect = {}
        rect_position = {0, 0, 0}
        rect_linewidth = {0, 2, 0}
        rect_color     = {'b', 'b', 'b'}

        % Reference website
        web_url = 'https://dohaison.github.io/assets/pdf/2023_Thesis.pdf'
    end
    
    methods (Access = private)
        
    end

end