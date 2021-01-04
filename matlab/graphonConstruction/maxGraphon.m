function [W] = maxGraphon(n)
%MaxGraphon: W = 1-x*y;
% Input:
%           n - number of `nodes' (discretisation)



W=zeros(n); % set up the empty graphon

% get the location of all elements
X = ones(n).*(0:(n-1))/n +(1/(2*n)); % the x-coordinates (second part is to centralise the bins)
Y = X'; % the y-coordinates

for i=1:n
    for j=(i+1):n
        W(i,j) = 1-max([X(i,j),Y(i,j)]);
    end
end

% symmetrise
W=W+W';


end
