classdef NB_MMSE_OFDM_params
    %Params Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Parameters
        num_params = 5
        params = {'Occupied carriers', 'Pilot_L', 'ChL', 'ChType', 'Modulation'}
        tooltips = {}
        % Type of the UIControl: edit_text   = 1
        %                        popup_menu  = 2
        %                        button      = 3
        params_type = [1, 1, 1, 2, 2]
        values = {48, 12, 2, {'Real', 'Complex', 'Specular', 'Input'}, {'Bin', 'QPSK', 'QAM4', 'QAM16'}}
        default_values = {48, 12, 2, 2, 2}
        
        % Default SNR and Monte
        default_Monte = 10
        default_SNR = '-10:5:20'

        % Output
        % Type of the outputs: SER Sig = 1
        %                      BER Sig = 2
        %                      MSE Sig = 3
        %                      MSE Cha = 4
        outputs = [1, 2, 3, 4]
        default_output = 1
        
        % Figure
        sys_model = 'OFDM_trx.png'
        title     = {'NB-MMSE OFDM'}
        xlabel    = {'SNR (dB)', 'SNR (dB)', 'SNR (dB)', 'SNR (dB)'}
        ylabel    = {'SER (dB)', 'BER (dB)', 'MSE Signal (dB)', 'MSE Channel (dB)'}
        trigger   = false 
        position
        linewidth = 1
        color     = 'k'
        
        % Triggers/Flags
        has_inter     = [false, false, false, false, false]
        rect = {}
        rect_position = {0, 0, 0, 0, 0}
        rect_linewidth = {0, 0, 0, 0, 0}
        rect_color     = {'b', 'b', 'b', 'b', 'b'}          
    end
    
    methods (Access = private)
        
    end

end