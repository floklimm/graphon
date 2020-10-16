function west = sort_and_smooth(G)
[M0 N0] = size(G);
n = M0;
h = round(log(n));

% Empirical Degree Sorting
d = mean(G);
[~, pos] = sort(d,'descend');
A = G(pos,pos);

% Histogram
H = imfilter(A, ones(h)/h^2, 'symmetric');
H = H(1:h:end, 1:h:end);

% TV
opts.beta    = [1 1 0];
opts.print   = false;
opts.method  = 'l2';
[M N] = size(H);
M2   = round(M/2);
N2   = round(N/2);
Hpad = padarray(H, [M2 N2], 'symmetric');

out  = deconvtv(Hpad,1,7.5,opts);
what = out.f;
what = what(M2+1:end-M2, N2+1:end-N2);

west = imresize(what,[M0,N0],'nearest');