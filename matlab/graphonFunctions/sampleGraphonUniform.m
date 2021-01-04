function [ A ] = sampleGraphonUniform( W,s )
%SampleGraphon Constructs a graph from a graphon
%   Conustructs a graph from a graphon by constructing equidistant
%   locations x \in [0,1] and constructing edges according to the
%   connection probability W(x,y)
% Input:
%           W - graphon (matrix)
%           s - number of nodes (= number of sample points)
% Output:
%           A - sparse adjacnency matrix (sXs; symmetric)
%           x - node positions

% check if input is a vector of positions or a number of nodes to be
% sampled

n = size(W,1); % number of discretisation steps

if numel(s)==1
    indexNodeInGraphon=linspace(1,n,s)'; % uniform positions in [0,1] and rewritten as matrix index
    indexNodeInGraphon = round(indexNodeInGraphon);
else
    error('number of samples should be an integer')
end




P=zeros(s); % empty matrix of connection probabilitites
for i=1:s
    for j=(i+1):s
        P(i,j) = W(indexNodeInGraphon(i),indexNodeInGraphon(j));
    end
end

x = linspace(0,1,s); % positions of nodes

A = triu(P>rand(s)); % create edges (only upper triangular matrix)
A = A +A'; % symmetrise
A = A -diag(diag(A)); % no self loops



end
