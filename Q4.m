
% titanic = readtable('titanic3.csv');
% name = titanic.name;
% class = titanic.pclass;
% sex = titanic.sex;
% age = titanic.age;
% survived = titanic.survived;

n = length(name);

num_of_survived = length(find(survived == 1));
prob_of_survival = num_of_survived / n


for i = 1:n
    if (age(i) <= 0 || age(i) >= 10)
        
        
    end
    
end


%X = [class sex age];
X_str = {'class', 'sex', 'age'}
%model = glmfit(
