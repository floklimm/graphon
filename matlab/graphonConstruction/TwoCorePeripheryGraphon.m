function [W] = TwoCorePeripheryGraphon(n,lambda)
%TwoCorePeripheryGraphon Graphon with two core-periphery structures
% Input:
%           n - number of `nodes' (discretisation)
%           lambda - decay of the cores


W=zeros(n); % set up the empty graphon

% get the distance of all elements
Y = ones(n).*(0:(n-1))/n +(1/(2*n)); % the y-coordinates (second part is to centralise the bins)
X = Y'; % the x-coordinates

W = W + exp(-lambda*sqrt(X^2 + Y^2)); % add the first core-periphery structure (with center (0,0))
W = W + exp(-lambda*sqrt((X-1)^2 + (Y-1)^2  )); % add the second core-periphery structure (with center (1,1))

end
