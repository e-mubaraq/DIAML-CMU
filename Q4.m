whiteWine = readtable('winequality-white.csv', 'ReadVariableNames', true);
redWine = readtable('winequality-red.csv', 'ReadVariableNames', true);
whiteData = table2array(whiteWine);
redData = table2array(redWine);

redDataX = redData(:, 1:11);
whiteDataX = whiteData(:, 1:11);
redY = redData(:,12);
whiteY = whiteData(:,12);

redAvg = mean(redDataX);
whiteAvg = mean(whiteDataX);

x_str = {'fixed Acidity'; 'Volatile Acidity'; 'Citric Acid'; 'Residual Sugar'; 'Chlorides';
    'Free Sulfur Dioxides'; 'Total Sulfur Dioxide'; 'Density'; 'pH'; 'Sulphates'; 'Alcohol'};
X_str = {'fixed Acidity', 'Volatile Acidity', 'Citric Acid', 'Residual Sugar', 'Chlorides', 'Free Sulfur Dioxides', 'Total Sulfur Dioxide', 'Density', 'pH', 'Sulphates', 'Alcohol'};
% X_str = redWine.Properties.VariableNames;
x = categorical(x_str);
Y_wine = [redAvg'  whiteAvg'];
bar(x, Y_wine);
legend('White wine','Red wine');
title('Bar graph showing the averages of the features of red and white wines');
xlabel('Features');
ylabel('Average values');

% Correlation Matrix for both wines
r_red = corrcoef(redData);
r_white = corrcoef(whiteData);

[B,FitInfo] = lasso(redDataX,redY,'CV',10, 'PredictorNames', X_str );
lassoPlot(B, FitInfo, 'PlotType','Lambda', 'PredictorNames', redWine.Properties.VariableNames);
legend('show')

lassoPlot(B,FitInfo,'PlotType','CV');
legend('show')
idxLambdaMinMSE = FitInfo.IndexMinMSE;
minMSEModelPredictors = FitInfo.PredictorNames(B(:,idxLambdaMinMSE)~=0);
rsfeat = find(B(:, idxLambdaMinMSE));
% Selected data for red.
redSelected = redData(: , rsfeat);

[Bw,FitInfoW] = lasso(whiteDataX,whiteY,'CV',10, 'PredictorNames', X_str);
lassoPlot(Bw, FitInfoW, 'PlotType','Lambda', 'PredictorNames', whiteWine.Properties.VariableNames);
legend('show')

lassoPlot(Bw,FitInfoW,'PlotType','CV');
legend('show')
idxLambdaMinMSEWh = FitInfoW.IndexMinMSE;
minMSEModelPredictorsWh = FitInfoW.PredictorNames(B(:,idxLambdaMinMSEWh)~=0);

% learnig and testing datasets
indl = [1:1000];
indt = [1001:1599];
Xl = redSelected(indl,:);
yl = redY(indl,:);
Xt = redSelected(indt,:);
yt = redY(indt);
nl = length(yl);
nt = length(yt);


K = 2.^[0:5];
for k=1:length(K)
    
   [idx, dist] = knnsearch(Xl,Xt,'dist','seuclidean','k',K(k));
   %[idx, dist] = knnsearch(Xl,Xt,'dist','mahalanobis','k',K(k));
   ythat = nanmean(yl(idx),2);
   E = yt - ythat;
   MSE(k) = (nanmean(E.^2));
end

figure
plot(K,MSE,'k.-');
xlabel('Number of nearest neighbors')
ylabel('RMSE')
title('Plot of MSE against number of nearest neighbors');


Rsquared = sum(ythat - mean(yt)).^2 / sum(yt - mean(yt)).^2

% linear regression model
X_Str = {'fixed Acidity', 'Volatile Acidity', 'Citric Acid', 'Residual Sugar', 'Chlorides', 'Free Sulfur Dioxides', 'Total Sulfur Dioxide', 'Density', 'pH', 'Sulphates', 'Alcohol', 'Quality'};
modelR = fitlm(redDataX, redY, 'VarNames',X_Str);
modelW = fitlm(whiteDataX, whiteY, 'VarNames',X_Str);

MSEr = modelR.MSE;
MSEw = modelW.MSE;

