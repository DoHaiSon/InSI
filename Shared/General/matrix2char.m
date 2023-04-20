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
% Author: Do Hai Son - AVITECH - VNU UET - VIETNAM
% Last Modified by Son 20-Apr-2023 17:52:13 

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