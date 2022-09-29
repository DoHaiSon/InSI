function [data]= Gen_Pilot(T)
    
    data = ((2*(randn(1, T)>0)-1) * (0.7 + 0.7i)).'; 