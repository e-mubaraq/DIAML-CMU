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
stepwise(X,Y)

%% Q4


titanic = readtable('titanic3.csv');
name = titanic.name;
class = titanic.pclass;
sex = titanic.sex;
age = titanic.age;
survived = titanic.survived;

sex = string(sex);
s = ismember(sex, 'male');
n = length(name);
label = {'0-10', '11-20', '21-30', '31-40', '41-50', '51-60', '61-70', '71-80'};
age_group = ordinal(age, label, [], [0, 11, 21, 31, 41, 51, 61, 71, 80]);

num_of_survived = length(find(survived == 1));
prob_of_survival = num_of_survived / n

num_of_males_survived = length(find(sex == 'male' & survived == 1));
num_of_females_survived = length(find(sex == 'female' & survived == 1));
num_of_males = length(find(sex == 'male'));
num_of_females = n - num_of_males;

prob_of_males_survived = num_of_males_survived / num_of_males
prob_of_females_survived = num_of_females_survived / num_of_females


num_c1_surv = length(find(class == 1 & survived == 1));
num_c2_surv = length(find(class == 2 & survived == 1));
num_c3_surv = length(find(class == 3 & survived == 1));
num_of_class1 = length(find(class == 1));
num_of_class2 = length(find(class == 2));
num_of_class3 = length(find(class == 3));

prob_of_c1_surv = num_c1_surv / num_of_class1
prob_of_c2_surv = num_c2_surv / num_of_class2
prob_of_c3_surv = num_c3_surv / num_of_class3


num_age_0_10 = length(find(age_group == '0-10'));
num_age_11_20 = length(find(age_group == '11-20'));
num_age_21_30 = length(find(age_group == '21-30'));
num_age_31_40 = length(find(age_group == '31-40'));
num_age_41_50 = length(find(age_group == '41-50'));
num_age_51_60 = length(find(age_group == '51-60'));
num_age_61_70 = length(find(age_group == '61-70'));
num_age_71_80 = length(find(age_group == '71-80'));

num_age_0_10_surv = length(find(age_group == '0-10' & survived ==1));
num_age_11_20_surv = length(find(age_group == '11-20' & survived ==1));
num_age_21_30_surv = length(find(age_group == '21-30' & survived ==1));
num_age_31_40_surv = length(find(age_group == '31-40' & survived ==1));
num_age_41_50_surv = length(find(age_group == '41-50' & survived ==1));
num_age_51_60_surv = length(find(age_group == '51-60' & survived ==1));
num_age_61_70_surv = length(find(age_group == '61-70' & survived ==1));
num_age_71_80_surv = length(find(age_group == '71-80' & survived ==1));

prob_of_0_10_surv = num_age_0_10_surv / num_age_0_10
prob_of_11_20_surv = num_age_11_20_surv / num_age_11_20
prob_of_21_30_surv = num_age_21_30_surv / num_age_21_30
prob_of_31_40_surv = num_age_31_40_surv / num_age_31_40
prob_of_41_50_surv = num_age_41_50_surv / num_age_41_50
prob_of_51_60_surv = num_age_51_60_surv / num_age_51_60
prob_of_61_70_surv = num_age_61_70_surv / num_age_61_70
prob_of_71_80_surv = num_age_71_80_surv / num_age_71_80

s = ismember(sex, 'male');

class_c = categorical(class);
s_c = categorical(sex);
survived_c = categorical(survived);
X = table(class_c, s_c, age, survived_c);

model = fitglm(X, 'Distribution', 'Binomial');

yhat = round(predict(model, X));
conf_mat = confusionmat(survived, yhat);
TP = conf_mat(1,1);
FP = conf_mat(1,2);
FN = conf_mat(2,1);
TN = conf_mat(2,2);

accuracy = (TP + TN) / (TP + FN + FP + TN)