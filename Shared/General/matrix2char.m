function chr = matrix2char( matrix )

%% chr = matrix2char(matrix): Convert matrix to character function.
%
%% Input:
    % 1. matrix: (numeric, char, str) - input array
%
%% Output:
    % 1. chr: (char) - output character
%
%% Require R2006A
%
% Author: Do Hai Son, Vietnam National University, Hanoi, Vietnam

% Last modified by Do Hai Son, 30-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless communication systems
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France


shape = size(matrix);
row   = shape(1);
col   = shape(2);
strmatrix = num2str(matrix);
strmatrix = strsplit(strmatrix, {' '});
if row == 1 || col == 1
    str = '[';
    for i=1:length(strmatrix)
      if i == length(strmatrix)
          str = strcat(str, strmatrix(i));
      else
          str = strcat(str, strmatrix(i), {' '});
      end
    end
    str  = strcat(str, ']');
    chr  = char(str);
end

end