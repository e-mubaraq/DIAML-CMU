
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

[N,D] = size(X);
K = round(logspace(0,log10(N),10)); % number of neighbors
cvloss = zeros(length(K),1);
for k=1:length(K)
    % Construct a cross-validated classification model
    mdl = ClassificationKNN.fit(X,survived_c,'NumNeighbors',K(k));
    % Calculate the in-sample loss
    rloss(k)  = resubLoss(mdl);
    % Construct a cross-validated classifier from the model.
    cvmdl = crossval(mdl);
    % Examine the cross-validation loss, which is the average loss of each cross-validation model when predicting on data that is not used for training.
    cvloss(k) = kfoldLoss(cvmdl);
end
[rlossmin,irlossmin] = min(rloss);
[cvlossmin,icvlossmin] = min(cvloss);
kopt = K(icvlossmin);

% plot the accuracy versus k
figure; 
semilogx(K,rloss,'g.-');
hold
semilogx(K,cvloss,'b.-');
plot(K(icvlossmin),cvloss(icvlossmin),'ro')
xlabel('Number of nearest neighbors');
ylabel('Ten-fold classification error');
legend('In-sample','Out-of-sample','Optimum','Location','NorthWest')
title('KNN classification');

% loss due to Chebychev distance metric
chebmdl = ClassificationKNN.fit(X,survived_c, 'NumNeighbors',kopt, 'Distance', 'chebychev');
chloss = resubLoss(chebmdl)
cvchebmdl = crossval(chebmdl);
cvchloss = kfoldLoss(cvchebmdl)

% loss due to mahalanobis distance metric
malmdl = ClassificationKNN.fit(X,survived_c, 'NumNeighbors',kopt, 'Distance', 'mahalanobis');
malloss = resubLoss(malmdl)
cvmalmdl = crossval(malmdl);
cvmalloss = kfoldLoss(cvmalmdl)

% logistic regresion model
logMDl = fitglm(train, 'Distribution', 'Binomial')
yhat = round(predict(logMDl, testX));
conf_mat = confusionmat(table2array(testY), categorical(yhat));
TP = conf_mat(1,1);
FP = conf_mat(1,2);
FN = conf_mat(2,1);
TN = conf_mat(2,2);
accuracy = (TP + TN) / (TP + FN + FP + TN)


