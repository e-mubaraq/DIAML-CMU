% Data Inference and Applied Machine Learning
% Assignment6
% Name: Mubarak Mikail
% Andrew ID: mmikail

%% Q2
titanic = readtable('titanic3.csv');
name = titanic.name;
class = titanic.pclass;
sex = titanic.sex;
age = titanic.age;
survived = titanic.survived;

class_c = categorical(class);
sex_c = categorical(sex);
survived_c = categorical(survived);
%age_c = categorical(age);

x = table(class_c, sex_c, age);
ctree = ClassificationTree.fit(x, survived_c);
view(ctree,'mode','graph');

resuberror = resubLoss(ctree);
cvctree = crossval(ctree);
cvloss = kfoldLoss(cvctree);

[~,~,~,bestlevel] = cvLoss(ctree,'subtrees','all','treesize','min')

% Prune the tree to use it for other purposes:
pctree = prune(ctree,'Level',6);
view(pctree,'mode','graph');
presuberror = resubLoss(pctree);
pcvctree = crossval(pctree);
pcvloss = kfoldLoss(pcvctree);

X = table(class_c, sex_c, age, survived_c);
sz = size(X ,1);
cv = cvpartition(sz, 'HoldOut', 0.3);
testIDX = cv.test;
test = X(testIDX, :);
train = X(~testIDX, :);
trainX = train(: , 1:3);
trainY = train(:,4);
testX = test(: , 1:3);
testY = test(:,4);

logMDl = fitglm(train, 'Distribution', 'Binomial');
yhat = round(predict(logMDl, testX));
conf_mat = confusionmat(table2array(testY), categorical(yhat));
TP = conf_mat(1,1);
FP = conf_mat(1,2);
FN = conf_mat(2,1);
TN = conf_mat(2,2);
accuracy = (TP + TN) / (TP + FN + FP + TN)

%% Q3
titanic = readtable('titanic3.csv');
name = titanic.name;
class = titanic.pclass;
sex = titanic.sex;
age = titanic.age;
survived = titanic.survived;

class_c = categorical(class);
sex_c = categorical(sex);
survived_c = categorical(survived);
age_c = categorical(age);

X = table(class_c, sex_c, age_c);

[N,D] = size(X);
K = round(logspace(0,log10(N),10)); % number of neighbors
cvloss = zeros(length(K),1);
for k=1:length(K)
    % Construct a cross-validated classification model
    mdl = ClassificationKNN.fit(X,survived_c,'NumNeighbors',K(k));
    % Calculate the in-sample loss
    rloss(k)  = resubLoss(mdl);
    % Construct a cross-validated classifier from the model.
    cvmdl = crossval(mdl);
    % Examine the cross-validation loss, which is the average loss of each cross-validation model when predicting on data that is not used for training.
    cvloss(k) = kfoldLoss(cvmdl);
end
[rlossmin,irlossmin] = min(rloss);
[cvlossmin,icvlossmin] = min(cvloss);
kopt = K(icvlossmin);

% plot the accuracy versus k
figure; 
semilogx(K,rloss,'g.-');
hold
semilogx(K,cvloss,'b.-');
plot(K(icvlossmin),cvloss(icvlossmin),'ro')
xlabel('Number of nearest neighbors');
ylabel('Ten-fold classification error');
legend('In-sample','Out-of-sample','Optimum','Location','NorthWest')
title('KNN classification');

% loss due to Chebychev distance metric
chebmdl = ClassificationKNN.fit(X,survived_c, 'NumNeighbors',kopt, 'Distance', 'chebychev');
chloss = resubLoss(chebmdl)
cvchebmdl = crossval(chebmdl);
cvchloss = kfoldLoss(cvchebmdl)

% loss due to mahalanobis distance metric
malmdl = ClassificationKNN.fit(X,survived_c, 'NumNeighbors',kopt, 'Distance', 'mahalanobis');
malloss = resubLoss(malmdl)
cvmalmdl = crossval(malmdl);
cvmalloss = kfoldLoss(cvmalmdl)

% logistic regresion model
logMDl = fitglm(train, 'Distribution', 'Binomial')
yhat = round(predict(logMDl, testX));
conf_mat = confusionmat(table2array(testY), categorical(yhat));
TP = conf_mat(1,1);
FP = conf_mat(1,2);
FN = conf_mat(2,1);
TN = conf_mat(2,2);
accuracy = (TP + TN) / (TP + FN + FP + TN)

%% Q4
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

Rsquared = sum((ythat - nanmean(yt)).^2) / sum((yt - nanmean(yt)).^2)

% linear regression model
X_Str = {'fixed Acidity', 'Volatile Acidity', 'Citric Acid', 'Residual Sugar', 'Chlorides', 'Free Sulfur Dioxides', 'Total Sulfur Dioxide', 'Density', 'pH', 'Sulphates', 'Alcohol', 'Quality'};
modelR = fitlm(redDataX, redY, 'VarNames',X_Str);
modelW = fitlm(whiteDataX, whiteY, 'VarNames',X_Str);

MSEr = modelR.MSE;
MSEw = modelW.MSE;

