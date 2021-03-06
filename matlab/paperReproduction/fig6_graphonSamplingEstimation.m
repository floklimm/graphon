% community detection in graphons that are SBM-type
% We compare the recovery of the planted partitions with two approaches
% 1) Modularity maximisation of the sampled graph
% 2) Modularity maximisation of the graphon, which we estimated from the
% sampled graph

recalc=1;

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

% estimation can be slow for 10,000 nodes, therefore we suggest you run it
% for 1000 and 2000, first.
%sampleVec=[1000,2000,10000]; % sizes of sampled networks
sampleVec=[1000,2000]; % sizes of sampled networks
nSample=numel(sampleVec);

nviGraphon = zeros(nExVec,1);
nviGraph = zeros(nExVec,nSample);
nviEstimated = zeros(nExVec,nSample);

for i=1:nExVec

    pEx = pExVec(i)
    disp('external connection probability')
    disp(pEx)
    
    % 1) Set up a graphon
    [W,plantedPartition] = PlantedPartitionGraphon(n,pIn,pEx,K);
    % 2) Community detection on it
    % a) compute the modularity matrix
    [B] = modularityGraphon(W);
    % b) find the optimal group structure
    [S,Q] = genlouvain(B);
    Q = Q/sum(sum(W));

    % compute the adjusted mutual i information
    nviGraphon(i) = ami(S,plantedPartition);



    % community detection on sampled graph
    for iS = 1:nSample
        s =sampleVec(iS)
        [W,plantedPartitionVarSize] = PlantedPartitionGraphon(s,pIn,pEx,K);
        [G] = sampleGraphonUniform( W,s );

        [Bgraph,twom]=modularity(G,1);
        [Sgraph,Q] = genlouvain(Bgraph);
        nviGraph(i,iS) = ami(Sgraph,plantedPartitionVarSize);
        
        
        % graphon estimation from sampled graph
        disp('start estimation')
        % community detection on estimated graphon
        W_estimated = Method_matrix_completion(full(G));
        %W_estimated = Method_chatterjee(full(G));
        disp('estimation finished')
        [B_estimated] = modularityGraphon(W_estimated);
        [S_estimated,Q_estimated] = genlouvain(B_estimated);
        
        nviEstimated(i,iS) = ami(S_estimated,plantedPartitionVarSize);
    end
end
end

nSamples = numel(sampleVec) ;

cmap = colorramp_new( 'ocean blue','deep orange',nSamples);

figure('Color',[1 1 1],'Position',[ 1, 1, 1000,300])

% plotting the graphon (we removed this in the final verion of the figure)
%plot(pExVec,nviGraphon,'LineWidth',2,'Color',rgb('dark grey'))

hold on
for i=1:nSamples
plot(pExVec,nviGraph(:,i),'LineWidth',2,'LineStyle',':','Color',cmap(i,:))
plot(pExVec,nviEstimated(:,i),'LineWidth',2,'LineStyle','-','Color',cmap(i,:))
end
hold off
text(0.019,0.2,'$N=1\,000$','rotation',90,'Color',cmap(1,:),'FontSize',20)
text(0.034,0.2,'$N=2\,000$','rotation',90,'Color',cmap(2,:),'FontSize',20)
text(0.044,0.2,'$N=10\,000$','rotation',90,'Color',cmap(nSamples,:),'FontSize',20)
xlabel('external connection probability, $p_{\mathrm{ex}}$')
ylim([0,1])
ylabel('AMI')
box on
l=legend('sampled graph','estimated graphon','location','SouthWest');
set(l,'Interpreter','latex')



