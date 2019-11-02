% Data Inference and Applied Machine Learning
% Assignment5
% Name: Mubarak Mikail
% Andrew ID: mmikail

%% Q3
diabetes_data = xlsread('Diabetes_Data.xlsx');
X = diabetes_data(:,1:10);
Y = diabetes_data(:,11);

R = corrcoef(X)
imagesc(R);
colorbar;
title('Heat map of the correlation matrix of the explanatory variables');

%r = corrcoef(diabetes_data(:,1),Y)
model1 = fitlm(X,Y)


%model2 = stepwiselm(X,Y)
stepwise(X,Y)