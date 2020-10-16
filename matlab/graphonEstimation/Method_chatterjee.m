function W = Method_chatterjee(G)
n = size(G,1);
Y = mean(G,3);
[U S V] = svd(Y);
idx = (diag(S)<2.02*sqrt(n));

s1 = diag(S);
s1(idx) = 0;
W = U*diag(s1)*V';

W(W>1) = 1;
W(W<0) = 0;

