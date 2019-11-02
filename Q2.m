college_data = csvread('College.csv', 1, 2);

% exploratory variables
num_of_apps = college_data(:,1);
num_of_enrol = college_data(:,3);
num_of_out = college_data(:,8);
num_of_top10 = college_data(:,4);
num_of_top25 = college_data(:,5);

grad_rate = college_data(:,17); % dependent variable

% Correlation coefficients
apps_coeff = corrcoef(num_of_apps,grad_rate);
enrol_coef = corrcoef(num_of_enrol,grad_rate);
out_coeff = corrcoef(num_of_out,grad_rate);
top10_coeff = corrcoef(num_of_top10,grad_rate);
top25_coeff = corrcoef(num_of_top25,grad_rate);

% exploratory matrix
X = [num_of_apps, num_of_enrol, num_of_out, num_of_top10, num_of_top25];
f_mdl = fitlm(X,grad_rate,'VarNames',{'num_of_apps', 'num_of_enrol', 'num_of_out', 'num_of_top10', 'num_of_top25','GradRate'});

stepW_mdl = stepwiselm(X,grad_rate,'VarNames',{'num_of_apps', 'num_of_enrol', 'num_of_out', 'num_of_top10', 'num_of_top25','GradRate'})

bic_mdl = stepwiselm(X,grad_rate, 'Criterion', 'bic','VarNames',{'num_of_apps', 'num_of_enrol', 'num_of_out', 'num_of_top10', 'num_of_top25','GradRate'})

aGRate = predict(f_mdl, X);
gRate = predict(stepW_mdl , X);
mapeA = sum(abs(aGRate - grad_rate)./ grad_rate) / 777
mapeG = sum(abs(gRate - grad_rate)./ grad_rate)/777

grCMU = aGRate(88)
gradCMU = grad_rate(88)

