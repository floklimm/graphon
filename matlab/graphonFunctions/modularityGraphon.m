function [B] = modularityGraphon(W,gamma)
%modularityGraphon Modularity computation for a graphon
%   Takes a graphon, estimates it as discrete object, and computes degree
%   and the modularity surface for this graphon.

 % the default for the resolution parameter is gamma=1
 if ~exist('gamma','var') 
      gamma = 1;
 end

n=size(W,1); %number of discretisation elements 
 
k=sum(W)/n; % the degree
twom = sum(k)/n; % twice the total `number' of edges

P = gamma*k'*k/twom; % null model
B = full(W - P); % compute the modularity surface/matrix

end

