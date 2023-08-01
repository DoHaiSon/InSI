function nmse = SB_EM_compute_nmse(x, y)
% COMPUTE_NMSE computes the Normalized Mean Square Error (NMSE) between 
% possibly complex vectors x and y
% Inputs : 
%   x, y : input vectors
% Outputs :
%   nmse : normalized mean square error
%
% Note: this function computes the NMSE between x and y independently of
% scaling factors, i.e., nmse will equal 'zero' if y = a * x, where a is a
% possibly complex scalar

nmse = 1 - (abs(x'*y)^2/(norm(x)*norm(y))^2);
