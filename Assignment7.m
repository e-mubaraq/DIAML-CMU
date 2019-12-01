% Data Inference and Applied Machine Learning
% Assignment6
% Name: Mubarak Mikail
% Andrew ID: mmikail
%% Q1
load BlueChipStockMoments
X = corrcov(AssetCovar);
[coeffPca,score,latent,tsquared,explained] = pca(X,'VariableWeights','variance');

P1 = score(:,1);
P2 = score(:,2);

% Create scree plot.
% Make a scree plot of the percent variability explained by each principal component.
figure()
pareto(explained, AssetList)
xlabel('Principal Component');
ylabel('Variance Explained (%)');
title('A Scree plot showing the amount of variance explained by each principal component');

% Create a bar chart for the weight off the first and second PC
figure()
bar([P1 P2])
xlabel('Weight of Stocks');
ylabel('Weight of Stocks');
title('Weight of each stock for the first and second principal components')
legend('First PC', 'Second PC');

% Plot component scores.
% Create a plot of the first two columns of score.
figure()
plot(P1, P2,'X')
xlabel('1st Principal Component');
ylabel('2nd Principal Component');
title('Scatter plot of the first two principal components');

xmean = mean(P1)
ymean = mean(P2)

dist = pdist(X);
min_dist = min(dist)
max_dist = max(dist)

[dist2, idx2] = pdist2(AssetCovar, mean(AssetCovar), 'euclidean', 'Largest', 3);


