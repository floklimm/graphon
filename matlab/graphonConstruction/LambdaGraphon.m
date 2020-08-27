function [W] = LambdaGraphon(n,lambda)
%Lambda graphon
% Input: 
%           n - number of `nodes' (discretisation)
%           lambda - lambda parameter float in (0,1)

W=zeros(n); % set up the empty graphon

% get the location of all elements 
X = ones(n).*(0:(n-1))/n +(1/(2*n)); % the x-coordinates (second part is to centralise the bins)
Y = X'; % the y-coordinates

% compute connection probability
W = (1-lambda)*X.*Y +lambda ;

W = W - diag(diag(W)); % deletes diagonal entries

end

