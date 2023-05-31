classdef Figparams
    %Figparams Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        axes
        name 
        title  = {}
        xlabel = {}
        ylabel = {}
        gridmode
        marker = {}
        legends = {}
        count = 0
        output_types = []
        fig_visible = []
        data = struct('x', 0, 'y', 0)
    end
    
    methods
    end
    
end

