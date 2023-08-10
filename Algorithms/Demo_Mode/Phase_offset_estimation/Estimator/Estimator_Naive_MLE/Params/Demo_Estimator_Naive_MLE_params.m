classdef Demo_Estimator_Naive_MLE_params
    %Params Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Parameters
        num_params = 4
        params = {'Block length', 'Data size', 'Modulation', 'Noise variance'}
        notations = {'K', 'L', 'Mod', 'sigma_w'}
        tooltips = {}
        % Type of the UIControl: edit_text   = 1
        %                        popup_menu  = 2
        %                        button      = 3
        params_type = [1, 1, 2, 1]
        values = {2, 50000, {'Binary'}, 0.1}
        default_values = {2, 50000, 1, 0.1}
        
        % Default SNR and Monte
        default_Monte = 1
        default_SNR = '5:5:25'

        % Output
        % Type of the outputs: SER Sig = 1
        %                      BER Sig = 2
        %                      MSE Sig = 3
        %                      MSE H   = 4
        outputs = [4]
        default_output = 4
        
        % Figure
        sys_model = 'CRB_B_FINE.png'
        title     = {'Naive MLE'}
        xlabel    = {'SNR (dB)', 'SNR (dB)', 'SNR (dB)', 'SNR (dB)', 'SNR (dB)'}
        ylabel    = {'SER', 'BER', 'MSE Signal', 'MSE Channel', 'CRB'}
        legends   = {'Naive MLE'}
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
        web_url = 'https://www.rev-jec.org/index.php/rev-jec/article/view/322'
    end
    
    methods (Access = private)
        
    end

end

