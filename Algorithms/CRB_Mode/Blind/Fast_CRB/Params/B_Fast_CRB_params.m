classdef  B_Fast_CRB_params
    %Params Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Parameters
        num_params =3
        params ={'Num. receivers','Channel order','Num. samples'}
        notations ={'Nr','L','N'}
        tooltips = {}
        % Type of the UIControl: edit_text   = 1
        %                        popup_menu  = 2
        %                        toggle      = 3
        params_type =[1,1,1]
        values ={'2','4','1000'}
        default_values ={'2','4','1000'}
        
        % Default SNR and Monte
        default_Monte  = 10
        default_SNR    = '-10:5:20'

        % Output
        % Type of the outputs: SER Sig = 1
        %                      BER Sig = 2
        %                      MSE Sig = 3
        %                      MSE Cha = 4
        
        % Figure
        sys_model = 'CRB_B_Fast_CRB.png'
        title ={'B_Fast_CRB'}
        xlabel    = {'SNR (dB)'}
        ylabel    = {'CRB'}
        trigger   = false 
        position  
        linewidth = 1
        color     = 'k'
        
        % Triggers/Flags
        has_inter =[true,false,true]
        rect = {}
        rect_position ={[1240 1205 265 80],0, [430 940 110 110]}
        rect_linewidth ={2,2,2}
        rect_color ={'b','b','r'}

        % Reference website
        web_url = 'https://ieeexplore.ieee.org/abstract/document/9187805'
    end
    
    methods (Access = private)
        
    end

end