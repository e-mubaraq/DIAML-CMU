% DItutorial4a.m
% Statistical hypothesis testing

% A professor wants to know if her statistics class has a good grasp of mathematics. 
% Six students are chosen at random from the class and given a mathematics proficiency test. 
% The professor wants the class to be able to score above 70 on the test. The six students get scores of 62, 92, 75, 68, 83, and 95. 
% Can the professor have 90 percent confidence that the mean score for the class on the test would be above 70?

mu = 70;
x = [62 92 75 68 83 95];
n = length(x);
xbar = mean(x);
s = std(x);
SME = s/sqrt(n);
t = (xbar-mu)/SME;

% A 90 percent confidence level is equivalent to an alpha level of 0.10. 
% This is a one-tailed test since extreme values in one rather than two directions will lead to rejection of the null hypothesis. 
% The number of degrees of freedom for the problem is 6 - 1 = 5. The value in the t-table for t(alpha=0.1; df=5) is 1.476. 
% Because the computed t-value of 1.71 is larger than the critical value in the table, the null hypothesis can be rejected, 
% Therefore the professor has evidence that the class mean on the mathematics test would be at least 70.
alpha = 0.1;
tail = 'right';
[H,P,CI,STATS] = ttest(x,mu,alpha,tail);

% Interpretation:
% H=1 indicates that the null hypothesis can be rejected at the alpha = 0.1 level
% This can be seen from the fact that P = 0.0744 < alpha
% Also note how the confidence interval is above mu = 70


% A baseball coach wants to know if his team is representative of other teams in scoring runs. 
% Nationally, the average number of runs scored by similar teams in a game is 5.7. 
% He chooses five games at random in which his team scored 5, 9, 4, 11, and 8 runs. 
% Is it likely that his team's scores could have come from the national distribution? Assume an alpha level of 0.05.
% Because the team's scoring rate could be either higher than or lower than the national average, 
% the problem calls for a two-tailed test. The null and alternative hypotheses are as follows:
% null hypothesis: H0: mu = 5.7
% alternative hypothesis: H1: mu neq 5.7
mu = 5.7;
x = [5 9 4 11 8];
n = length(x);
xbar = mean(x);
s = std(x);
SME = s/sqrt(n);
t = (xbar-mu)/SME;

% The degrees of freedom is 5 - 1 = 4. 
df = n-1;
% While the overall alpha level is 0.05, the alternative hypotheis requires a two?tailed test and therefore 
% the alpha level must be divided by two, which yields alpha = 0.025. 
% The tabled value for t (alpha = 0.025, df=4) is 2.776. 
% The computed t of 1.32 is smaller, so we cannot reject the null hypothesis that the mean of this team is equal to the population mean. 
% The coach cannot conclude that his team is different from the national distribution on runs scored.
alpha = 0.05;
tail = 'both';
[H,P,CI,STATS] = ttest(x,mu,alpha,tail);

% Interpretation:
% H=0 indicates that the null hypothesis cannot be rejected at the alpha = 0.05 level
% This can be seen from the fact that P = 0.2575 > alpha
% Also note how the confidence interval inlcudes mu = 5.7