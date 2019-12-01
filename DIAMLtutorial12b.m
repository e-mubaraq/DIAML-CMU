% Data, Inference & Applied Machine Learning
% DIAML: Tuorial 12b
% Copyright (c) 2018 Patrick E. McSharry (patrick@mcsharry.net)

% Classifying Radar Returns for Ionosphere Data with TreeBagger
% You can also use ensembles of decision trees for classification. 
% For this example, use ionosphere data with 351 observations and 34 real-valued predictors. 
% The response variable is categorical with two levels:
% 'g' for good radar returns
% 'b' for bad radar returns
% The goal is to predict good or bad returns using a set of 34 measurements. 

% Fix the initial random seed, grow 50 trees, inspect how the ensemble error changes with accumulation of trees, and estimate feature importance. 
% For classification, it is best to set the minimal leaf size to 1 and select the square root of the total number of features for each decision split at random. 
% These are the default settings for a TreeBagger used for classification.
load ionosphere;
rng(1945,'twister')
b = TreeBagger(50,X,Y,'oobvarimp','on');
figure
plot(oobError(b));
xlabel('Number of Grown Trees');
ylabel('Out-of-Bag Classification Error');
%%
% Estimate feature importance:
figure
bar(b.OOBPermutedVarDeltaError);
xlabel('Feature Index');
ylabel('Out-of-Bag Feature Importance');
idxvar = find(b.OOBPermutedVarDeltaError>0.75)

%%
% Having selected the five most important features, grow a larger ensemble on the reduced feature set. 
% Save time by not permuting out-of-bag observations to obtain new estimates of feature importance 
% for the reduced feature set (set oobvarimp to 'off'). 
% You would still be interested in obtaining out-of-bag estimates of classification error (set oobpred to 'on').
b5v = TreeBagger(100,X(:,idxvar),Y,'oobpred','on');
figure
plot(oobError(b5v));
xlabel('Number of Grown Trees');
ylabel('Out-of-Bag Classification Error');

%%
% Obtain predictions for out-of-bag observations. 
% For a classification ensemble, the oobPredict method returns a cell array of classification labels ('g' or 'b' for ionosphere data) 
% as the first output argument and a numeric array of scores as the second output argument. 
% The returned array of scores has two columns, one for each class. 
% One column in the score matrix is redundant because the scores represent class probabilities in tree leaves and by definition add up to 1.

% Find the column for the 'good' class and for the 'bad' class. 
gPosition = find(strcmp('g',b5v.ClassNames));
bPosition = find(strcmp('b',b5v.ClassNames));

[Yfit,Sfit] = oobPredict(b5v);
% The perfcurve utility returns the standard ROC curve, which is the true positive rate versus the false positive rate. 
% perfcurve requires true class labels, scores, and the positive class label for input. 
% In this case, choose the 'good' class as positive. 
% The scores for this class are in the first column of Sfit.

[fpr,tpr] = perfcurve(b5v.Y,Sfit(:,gPosition),'g');
figure
plot(fpr,tpr);
xlabel('False Positive Rate');
ylabel('True Positive Rate');
%%

% Plot ensemble accuracy versus threshold on the score for the 'good' class. 
% The ycrit input argument of perfcurve lets you specify the criterion for the y-axis, 
% and the third output argument of perfcurve returns an array of thresholds for the positive class score. 
% Accuracy is the fraction of correctly classified observations, or equivalently, 1 minus the classification error.

[fpr,accu,thre] = perfcurve(b5v.Y,Sfit(:,gPosition),'g','ycrit','accu');
figure
plot(thre,accu);
xlabel('Threshold for ''good'' Returns');
ylabel('Classification Accuracy');

%%


% Regression of Insurance Risk Rating for Car Imports with TreeBagger
% In this example, use a database of 1985 car imports with 205 observations, 
% 25 input variables, and one response variable, insurance risk rating, or "symboling." 
% The first 15 variables are numeric and the last 10 are categorical. 
% The symboling index takes integer values from -3 to 3.
 
