% community detection for max graphon

% 0) Set some parameters
n=2000;

% 1) Set up a graphon
[W] = maxGraphon(n);


% 2) Community detection on it
% a) compute the modularity matrix
[B] = modularityGraphon(W);

% b) find the optimal group structure
[S,Q] = genlouvain(B);
Q = Q/sum(sum(W))

% 3) Compute the degree
degree = graphonDegree(W);


% 4) Plotting
figure('Color',[1 1 1],'Position',[ 1, 1, 1000,600])

axis square
axis off
s2=subplot(1,4,1);
imagesc(W)
yticks('')
xticks('')
title('W(x,y)','interpreter','latex')
axis square
box on

s2Pos = get(s2,'position');

hb = colorbar('location','westoutside');
hb.TickLabelInterpreter = 'latex';


% load a colourmap
cmap=graphonColourmap();

caxis([-0.5,1])
colormap(cmap)
set(s2,'position',s2Pos);

subplot(1,4,2)
plot(degree,1:n,'LineWidth',2,'Color','k')
set(gca,'XAxisLocation','top')
yticks('')
ylabel('x','interpreter','latex')
xlabel('degree k(x)','interpreter','latex')
set(gca, 'YDir','reverse')
axis square
xlim([0,1])
subplot(1,4,3)
imagesc(B)
%axis off
yticks('')
xticks('')
title('B(x,y)','interpreter','latex')
axis square
caxis([-0.5,1])


subplot(1,4,4)
scatter(S,1:n,'MarkerEdgeColor','k')
box on
set(gca,'XAxisLocation','top')
yticks('')
ylabel('x','interpreter','latex')
xlabel('community g(x)','interpreter','latex')
set(gca, 'YDir','reverse')
axis square
