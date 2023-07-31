function [data] = Gen_Pilot(T)
   
%% data = Gen_Pilot(T): Generation of Pilots
%
%% Input:
    % 1. T: (int) - number of samples to generate
%
%% Output: 
    % 1. data: (complex) - generated symbols
%
%% Require R2006A
%
% Author: Do Hai Son, Vietnam National University, Hanoi, Vietnam

% Last modified by Do Hai Son, 31-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless Communications
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


data = ((2*(randn(1, T)>0)-1) * (0.7 + 0.7i)).'; 

end