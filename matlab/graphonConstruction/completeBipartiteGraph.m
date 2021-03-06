function [W] = completeBipartiteGraph(n,ordering,p)
%completeBipartiteGraph Construct bipartite graphon 
%   
% Input: 
%           n - number of `nodes' (discretisation)
%           p - connection probability across groups

W=zeros(n); % set up the empty graphon

nHalf = round(n/2);

% choose with ordering of the nodes
switch ordering
    case 'partite'
        
        W(1:nHalf,(nHalf+1):n)= p;
    case 'chessboard'
        % could be done easier
        for i=1:n
            for j=(i+1):n
                if mod(i-j,2)==1
                    W(i,j)=1;
                end
            end
        end
end
% symmetrize
W = W + W';

% 
% % default number of communtites is two
% switch nargin
%     case 3
%         K=2;
%     otherwise
%         K=K; % use input 
% end
% 
% 
% plantedPartition=zeros(n,1); 
% 
% W=zeros(n)+ pEx; % set up the empty graphon with external connection density
% 
% sizeCommunity = floor(n/K); %the size of communities
% 
% % internal connection probability
% startNode=1;
% for k=1:K
%     % last community is until the end (potential rounding errors)
%     if k==K
%         endNode=n;
%     else
%         endNode = startNode + sizeCommunity - 1;
%     end
%     W(startNode:endNode,startNode:endNode) = pIn;
%     plantedPartition(startNode:endNode)=k; % save the partition
%     startNode = endNode + 1;
% end

end

