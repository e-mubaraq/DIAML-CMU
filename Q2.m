
load BlueChipStockMoments
X = corrcov(AssetCovar);

%coeffPca = pca(X);
[coeffPca,score,latent,tsquared,explained] = pca(X,'VariableWeights','variance');
D = pdist(X);

tree = linkage(D,'average');
figure;
dendrogram(tree,'Orientation','left', 'Labels', AssetList)
title('Horizontal dendrogram for DOW Jones Stock');
ylabel('Stocks');
xlabel('Values');

c = cluster(tree,'maxclust',3);
cutoff = median([tree(end-2,3) tree(end-1,3)]);
figure;
dendrogram(tree,'ColorThreshold',cutoff, 'Labels', AssetList)
xlabel('Stocks');

c = cluster(tree,'maxclust',3);
figure
scatter(X(:,1),X(:,2),10,c,'d', 'filled') 