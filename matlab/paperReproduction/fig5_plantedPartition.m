% community detection in graphons that are SBM-type

% 0) Set some parameters
n=2000;
pIn = 0.2;
pEx=0.01;
K=3;


% 1) Set up a graphon
[W] = PlantedPartitionGraphon(n,pIn,pEx,K);


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

% a) Plot the graphon
s1=subplot(1,4,1);
imagesc(W)
yticks('')
xticks('')
title('W(x,y)','interpreter','latex')
axis square
box on

s1Pos = get(s1,'position');

hb = colorbar('location','westoutside');
hb.TickLabelInterpreter = 'latex';

% load a colourmap
cmap=graphonColourmap_red();

caxis([0,1])
colormap(s1,0.99*cmap)
set(s1,'position',s1Pos);


% b) Plot the degree
subplot(1,4,2)
plot(degree,1:n,'LineWidth',2,'Color','k')
set(gca,'XAxisLocation','top')
yticks('')
ylabel('x','interpreter','latex')
xlabel('degree k(x)','interpreter','latex')
set(gca, 'YDir','reverse')
axis square
xlim([0,1])

% plot the modularity surface
s3=subplot(1,4,3);
imagesc(B)
yticks('')
xticks('')
title('B(x,y)','interpreter','latex')
axis square
caxis([-0.5,1])

s3Pos = get(s3,'position');

hb = colorbar('location','westoutside');
hb.TickLabelInterpreter = 'latex';

% load a colourmap
cmap=graphonColourmap();


colormap(s3,0.99*cmap)
set(s3,'position',s3Pos);


% plot the community structure detected by GenLouvain
subplot(1,4,4)
scatter(S,1:n,'MarkerEdgeColor','k')
box on
set(gca,'XAxisLocation','top')
yticks('')
xticks([1,2])
ylabel('x','interpreter','latex')
xlabel('community g(x)','interpreter','latex')
set(gca, 'YDir','reverse')
axis square

