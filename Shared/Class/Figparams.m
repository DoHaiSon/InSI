classdef Figparams
    %Figparams Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        axes
        legends
        name 
        title  = {}
        xlabel = {}
        ylabel = {}
        gridmode
        marker = {}
        count = 0
        fig_visible = []
        data = struct('x', 0, 'y', 0)
    end
    
    methods
    end
    
end

