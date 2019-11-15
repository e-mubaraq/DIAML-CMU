
titanic = readtable('titanic3.csv');
name = titanic.name;
class = titanic.pclass;
sex = titanic.sex;
age = titanic.age;
survived = titanic.survived;

label = {'0-10', '11-20', '21-30', '31-40', '41-50', '51-60', '61-70', '71-80'};
age_group = ordinal(age, label, [], [0, 11, 21, 31, 41, 51, 61, 71, 80]);
s = ismember(sex, 'male');

class_c = categorical(class);
s_c = categorical(sex);
survived_c = categorical(survived);
age_c = categorical(age);

X = table(class_c, s_c, age_c);

mdl = ClassificationKNN.fit(X,survived_c)

rloss = resubLoss(mdl);
cvmdl = crossval(mdl);
kloss = kfoldLoss(cvmdl);


