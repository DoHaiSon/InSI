classdef NB_Specular_params
    %Params Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Parameters
        num_params = 6
        params = {'No. transmitters', 'No. receivers', 'Channel order', 'No. channels', 'Sub-carriers', 'Pilot/Data Power ratio'}
        notations = {'Nt', 'Nr', 'L', 'M', 'K', 'ratio'}
        tooltips = {}
        % Type of the UIControl: edit_text   = 1
        %                        popup_menu  = 2
        %                        button      = 3
        params_type = [1, 1, 1, 1, 1, 1]
        values = {2, 16, 4, 2, 64, 0.3}
        default_values = {2, 16, 4, 2, 64, 0.3}
        
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
        sys_model = 'Default.png'
        title     = {'NB-Specular'}
        xlabel    = {'SNR (dB)'}
        ylabel    = {'CRB'}
        trigger   = false 
        position
        linewidth = 1
        color     = 'k'
        
        % Triggers/Flags
        has_inter     = [true, true, false, false, false, false]
        rect = {}
        rect_position = {[275 1130 290 100], [1485 1130 290 100], 0, 0, 0, 0}
        rect_linewidth = {2, 2, 0, 0, 0, 0}
        rect_color     = {'b', 'r', 'b', 'b', 'b', 'b'}

        % Reference website
        web_url = 'https://ieeexplore.ieee.org/document/9723265'
    end
    
    methods (Access = private)
        
    end

end

