classdef I_ISDNN_unstructured_params
    %Params Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Parameters
        num_params = 4
        params = {'No. transmitters', 'No. receivers', 'Data size', 'Error rate'}
        notations = {'Nt', 'Nr', 'N_test', 'sigma'}
        tooltips = {}
        % Type of the UIControl: edit_text   = 1
        %                        popup_menu  = 2
        %                        button      = 3
        params_type = [1, 1, 1, 1]
        values = {8, 64, 1000, 0}
        default_values = {8, 64, 1000, 0}
        
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
        sys_model = 'Algo_I_ISDNN_unstructured.png'
        title     = {'I-ISDNN unstructured'}
        xlabel    = {'SNR (dB)', 'SNR (dB)', 'SNR (dB)', 'SNR (dB)'}
        ylabel    = {'SER', 'BER', 'MSE Signal (dB)', 'MSE Channel (dB)'}
        trigger   = false 
        position
        linewidth = 1
        color     = 'k'
        
        % Triggers/Flags
        has_inter     = [false, false, false, false]
        rect = {}
        rect_position = {0, 0, 0, 0}
        rect_linewidth = {0, 2, 0, 0}
        rect_color     = {'b', 'b', 'b', 'b'}

        % Reference website
        web_url = 'https://dohaison.github.io/assets/pdf/2023_Thesis.pdf'
    end
    
    methods (Access = private)
        
    end

end