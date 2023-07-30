function out = parse_outputs ( cell_ )

%% out = parse_outputs(cell_): Convert cell of cell to InSI output.
%
%% Input:
    % 1. cell_: (numeric) - input cell
%
%% Output:
    % 1. out: (numeric) - output array / cell
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


global params;
try
    n_outputs = params.n_outputs;
catch
    n_outputs = 1;
end

if n_outputs == 1
    out = [];
    for i=1:length(cell_)
        cell_i = cell_{i};
    
        out = [out; cell2mat(cell_i)];
    end
else
    out = {};
    arr = [];
    cell_2D = {};
    for i=1:length(cell_)
        cell_i = cell_{i};

        for j=1:length(cell_i)
            cell_ij = cell_i{j};

            for n=1:n_outputs
                arr(j, n) = cell_ij(n);
            end
        end
        for n=1:n_outputs
            cell_2D{i, n} = arr(:, n);
        end
    end
    for n=1:n_outputs
        out{n} = cell2mat({cell_2D{:, n}});
    end
end

end