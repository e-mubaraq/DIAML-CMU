% Data, Inference & Applied Machine Learning
% DIAML: Tuorial 9a
% Copyright (c) 2017 Patrick E. McSharry (patrick@mcsharry.net)

% Perform sequential feature selection for CLASSIFY on iris data with
% noisy features and see which non-noise features are important
load('fisheriris');
rng('default') % for reproducibility
X = randn(150,10);
X(:,[1 3 5 7 ]) = meas;
y = species;    
opt = statset('display','iter');

       
% Generating a stratified partition is usually preferred to
% evaluate classification algorithms.
cvp = cvpartition(y,'k',10); 
[fs,history] = sequentialfs(@classf,X,y,'cv',cvp,'options',opt);
  
% where CLASSF is a MATLAB function such as:
% function err = classf(xtrain,ytrain,xtest,ytest)
% yfit = classify(xtest,xtrain,ytrain,'quadratic');
% err = sum(~strcmp(ytest,yfit));


% Consider the use of Approximate Entropy (ApEn) as a means of
% distinguishing between signals
% ApEnDemo shows how ApEn is applied to three signals