classdef NB_ZF_params
    %Params Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Parameters
        num_params = 6
        params = {'No. samples', 'No. transmitters', 'No. receivers', 'Channel order', 'Channel type', 'Modulation'}
        notations = {'N', 'Nt', 'Nr', 'ChL', 'ChType', 'Mod'}
        tooltips = {}
        % Type of the UIControl: edit_text   = 1
        %                        popup_menu  = 2
        %                        button      = 3
        params_type = [1, 1, 1, 1, 2, 2]
        values = {256, 2, 4, 4, {'Real', 'Complex', 'Input'}, {'Binary', 'QPSK', '4-QAM', '16-QAM', '64-QAM', '128-QAM', '256-QAM'}}
        default_values = {256, 2, 4, 4, 2, 2}
        
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
        sys_model = 'Default.png'
        title     = {'NB-ZF'}
        xlabel    = {'SNR (dB)', 'SNR (dB)', 'SNR (dB)', 'SNR (dB)'}
        ylabel    = {'SER', 'BER', 'MSE Signal (dB)', 'MSE Channel (dB)'}
        trigger   = false 
        position
        linewidth = 1
        color     = 'k'
        
        % Triggers/Flags
        has_inter     = [true, true, true, false, false, false]
        rect = {}
        rect_position = {[145 480 100 100], [275 1130 290 100], [1485 1130 290 100], 0, 0, 0}
        rect_linewidth = {2, 2, 2, 0, 0, 0}
        rect_color     = {'b', 'g', 'r', 'b', 'b', 'b'}

        % Reference website
        web_url = 'https://www.sharetechnote.com/html/Communication_ChannelModel_ZF.html'
    end
    
    methods (Access = private)
        
    end

end