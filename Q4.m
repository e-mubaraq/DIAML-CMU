
% titanic = readtable('titanic3.csv');
% name = titanic.name;
% class = titanic.pclass;
% sex = titanic.sex;
% age = titanic.age;
% survived = titanic.survived;

n = length(name);
label = {'0-10', '11-20', '21-30', '31-40', '41-50', '51-60', '61-70', '71-80'};
age_group = ordinal(age, label, [], [0, 11, 21, 31, 41, 51, 61, 71, 80]);

num_of_survived = length(find(survived == 1));
prob_of_survival = num_of_survived / n


for i = 1:n
    if (age(i) <= 0 || age(i) >= 10)
        
        
    end
    
end


%X = [class sex age];
X_str = {'class', 'sex', 'age'}
%model = glmfit(
