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

test_class = class (1:1000);
test_sex = sex(1:1000);
age_test = age(1:1000);

s = ismember(sex, 'male');

class_c = categorical(class);
s_c = categorical(sex);
survived_c = categorical(survived);
age_c = categorical(age);

X = table(class_c, s_c, age);
ctree = ClassificationTree.fit(X, survived_c);
view(ctree,'mode','graph');

resuberror = resubLoss(ctree);
cvctree = crossval(ctree);
cvloss = kfoldLoss(cvctree);

[~,~,~,bestlevel] = cvLoss(ctree,'subtrees','all','treesize','min')

% Prune the tree to use it for other purposes:
pctree = prune(ctree,'Level',6);
view(pctree,'mode','graph');
pcvctree = crossval(pctree);
pcvloss = kfoldLoss(pcvctree);

A = table(class_c, s_c, age, survived_c);

logMDl = fitglm(A);
