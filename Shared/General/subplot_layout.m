function [p,n] = subplot_layout(n)

%% [p, n] = subplot_layout(n): 
% Calculate how many rows and columns of sub-plots are needed to
% neatly display n subplots. 
%
%% Input:
    % 1. n: (numeric) - the desired number of subplots
%
%% Output: 
    % 1. p: (numeric) - a vector length 2 defining the number of 
    % rows and number of columns required to show n plots. 
    % 2. n: (numeric) - the current number of subplots. This 
    % output is used only by this function for a recursive call.
%
%% Require R2006A
%
% Author: Rob Campbell

% Adapted for InSI by Do Hai Son, 30-Jul-2023
% InSI: A MatLab Toolbox for Informed System Identification in 
% Wireless communication systems
% https://avitech-vnu.github.io/InSI
% Project: NAFOSTED 01/2019/TN on Informed System Identification
% PI: Nguyen Linh Trung, Vietnam National University, Hanoi, Vietnam
% Co-PI: Karim Abed-Meraim, Université d’Orléans, France

   
while isprime(n) && n > 4 
    n=n+1;
end

p=factor(n);

if length(p)==1
    p=[1,p];
    return
end


while length(p)>2
    if length(p)>=4
        p(1)=p(1)*p(end-1);
        p(2)=p(2)*p(end);
        p(end-1:end)=[];
    else
        p(1)=p(1)*p(2);
        p(2)=[];
    end    
    p=sort(p);
end


%Reformat if the column/row ratio is too large: we want a roughly
%square design 
while p(2)/p(1)>2.5
    N=n+1;
    [p,n]=subplot_layout(N); %Recursive!
end

end