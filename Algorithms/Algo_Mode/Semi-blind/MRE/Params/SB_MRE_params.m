classdef SB_MRE_params
    %Params Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Parameters
        num_params = 9
        params = {'N_bits', 'Nt', 'Nr' 'ChL', 'ChType', 'Modulation', 'Window length', 'Pilot', 'lambda'}
        tooltips = {}
        % Type of the UIControl: edit_text   = 1
        %                        popup_menu  = 2
        %                        button      = 3
        params_type = [1, 1, 1, 1, 2, 2, 1, 1, 1]
        values = {256, 2, 4, 4, {'Real', 'Complex', 'Specular', 'Input'}, {'Bin', 'QPSK', 'QAM4', 'QAM16'}, 256, 32, 0.1}
        default_values = {256, 2, 4, 4, 2, 2, 10, 32, 0.1}
        
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
        title     = {'SB-MRE'}
        xlabel    = {'SNR (dB)', 'SNR (dB)', 'SNR (dB)', 'SNR (dB)'}
        ylabel    = {'SER (dB)', 'BER (dB)', 'MSE Signal (dB)', 'MSE Channel (dB)'}
        trigger   = false 
        position
        linewidth = 1
        color     = 'k'
        
        % Triggers/Flags
        has_inter     = [true, false, false, false, false, true, true, false, false]
        rect = {}
        rect_position = {[1 193 105 65], 0, 0, 0, 0, [810 645 30 30], [405 355 45 45], 0, 0}
        rect_linewidth = {2, 0, 0, 0, 0, 2, 2, 0, 0}
        rect_color     = {'b', 'b', 'b', 'b', 'r', 'g', 'g', 'b', 'b'}       
    end
    
    methods (Access = private)
        
    end

end