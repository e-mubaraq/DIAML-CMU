% Data Inference and Applied Machine Learning
% Assignment6
% Name: Mubarak Mikail
% Andrew ID: mmikail
%% Q1
load BlueChipStockMoments
%categories
X = corrcov(AssetCovar);
%coeffPca = pca(X);
[coeffPca,score,latent,tsquared,explained] = pca(X,'VariableWeights','variance');

x = categorical(AssetList(:, 1:2));
y = [(coeffPca(:, 1:2))' (AssetCovar(:, 1:2))'] ;
bar(x,y)
title('')
xlabel('')
ylabel('')

figure;
pareto(explained)
xlabel('Principal Component')
ylabel('Variance Explained (%)')

% Plot component scores.
% Create a plot of the first two columns of score.
figure;
plot(score(:,1),score(:,2),'+')
xlabel('1st Principal Component')
ylabel('2nd Principal Component')

xmean = mean(X(:,1))
ymean = mean(X(:,2))





