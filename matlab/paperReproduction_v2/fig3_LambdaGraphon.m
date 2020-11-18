% Community detection in Lambda graphon

% 0) Set some parameters
n=2000; % number of discretisation steps
lambda=0.2; % lambda parameter in [0,1]

%b) for plotting

set(0,'defaultAxesFontSize',20)
set(0,'DefaultTextInterpreter', 'latex')
set(groot, 'defaultAxesTickLabelInterpreter','latex')


% 1) Construct a graphon
[W] = LambdaGraphon(n,lambda);

% 2) Community detection on it
% a) compute the modularity matrix
[B] = modularityGraphon(W);

% b) find the optimal group structure with the GenLouvain algorithm
[S,Q] = genlouvain(B);
Q = Q/sum(sum(W))


% 3) Compute the degree
degree = graphonDegree(W);

% 4) Plotting
figure('Color',[1 1 1],'Position',[ 1, 1, 1000,600])

% a) Plot the graphon
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
colormap(0.99*cmap)
set(s2,'position',s2Pos);


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

% plot the odularity surface
subplot(1,4,3)
imagesc(B)
yticks('')
xticks('')
title('B(x,y)','interpreter','latex')
axis square
caxis([-0.5,1])

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
