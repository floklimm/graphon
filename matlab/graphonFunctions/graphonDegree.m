function [degree] = graphonDegree(W)
%GRAPHONDEGREE Computes the graphon degree
%   Computes the degree of a graphon
%

n=size(W,1); % number of discretisation steps

degree = sum(W)/n;

end

