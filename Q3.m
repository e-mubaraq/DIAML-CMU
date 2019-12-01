
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

rfmodel = TreeBagger(50,X,survived_c,'oobvarimp','on');
view(rFmodel.Trees{1}, 'Mode','graph')
figure
plot(oobError(rfmodel));
xlabel('Number of Grown Trees');
ylabel('Out-of-Bag Classification Error');

% ROC curve
[fpr,tpr] = perfcurve(b5v.Y,Sfit(:,gPosition),'g');
figure
plot(fpr,tpr);
xlabel('False Positive Rate');
ylabel('True Positive Rate');