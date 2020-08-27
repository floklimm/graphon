function [W,plantedPartition] = PlantedPartitionGraphon(n,pIn,pEx,K)
%PlantedPartitionGraphon Construct graphon with k communities
%   
% Input: 
%           n - number of `nodes' (discretisation)
%           pIn - internal connection probability
%           pEx - external conenction probabbility
%           K - number of communities

% default number of communtites is two
switch nargin
    case 3
        K=2;
    otherwise
        K=K; % use input 
end


plantedPartition=zeros(n,1); 

W=zeros(n)+ pEx; % set up the empty graphon with external connection density

sizeCommunity = floor(n/K); %the size of communities

% internal connection probability
startNode=1;
for k=1:K
    % last community is until the end (potential rounding errors)
    if k==K
        endNode=n;
    else
        endNode = startNode + sizeCommunity - 1;
    end
    W(startNode:endNode,startNode:endNode) = pIn;
    plantedPartition(startNode:endNode)=k; % save the partition
    startNode = endNode + 1;
end

end

