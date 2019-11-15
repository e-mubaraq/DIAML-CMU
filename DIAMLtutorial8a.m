% Data, Inference & Applied Machine Learning
% DIAML: Tuorial 8a
% Copyright (c) 2017 Patrick E. McSharry (patrick@mcsharry.net)

% Linear regression 

% Simulate features X and responses y
rng('default') % for reproducibility
N = 100; % observations
M = 20;  % features
A = 0.5; % noise amplitude
X = randn(N,M);
y = X(:,[5 10 15])*[1.5; 1.0; 0.5] + 1 + A*randn(N,1);

% Ordinary least squares 
Xp = [ones(N,1) X];
Bols = Xp\y;
bar(Bols)
ylabel('OLS parameter estimates');
Eols = y-Xp*Bols;
MSEols = mean(Eols.^2);

% Construct a cross-validated lasso regularization of a linear regression model of the data.
[B,FitInfo] = lasso(X,y,'NumLambda',25,'CV',10);

% Examine the cross-validation plot to see the effect of the Lambda regularization parameter.
lassoPlot(B,FitInfo,'plottype','CV');

% We can also plot the parameter estimates as a function of the Lambda regularization parameter.
lassoPlot(B,FitInfo,'PlotType','Lambda','XScale','log');

% The green circle and dashed line locate the Lambda with minimal cross-validation error. 
% The blue circle and dashed line locate the point with minimal cross-validation error plus one standard deviation.

% Find the nonzero model coefficients corresponding to the two identified points.
minpts = find(B(:,FitInfo.IndexMinMSE))
min1pts = find(B(:,FitInfo.Index1SE))

% The coefficients from the minimal plus one standard error point are exactly those coefficients used to create the data.

% Find the values of the model coefficients at the minimal plus one standard error point.
B(min1pts,FitInfo.Index1SE)

% The values of the coefficients are, as expected, smaller than the original [1.5,1.0,0.5]. 
% Lasso works by "shrinkage," which biases predictor coefficients toward zero.

% The constant term is in the FitInfo.Intercept vector.
FitInfo.Intercept(FitInfo.Index1SE)

% The constant term is near 1, which is the value used to generate the data.

% Calculate MSE for the lasso model
Blasso = [FitInfo.Intercept(FitInfo.Index1SE); B(min1pts,FitInfo.Index1SE)];
Xp = [ones(N,1) X(:,min1pts)];
Elasso = y-Xp*Blasso;
MSElasso = mean(Elasso.^2);

% Instead of using the biased predictions from the model, you can make an unbiased model using just the identified predictors.
% Calculate the MSE for the identified model using OLS parameter estimation
Xp = [ones(N,1) X(:,min1pts)];
Bsel = Xp\y;
Esel = y-Xp*Bsel;
MSEsel = mean(Esel.^2);

% Compare the MSEs
barh([MSEols MSElasso MSEsel])
set(gca,'YTick',[1 2 3]);
set(gca,'YTickLabel',{'OLS','LASSO','Selected'});


% Consider predicting the mileage (MPG) of a car based on its weight, displacement, horsepower, and acceleration. 
% The carbig data contains these measurements. The data seem likely to be correlated, making elastic net an attractive choice.
load carbig
% Extract the continuous (noncategorical) predictors (lasso does not handle categorical predictors):
X = [Acceleration Displacement Horsepower Weight];

% Perform a lasso fit with 10-fold cross validation:
[b fitinfo] = lasso(X,MPG,'CV',10);

% Plot the result:
lassoPlot(b,fitinfo,'PlotType','Lambda','XScale','log');

% Calculate the correlation of the predictors:
% Eliminate NaNs so corr runs
nonan = ~any(isnan([X MPG]),2);
Xnonan = X(nonan,:);
MPGnonan = MPG(nonan,:);
corr(Xnonan)


% Because some predictors are highly correlated, perform elastic net fitting. Use Alpha = 0.5:
alpha = 0.5;
[ba fitinfoa] = lasso(X,MPG,'CV',10,'Alpha',.5);

% Plot the result. Name each predictor so you can tell which curve is which:
pnames = {'Acceleration','Displacement','Horsepower','Weight'};
lassoPlot(ba,fitinfoa,'PlotType','Lambda','XScale','log','PredictorNames',pnames);

% Here, the elastic net and lasso results are not very similar. 
% Also, the elastic net plot reflects a notable qualitative property of the elastic net technique. 
% The elastic net retains three nonzero coefficients as Lambda increases (toward the left of the plot), 
% and these three coefficients reach 0 at about the same Lambda value. 
% In contrast, the lasso plot shows two of the three coefficients becoming 0 at the same value of Lambda, 
% while another coefficient remains nonzero for higher values of Lambda.

% This behavior exemplifies a general pattern. In general, elastic net tends to retain or drop groups of 
% highly correlated predictors as Lambda increases. In contrast, lasso tends to drop smaller groups, 
% or even individual predictors.
