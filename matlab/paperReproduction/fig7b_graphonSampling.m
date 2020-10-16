% community detection in graphons that are SBM-type

recalc=0;

set(0,'defaultAxesFontSize',20)
set(0,'DefaultTextInterpreter', 'latex')
set(groot, 'defaultAxesTickLabelInterpreter','latex')

if recalc>0

% 0) Set some parameters
n=2000; % number of discretisation setps
pIn = 0.05; % internal connection probability is fixed
K=3; % number of planted communities

pExVec=0:0.001:0.05; % vector of tested external connection probabilities
nExVec=numel(pExVec);


sampleVec=[1000,2000,10000]; % sizes of sampled networks
%sampleVec=[100,1000]; % sizes of sampled networks
nSample=numel(sampleVec);

nviGraphon = zeros(nExVec,1);
nviGraph = zeros(nExVec,nSample);
nviEstimated = zeros(nExVec,nSample);

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


    nviGraphon(i) = nvi(S,plantedPartition);



    % community detection on sampled graph
    for iS = 1:nSample
        s =sampleVec(iS)
        [W,plantedPartitionVarSize] = PlantedPartitionGraphon(s,pIn,pEx,K);
        [G] = sampleGraphonUniform( W,s );

        [Bgraph,twom]=modularity(G,1);
        [Sgraph,Q] = genlouvain(Bgraph);
        nviGraph(i,iS) = nvi(Sgraph,plantedPartitionVarSize);
        
        
        % graphon estimation from sampled graph
        
        % community detection on estimated graphon
        W_estimated = Method_matrix_completion(full(G));
        [B_estimated] = modularityGraphon(W_estimated);
        [S_estimated,Q_estimated] = genlouvain(B_estimated);
        
        nviEstimated(i,iS) = nvi(S_estimated,plantedPartitionVarSize);
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
plot(pExVec,nviEstimated(:,i),'LineWidth',2,'LineStyle','--','Color',cmap(i,:))
end
hold off
text(0.015,0.3,'$N=1\,000$','rotation',90,'Color',cmap(1,:),'FontSize',20)
text(0.032,0.3,'$N=2\,000$','rotation',90,'Color',cmap(2,:),'FontSize',20)
text(0.044,0.3,'$N=10\,000$','rotation',90,'Color',cmap(nSamples,:),'FontSize',20)
xlabel('external connection probability, $p_{\mathrm{ex}}$')
ylabel('NVI')
l=legend('graphon','sampled graph','estimated graphon','location','NorthWest');
set(l,'Interpreter','latex')


