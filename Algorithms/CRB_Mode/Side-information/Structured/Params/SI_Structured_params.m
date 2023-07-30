classdef SI_Structured_params
    %Params Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Parameters
        num_params = 9
        params = {'No. transmitters', 'No. receivers', 'Configuration', 'No. UCA', 'No. ULA', 'No. paths', 'No. subcarriers', 'No. pilots', 'Method'}
        notations = {'Nt', 'Nr', 'config', 'Nr_UCA', 'Nr_ULA', 'L', 'K', 'M', 'method'}
        tooltips = {}
        % Type of the UIControl: edit_text   = 1
        %                        popup_menu  = 2
        %                        button      = 3
        params_type = [1, 1, 2, 1, 1, 1, 1, 1, 2]
        values = {2, 96, {'ULA', 'UCyA'}, 24, 4, 4, 64, 16, {'Only Pilots', 'Semi-blind'}}
        default_values = {2, 96, 2, 24, 4, 4, 64, 16, 1}
        
        % Default SNR and Monte
        default_Monte = 10
        default_SNR = '-10:5:20'

        % Output
        % Type of the outputs: SER Sig = 1
        %                      BER Sig = 2
        %                      MSE Cha = 3
%         outputs = [1]
%         default_output = 1
        
        % Figure
        sys_model = 'CRB_SI_Structured.png'
        title     = {'SI-Structured'}
        xlabel    = {'SNR (dB)'}
        ylabel    = {'CRB'}
        trigger   = false 
        position
        linewidth = 1
        color     = 'k'
        
        % Triggers/Flags
        has_inter     = [false, false, false, false, false, false, false, false, false]
        rect = {}
        rect_position = {0, 0, 0, 0, 0, 0, 0, 0, 0}
        rect_linewidth = {0, 0, 0, 0, 0, 0, 0, 0, 0}
        rect_color     = {'b', 'r', 'b', 'b', 'b', 'b', 'b', 'b', 'b'}

        % Reference website
        web_url = ''
    end
    
    methods (Access = private)
        
    end

end