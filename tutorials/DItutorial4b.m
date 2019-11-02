% DItutorial4b.m
% Quantifying confidence

% Simulate random samples of size 1000 from normal distributions with means 0 and 0.1, respectively, 
% and standard deviations 1 and 2, respectively:
x = normrnd(0,1,1,1000);
y = normrnd(0.1,2,1,1000);

% Test the null hypothesis that the samples come from populations with equal means, 
% against the alternative that the means are unequal. Perform the test assuming unequal variances:

[h,p,ci] = ttest2(x,y,[],[],'unequal')

% The test rejects the null hypothesis at the default alpha = 0.05 significance level. 
% Under the null hypothesis, the probability of observing a value as extreme or 
% more extreme of the test statistic, as indicated by the p value, is less than alpha. 
% The 95% confidence interval on the mean of the difference does not contain 0.



% A/B testing example
% Variation A: 320 conversions out of 1064 views
% Variation B: 250 conversions out of 1043 views
nA = 1064;
nB = 1043;
pA = 320/1064;
pB = 250/1043;
SEA = sqrt(pA*(1-pA)/nA);
SEB = sqrt(pB*(1-pB)/nB);
CIA = 1.96*SEA;
CIB = 1.96*SEB;
Change = (pA-pB)/pA;
z = (pA - pB)/sqrt(SEA^2 + SEB^2);
Confidence = normcdf(z,0,1)



% Probability contours of CDF
% Simulate data
N = 100;
Q = 10000;
t = [1:N]';
X = sin(t/10)*ones(1,Q) + 0.5*randn(N,Q);
xmu = mean(X,2);
p = [5 25 35 65 75 95];
M = length(p);
C = prctile(X',p)';
%color = [linspace(1,0.5,M/2)' zeros(M/2,1) zeros(M/2,1)]; % red
%color = [zeros(M/2,1) linspace(1,0.5,M/2)' zeros(M/2,1)]; % green
color = [zeros(M/2,1) zeros(M/2,1) linspace(1,0.5,M/2)']; % blue
tf(1:N) = t;
tf(N+1:2*N) = t(N:-1:1);

figure
hold;
for j=1:M/2
   xf(1:N) = C(:,j);
   xf(N+1:2*N) = C(N:-1:1,M-j+1); 
   h(j) = fill(tf,xf,color(j,:));
   set(h(j),'LineStyle','none')
end
plot(t,xmu,'k','LineWidth',2)
xlabel('t')
ylabel('x(t)')
legend(h,'90%','50%','30%','Location','EastOutside');



