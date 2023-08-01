classdef Demo_Estimator_Pilot_based_LS_params
    %Params Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Parameters
        num_params = 7
        params = {'No. samples', 'No. transmitters', 'No. receivers', 'Channel order', 'Channel type', 'Modulation', 'No. pilots'}
        notations = {'Ns', 'Nt', 'Nr', 'M', 'ChType', 'Mod', 'Np'}
        tooltips = {}
        % Type of the UIControl: edit_text   = 1
        %                        popup_menu  = 2
        %                        button      = 3
        params_type = [1, 1, 1, 1, 2, 2, 1, 1, 1]
        values = {100, 2, 4, 2, {'Real', 'Complex', 'Input'}, {'Binary', 'QPSK', '4-QAM', '16-QAM', '64-QAM', '128-QAM', '256-QAM'}, 10}
        default_values = {100, 2, 4, 2, 2, 3, 10}
        
        % Default SNR and Monte
        default_Monte = 10
        default_SNR = '-10:5:20'

        % Output
        % Type of the outputs: SER Sig = 1
        %                      BER Sig = 2
        %                      MSE Sig = 3
        %                      MSE Cha = 4
        outputs = [4]
        default_output = 4
        
        % Figure
        sys_model = 'Default.png'
        title     = {'LS'}
        xlabel    = {'SNR (dB)', 'SNR (dB)', 'SNR (dB)', 'SNR (dB)'}
        ylabel    = {'SER', 'BER', 'MSE Signal (dB)', 'MSE Channel (dB)'}
        trigger   = false 
        position
        linewidth = 1
        color     = 'k'
        
        % Triggers/Flags
        has_inter     = [true, true, true, false, false, false, false, false, false]
        rect = {}
        rect_position = {[150 480 100 100], [260 1130 290 100], [1470 1130 290 100], 0, 0, 0, 0, 0, 0}
        rect_linewidth = {2, 2, 2, 2, 2, 2, 2, 2, 2}
        rect_color     = {'b', 'g', 'r', 'b', 'r', 'g', 'g', 'b', 'b'}      

        % Reference website
        web_url = 'https://www.sciencedirect.com/science/article/abs/pii/S0165168421003340'
    end
    
    methods (Access = private)
        
    end

end