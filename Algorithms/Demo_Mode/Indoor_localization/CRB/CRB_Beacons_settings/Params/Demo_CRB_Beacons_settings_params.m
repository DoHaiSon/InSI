classdef Demo_CRB_Beacons_settings_params
    %Params Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Parameters
        num_params = 10
        params = {'Epoch', 'Learning rate', 'Beacon 1', 'Beacon 2', 'Beacon 3', 'Beacon 4', 'Beacon 5', 'Beacon 6', 'Beacon 7', 'Beacon 8'}
        notations = {'Epochs', 'lr', 'B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7', 'B8'}
        tooltips = {}
        % Type of the UIControl: edit_text   = 1
        %                        popup_menu  = 2
        %                        button      = 3
        params_type = [1, 1, 3, 3, 3, 3, 3, 3, 3, 3]
        values = {200, 0.01, 1, 1, 1, 1, 1, 1, 1, 1}
        default_values = {200, 0.01, 1, 1, 1, 1, 1, 1, 1, 1}
        
        % Default SNR and Monte
        default_Monte = 1
        default_SNR = '20:20'

        % Output
        % Type of the outputs: SER Sig = 1
        %                      BER Sig = 2
        %                      MSE Cha = 3
%         outputs = [1]
%         default_output = 1
        n_outputs = 2
        
        % Figure
        sys_model = 'Demo_CRB_Beacons_settings.png'
        title     = {'BCRB vs beacons settings'}
        xlabel    = {'No. beacons'}
        ylabel    = {'CRB (m)'}
        legends   = {'CRB x-axis', 'CRB y-axis'}
        trigger   = false 
        position
        linewidth = 1
        color     = 'k'
        
        % Triggers/Flags
        has_inter     = [false, false, false, false, false, false, false, false, false, false]
        rect = {}
        rect_position = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
        rect_linewidth = {0, 2, 0, 2, 0, 0, 0, 0, 0, 0}
        rect_color     = {'b', 'b', 'b', 'r', 'b', 'b', 'b', 'r', 'b', 'b'}

        % Reference website
        web_url = 'https://www.rev-jec.org/index.php/rev-jec/article/view/322'
    end
    
    methods (Access = private)
        
    end

end

