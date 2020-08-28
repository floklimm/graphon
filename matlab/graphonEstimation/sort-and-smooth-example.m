clear all
close all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This program tests the Stanford Network Data
%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath(genpath('./deconvtv_v1/'));

load('./data/ca-AstroPh.mat');
G = Problem.A;
clear Problem;

% Reduce data size and symmetrize data
% G = G(1:10:end,1:10:end);
G = G - diag(diag(G)); % remove diagonal
G = (G + G')/2>0;


% tic
% Empirical Degree Sorting and rearrangement
d = mean(G);
[~, pos] = sort(d,'descend');
A = G(pos,pos);
d = mean(A);


% Parameter
n = size(A,1);
h = 20;                 % h = 20 for ca-Astroph, h = 30 for soc-Epinion
k = round(n/h); % number of bins

binwidth = h*ones(1,k);
cum = cumsum(binwidth);                           % cumulative sum of bin widths
binwidth(cum>n) = [];                             % remove oversized bins
binwidth = [binwidth n-sum(binwidth)];            % compensate the last bin
binstart = cumsum(binwidth);                      % record the starting bin ID

% Histogram
H = zeros(k,k);
for i=1:length(binstart)-1
    fprintf('i = %3g / %3g \n', i,k);
    for j=1:length(binstart)-1
        H(i,j) = (nnz(A(binstart(i):binstart(i+1), binstart(j):binstart(j+1)))>0);
    end
end

% TV minimization
opts.beta    = [1 1 0];
opts.print   = true;
opts.method  = 'l2';
[M N] = size(H);
M2   = 10;
N2   = 10;
Hpad = padarray(H, [M2 N2], 'symmetric');
out  = deconvtv(Hpad,1,2.5,opts);
wtv  = out.f;
wtv  = wtv(M2+1:end-M2, N2+1:end-N2);

imagesc(wtv); axis image; axis off;
% export_fig Graphon_soc_Epinions1.eps -transparent
