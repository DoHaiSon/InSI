classdef B_CMA_Newton_params
    %Params Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Parameters
        num_params = 7
        params = {'No. samples', 'No. channels', 'Channel order', 'Channel type', 'Modulation', 'Step size', 'Window length'}
        notations = {'N', 'Nr', 'ChL', 'ChType', 'Mod', 'mu', 'L'}
        tooltips = {}
        % Type of the UIControl: edit_text   = 1
        %                        popup_menu  = 2
        %                        button      = 3
        params_type = [1, 1, 1, 2, 2, 1, 1]
        values = {100,  4, 4, {'Real', 'Complex', 'Input'}, {'Binary', 'QPSK', '4-QAM'}, 0.01, 20}
        default_values = {100, 4, 4, 2, 2, 0.01, 20}
        
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
        title     = {'B-CMA Newton'}
        xlabel    = {'SNR (dB)', 'SNR (dB)', 'SNR (dB)', 'SNR (dB)'}
        ylabel    = {'SER', 'BER', 'MSE Signal (dB)', 'MSE Channel (dB)'}
        trigger   = false 
        position
        linewidth = 1
        color     = 'k'
        
        % Triggers/Flags
        has_inter     = [true, false, false, false, false, true, true]
        rect = {}
        rect_position = {[5 415 210 150], 0, 0, 0, 0, [1735 1390 100 100], [870 760 100 100]}
        rect_linewidth = {2, 0, 0, 0, 0, 2, 2}
        rect_color     = {'b', 'b', 'b', 'b', 'r', 'g', 'r'}      

        % Reference website
        web_url = ''
    end
    
    methods (Access = private)
        
    end

end

