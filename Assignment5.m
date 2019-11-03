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
X_Str = {'AGE', 'SEX', 'BMI', 'BP', 'S1', 'S2', 'S3', 'S4', 'S5', 'S6', 'Y'};


model1 = fitlm(X, Y, 'VarNames',X_Str)

%model2 = stepwiselm(X, Y,'VarNames',X_Str)
stepwise(X,Y)

%% Q4
