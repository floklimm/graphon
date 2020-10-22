% community detection in graphons that are SBM-type

recalc=0;

set(0,'defaultAxesFontSize',20)
set(0,'DefaultTextInterpreter', 'latex')
set(groot, 'defaultAxesTickLabelInterpreter','latex')


if recalc>0

% 0) Set some parameters
n=2000; % number of discretisation setps
pIn = 0.2; % internal connection probability is fixed
K=3; % number of planted communities

pExVec=0:0.01:0.2; % vector of tested external connection probabilities
nExVec=numel(pExVec);


sampleVec=[100,1000,10000]; % sizes of sampled networks
nSample=numel(sampleVec);

nviGraphon = zeros(nExVec,1);
nviGraph = zeros(nExVec,nSample);

for i=1:nExVec

    pEx = pExVec(i)
    
    % 1) Set up a graphon
    [W,plantedPartition] = PlantedPartitionGraphon(n,pIn,pEx,K);
    % 2) Community detection on it
    % a) compute the modularity matrix
    [B] = modularityGraphon(W);
    % b) find the optimal group structure
    [S,Q] = genlouvain(B);
    Q = Q/sum(sum(W));


    nviGraphon(i) = ami(S,plantedPartition);




    for iS = 1:nSample
        s =sampleVec(iS);
        [W,plantedPartitionVarSize] = PlantedPartitionGraphon(s,pIn,pEx,K);
        [G] = sampleGraphonUniform( W,s );

        [Bgraph,twom]=modularity(G,1);
        [Sgraph,Q] = genlouvain(Bgraph);
        nviGraph(i,iS) = ami(Sgraph,plantedPartitionVarSize);
    end
end
end

nSamples = numel(sampleVec) ;

cmap = colorramp_new( 'ocean blue','deep orange',nSamples);

figure('Color',[1 1 1],'Position',[ 1, 1, 600,600])

plot(pExVec,nviGraphon,'LineWidth',2,'Color',rgb('dark grey'))
hold on
for i=1:nSamples
plot(pExVec,nviGraph(:,i),'LineWidth',2,'LineStyle',':','Color',cmap(i,:))
end
hold off
text(0.04,0.6,'$N=1\,00$','rotation',90,'Color',cmap(1,:),'FontSize',20)
text(0.12,0.6,'$N=1\,000$','rotation',90,'Color',cmap(2,:),'FontSize',20)
text(0.16,0.6,'$N=10\,000$','rotation',90,'Color',cmap(nSamples,:),'FontSize',20)
xlabel('external connection probability, $p_{\mathrm{ex}}$')
ylabel('AMI')
l=legend('graphon','sampled graphs','location','NorthWest');
set(l,'Interpreter','latex')


