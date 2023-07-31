function [sig, data] = QAM256(T)

%% [sig, data] = QAM256(T): Generation of a QAM 256 constellation (standard samples at 1) 
%
%% Input:
    % 1. T: (int) - number of samples to generate
%
%% Output: 
    % 1. sig: (complex) - generated symbols
    % 2. data: (int) - bits sequence
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


data = randi([0 255], T, 1);
sig  = qammod(data, 256);

end