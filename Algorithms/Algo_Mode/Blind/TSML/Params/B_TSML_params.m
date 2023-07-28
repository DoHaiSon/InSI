classdef B_TSML_params
    %Params Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Parameters
        num_params = 5
        params = {'No. samples', 'No. channels', 'Channel order', 'Channel type', 'Modulation'}
        notations = {'N', 'Nr', 'ChL', 'ChType', 'Mod'}
        tooltips = {}
        % Type of the UIControl: edit_text   = 1
        %                        popup_menu  = 2
        %                        button      = 3
        params_type = [1, 1, 1, 2, 2, 1]
        values = {100, 4, 4, {'Real', 'Complex', 'Input'}, {'Binary', 'QPSK', '4-QAM', '16-QAM', '64-QAM', '128-QAM', '256-QAM'}}
        default_values = {100, 4, 4, 2, 2}
        
        % Default SNR and Monte
        default_Monte = 10
        default_SNR = '-10:5:20'

        % Output
        % Output
        % Type of the outputs: SER Sig = 1
        %                      BER Sig = 2
        %                      MSE Sig = 3
        %                      MSE Cha = 4
        outputs = [4]
        default_output = 4
        
        % Figure
        sys_model = 'CRB_B_Fast_CRB.png'
        title     = {'B-TSML'}
        xlabel    = {'SNR (dB)', 'SNR (dB)', 'SNR (dB)', 'SNR (dB)'}
        ylabel    = {'SER', 'BER', 'MSE Signal (dB)', 'MSE Channel (dB)'}
        trigger   = false 
        position
        linewidth = 1
        color     = 'k'
        
        % Triggers/Flags
        has_inter     = [true, true, false, false, false]
        rect = {}
        rect_position = {[430 940 110 110], [1240 1205 265 80], 0, 0, 0}
        rect_linewidth = {2, 2, 0, 0, 0}
        rect_color     = {'b', 'r', 'b', 'b', 'r'}  

        % Reference website
        web_url = 'https://ieeexplore.ieee.org/document/489039'
    end
    
    methods (Access = private)
        
    end

end

