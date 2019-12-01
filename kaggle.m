testData = readtable('test.csv', 'ReadVariableNames', true);
trainData = readtable('train.csv', 'ReadVariableNames', true);

pid = testData.PassengerId;

class = categorical(trainData.Pclass);
sex = categorical(trainData.Sex);
age = categorical(trainData.Age);
survived = categorical(trainData.Survived);
trainX = table(class, sex, age);

class_t = testData.Pclass;
sex_t = testData.Sex;
age_t = testData.Age;
testX = table(class_t, sex_t, age_t);


ctree = ClassificationTree.fit(trainX, survived);

pid_test = testData.PassengerId;
% class_t = categorical(testData.Pclass);
% sex_t = categorical(testData.Sex);
% age_t = categorical(testData.Age);


surv_hat = predict(ctree , testX);
writematrix([pid_test surv_hat], 'titanicSub.csv')



%X_mat = [class sex age]

