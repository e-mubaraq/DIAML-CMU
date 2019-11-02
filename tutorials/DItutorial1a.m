% Data and Inference Tutorial 1a 
% Introduction to Matlab

%%%%%%%%%%%
% Example 1
%%%%%%%%%%%
% Define numbers a, b, c, d and e:
a = 10;
b = 6;
c = 3;
d = 2;
e = 2;

% Addition
a + b 

% Store an answer
x = a + b;

% Subtraction
x = a - b;

% Division
x = a/e;

% Multiplication
x = b*c;

% floor, ceil, round
x = 1.234;
floor(x)
ceil(x)
round(x)


%%%%%%%%%%%
% Example 2
%%%%%%%%%%%
% Defining vectors.  Demonstrate multiplication and division of vectors. 
% Define a vector a and a vector b 

% a is a 5 by 1 vector
a = [1;10;3;4;5];
% b is a 1 by 5 vector
b = [4,5,6,2,3];

% Multiplication by a scalar
x = 2*a;

% The product of a and b:
x = a*b;
% The product of b and a:
x = b*a;

% sum
x = sum(a)
x = cumsum(a)


%%%%%%%%%%%
% Example 3
%%%%%%%%%%%
% Creating a Matrix, using matrix multiplication, Transpose of a matrix and
% the term by term multiplication/division. Changing matrices, element per
% element.

% Define matrices X1 and X2:
% m1 is a 4 by 2 matrix
X1 = [1,2;5,4;6,0;2,2];
X2 = [5,6,1,2;5,4,0,7];

% X3 is the product of both matrices X1 and X2
X3 = X1*X2;

% The transpose of a matrix
X1t = X1';

% find the size of a matrix
size(X1)


% The term by term multiplication:
X = X1t.*X2;

% Term by term division:
X = X1t./X2;

% List parts of matrix
X(:,1)
X(:,1)
X(:)

% Change element (1,2) of a matrix :
X 
X(1,2) = 0;
X

% ones,  zeros, nan
X = ones(3,4)
X = zeros(3,4)
X = nan(3,4)

%%%%%%%%%%%
% Example 4
%%%%%%%%%%%
% min, max, mean
x = [1:10]
xmean = mean(x);
xmin = min(x);
xmax = max(x);

%%%%%%%%%%%
% Example 5
%%%%%%%%%%%
% Trigonometric
x = pi
x = sin(pi)
x = cos(pi)
