% polblogs graphon estimation


set(0,'defaultAxesFontSize',20)
set(0,'DefaultTextInterpreter', 'latex')
set(groot, 'defaultAxesTickLabelInterpreter','latex')

recalc=1;

if recalc==1
    % graphon estimation is super slow, therefore we load it

 load('./../../data/physicsGraphonAndGraph.mat')
 
 W=wtv;

[B] = modularityGraphon(W);
[S,Q] = genlouvain(B);

n=size(W,1);

end

% 3) Plotting
figure('Color',[1 1 1],'Position',[ 1, 1, 1000,600])

axis square
axis off
s2=subplot(1,4,1);
imagesc(W)
%axis off
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
plot(sum(W)/n,1:n,'LineWidth',2,'Color','k')
set(gca,'XAxisLocation','top')
set(gca, 'YDir','reverse')
yticks('')
ylabel('x','interpreter','latex')
xlabel('degree k(x)','interpreter','latex')
axis square
xlim([0,1])
ylim([1,n])


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
set(gca, 'YDir','reverse')
ylim([1,n])
yticks('')
ylabel('x','interpreter','latex')
xlabel('community g(x)','interpreter','latex')
axis square



% reorder all matrices/vectors
index1 = find(S==1);
index2 = find(S==2);
index3 = find(S==3);
reordering = [index1;index2;index3];
Wreordered = W(:,reordering);
Wreordered = Wreordered(reordering,:);

k=sum(W)/n;
kReordered = k(reordering);
SReordered = S(reordering);

Breordered = B(:,reordering);
Breordered = Breordered(reordering,:);

%Adj = adjacency(SG);
AdjReordered = A(:,reordering);
AdjReordered = A(reordering,:);




figure('Color',[1 1 1],'Position',[ 1, 1, 1000,600])

axis square
axis off
s2=subplot(1,4,1);
imagesc(Wreordered)
%axis off
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
plot(kReordered,1:n,'LineWidth',2,'Color','k')
set(gca,'XAxisLocation','top')
set(gca, 'YDir','reverse')
yticks('')
ylim([1,n])
ylabel('x','interpreter','latex')
xlabel('degree k(x)','interpreter','latex')
axis square
xlim([0,1])

subplot(1,4,3)
imagesc(Breordered)
%axis off
yticks('')
xticks('')
title('B(x,y)','interpreter','latex')
axis square
caxis([-0.5,1])

subplot(1,4,4)
scatter(SReordered,1:n,'MarkerEdgeColor','k')
box on
set(gca,'XAxisLocation','top')
set(gca, 'YDir','reverse')
yticks('')
ylim([1,n])
ylabel('x','interpreter','latex')
xlabel('community g(x)','interpreter','latex')
axis square



% % plot the graph
% undirectedG=graph(adjacency(SG)+transpose(adjacency(SG)));
% edges = undirectedG.Edges(:,1).EndNodes
% m = size(edges,1);


% figure('Color',[1 1 1],'Position',[ 1, 1, 1000,1000])
% %plot(undirectedG,'NodeCData',S,'MarkerSize',10,'EdgeColor',edgeColourVec)
% plot(undirectedG,'NodeCData',S,'MarkerSize',8,'EdgeColor',rand(m,1)*[1,1,1])
% cmapCluster = [rgb('blue');rgb('red')];
% colormap(cmapCluster)
% box off
% axis off

% [Bgraph,twom]=modularity(A,1);
% [Sgraph,Q] = genlouvain(Bgraph);
% 
% % assign it back to the actual position
% d = mean(A); % mean degree
% [~, pos] = sort(d,'descend');
% renormalisedPosition = floor(numel(S)*pos/max(pos));
% renormalisedPosition(find( renormalisedPosition ==0))=1;
% Sgraphon = S(renormalisedPosition);
% 
% % compare the community structures
% nvi(S,Sgraph)

