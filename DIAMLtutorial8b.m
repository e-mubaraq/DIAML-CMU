% Data, Inference & Applied Machine Learning
% DIAML: Tuorial 8b
% Copyright (c) 2017 Patrick E. McSharry (patrick@mcsharry.net)

% This example shows how to identify and remove redundant predictors from a generalized linear model.

% Create data with 20 predictors, and Poisson responses using just three of the predictors, plus a constant.
rng('default') % for reproducibility
X = randn(100,20);
mu = exp(X(:,[5 10 15])*[.4;.2;.3] + 1);
y = poissrnd(mu);

% Construct a cross-validated lasso regularization of a Poisson regression model of the data.
[B FitInfo] = lassoglm(X,y,'poisson','CV',10);

% Examine the cross-validation plot to see the effect of the Lambda regularization parameter.
lassoPlot(B,FitInfo,'plottype','CV');

% The green circle and dashed line locate the Lambda with minimal cross-validation error. 
% The blue circle and dashed line locate the point with minimal cross-validation error plus one standard deviation.

% Find the nonzero model coefficients corresponding to the two identified points.
minpts = find(B(:,FitInfo.IndexMinDeviance))

min1pts = find(B(:,FitInfo.Index1SE))

% The coefficients from the minimal plus one standard error point are exactly those coefficients used to create the data.

% Find the values of the model coefficients at the minimal plus one standard error point.
B(min1pts,FitInfo.Index1SE)

% The values of the coefficients are, as expected, smaller than the original [0.4,0.2,0.3]. Lasso works by "shrinkage," which biases predictor coefficients toward zero.

% The constant term is in the FitInfo.Intercept vector.
FitInfo.Intercept(FitInfo.Index1SE)

% The constant term is near 1, which is the value used to generate the data.


% Regularize Logistic Regression
% This example shows how to regularize binomial regression. 
% The default (canonical) link function for binomial regression is the logistic function.
% 
% Step 1. Prepare the data.
% 
% Load the ionosphere data. The response Y is a cell array of 'g' or 'b' strings. 
% Convert the cells to logical values, with true representing 'g'. 
% Remove the first two columns of X because they have some awkward statistical properties, which are beyond the scope of this discussion.

load ionosphere
Ybool = strcmp(Y,'g');
X = X(:,3:end);
% Step 2. Create a cross-validated fit.

% Construct a regularized binomial regression using 25 Lambda values and 10-fold cross validation. This process can take a few minutes.

rng('default') % for reproducibility
[B,FitInfo] = lassoglm(X,Ybool,'binomial','NumLambda',25,'CV',10);
% Step 3. Examine plots to find appropriate regularization.

% lassoPlot can give both a standard trace plot and a cross-validated deviance plot. Examine both plots.
lassoPlot(B,FitInfo,'PlotType','CV');

% The plot identifies the minimum-deviance point with a green circle and dashed line as a function of the regularization parameter Lambda. 
% The blue circled point has minimum deviance plus no more than one standard deviation.
lassoPlot(B,FitInfo,'PlotType','Lambda','XScale','log');

% The trace plot shows nonzero model coefficients as a function of the regularization parameter Lambda. 
% Because there are 32 predictors and a linear model, there are 32 curves. 
% As Lambda increases to the left, lassoglm sets various coefficients to zero, removing them from the model.

% The trace plot is somewhat compressed. Zoom in to see more detail.
xlim([.01 .1])
ylim([-3 3])

% As Lambda increases toward the left side of the plot, fewer nonzero coefficients remain.

% Find the number of nonzero model coefficients at the Lambda value with minimum deviance plus one standard deviation point. 
% The regularized model coefficients are in column FitInfo.Index1SE of the B matrix.

indx = FitInfo.Index1SE;
B0 = B(:,indx);
nonzeros = sum(B0 ~= 0);

% When you set Lambda to FitInfo.Index1SE, lassoglm removes over half of the 32 original predictors.
% 
% Step 4. Create a regularized model.
% 
% The constant term is in the FitInfo.Index1SE entry of the FitInfo.Intercept vector. Call that value cnst.
% 
% The model is logit(mu) = log(mu/(1 - mu)) X*B0 + cnst . Therefore, for predictions, mu = exp(X*B0 + cnst)/(1+exp(x*B0 + cnst)).
% 
% The glmval function evaluates model predictions. 
% It assumes that the first model coefficient relates to the constant term. 
% Therefore, create a coefficient vector with the constant term first.

cnst = FitInfo.Intercept(indx);
B1 = [cnst;B0];

% Step 5. Examine residuals.
% Plot the training data against the model predictions for the regularized lassoglm model.

preds = glmval(B1,X,'logit');
hist(Ybool - preds) % plot residuals
title('Residuals from lassoglm model')

% Step 6. Alternative: Use identified predictors in a least-squares generalized linear model.

% Instead of using the biased predictions from the model, you can make an unbiased model using just the identified predictors.

predictors = find(B0); % indices of nonzero predictors
mdl = fitglm(X,Ybool,'linear','Distribution','binomial','PredictorVars',predictors);
% if you are using matlab 2013 or earlier releases replace "fitglm" with GeneralizedLinearModel.fit

plotResiduals(mdl);
% As expected, residuals from the least-squares model are slightly smaller than those of the regularized model. 
% However, this does not mean that mdl is a better predictor for new data.