% Applied Machine Learning
% AML: Tuorial 3b
% Copyright (c) 2015 Patrick E. McSharry (patrick@mcsharry.net)


% Nonlinear Model from Matrix Data
% Create a nonlinear model for auto mileage based on the carbig data.
% 
% Load the data and create a nonlinear model.

load carbig
X = [Horsepower,Weight];
y = MPG;
modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(3) + b(4)*x(:,2).^b(5);
beta0 = [-50 500 -1 500 -1];
mdl = NonLinearModel.fit(X,y,modelfun,beta0)



% Find values of x that minimize f(x) = -x1*x2*x3, starting at the point x = [10;10;10], subject to the constraints:
% 0 <= x1 + 2*x2 + 2*x3 <= 72.

% Write a file that returns a scalar value f of the objective function evaluated at x:
% function f = myfun(x)
% f = -x(1)*x(2)*x(3);

% Rewrite the constraints as both less than or equal to a constant,
% x1 + 2*x2 + 2*x3 >= 0
% x1 + 2*x2 + 2*x3 <= 72
% Since both constraints are linear, formulate them as the matrix inequality A·x <= b, where
myfun = @(x)(-x(1)*x(2)*x(3));
A = [-1 -2 -2; ...
      1  2  2];
b = [0;72];

% Supply a starting point and invoke an optimization routine:
x0 = [10;10;10];    % Starting guess at the solution
[x,fval] = fmincon(myfun,x0,A,b);

% After fmincon stops, the solution is
x 

% and linear inequality constraints evaluate to be less than or equal to 0:
A*x - b