% Load the dataset and split it into predictor and response arrays:
load imports-85;
Y = X(:,1);
X = X(:,2:end);
% Because bagging uses randomized data drawings, its exact outcome depends on the initial random seed. 
% To reproduce the exact results in this example, use the random stream settings:
rng(1945,'twister')

% Finding the Optimal Leaf Size.??
% For regression, the general rule is to set leaf size to 5 and select one third of input features for decision splits at random. 
% In the following step, verify the optimal leaf size by comparing mean-squared errors obtained by regression for various leaf sizes. 
% oobError computes MSE versus the number of grown trees. You must set oobpred to 'on' to obtain out-of-bag predictions later.

leaf = [1 5 10 20 50 100];
col = 'rgbcmy';
figure
for i=1:length(leaf)
    b = TreeBagger(50,X,Y,'method','r','oobpred','on','cat',16:25,'minleaf',leaf(i));
    plot(oobError(b),col(i));
    hold on;
end
xlabel('Number of Grown Trees');
ylabel('Mean Squared Error');
legend({'1' '5' '10' '20' '50' '100'},'Location','NorthEast');
hold off;
% The red (leaf size 1) curve gives the lowest MSE values.
%%

% Estimating Feature Importance.??

% In practical applications, you typically grow ensembles with hundreds of trees. 
% Only 50 trees were used in Finding the Optimal Leaf Size for faster processing. 
% Now that you have estimated the optimal leaf size, grow a larger ensemble with 
% 100 trees and use it for estimation of feature importance:
b = TreeBagger(100,X,Y,'method','r','oobvarimp','on','cat',16:25,'minleaf',1);

% Inspect the error curve again to make sure nothing went wrong during training:
figure
plot(oobError(b));
xlabel('Number of Grown Trees');
ylabel('Out-of-Bag Mean Squared Error');

%%
% Prediction ability should depend more on important features and less on unimportant features. 
% You can use this idea to measure feature importance.

% For each feature, you can permute the values of this feature across all of the observations 
% in the data set and measure how much worse the mean-squared error (MSE) becomes after the permutation. 
% You can repeat this for each feature.

% Using the following code, plot the increase in MSE due to permuting out-of-bag observations across each input variable. 
% The OOBPermutedVarDeltaError array stores the increase in MSE averaged over all trees in the ensemble and divided by the standard deviation taken over the trees, for each variable. The larger this value, the more important the variable. Imposing an arbitrary cutoff at 0.65, you can select the five most important features.
figure
bar(b.OOBPermutedVarDeltaError);
xlabel('Feature Number');
ylabel('Out-Of-Bag Feature Importance');
idxvar = find(b.OOBPermutedVarDeltaError>0.7);
%%
% Growing Trees on a Reduced Set of Features.??
% Using just the five most powerful features selected, determine if it is possible to obtain a similar predictive power. 
% To begin, grow 100 trees on these features only. 
% The first three of the five selected features are numeric and the last two are categorical.

% b5v = TreeBagger(100,X(:,idxvar),Y,'method','r','oobvarimp','on','cat',4:5,'minleaf',1);
% figure
% plot(oobError(b5v));
% xlabel('Number of Grown Trees');
% ylabel('Out-of-Bag Mean Squared Error');

figure
bar(b5v.OOBPermutedVarDeltaError);
xlabel('Feature Index');
ylabel('Out-of-Bag Feature Importance');


% These five most powerful features give the same MSE as the full set, 
% and the ensemble trained on the reduced set ranks these features similarly to each other. 
%%

b = TreeBagger(50,X,Y,'oobvarimp','on');
figure
plot(oobError(b));
xlabel('Number of Grown Trees');
ylabel('Out-of-Bag Classification Error');

% Estimate feature importance:
figure
bar(b.OOBPermutedVarDeltaError);
xlabel('Feature Index');
ylabel('Out-of-Bag Feature Importance');
idxvar = find(b.OOBPermutedVarDeltaError>0.75)