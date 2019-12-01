% Data, Inference & Applied Machine Learning
% DIAML: Tuorial 12a
% Copyright (c) 2018 Patrick E. McSharry (patrick@mcsharry.net)

% Bootstrap 
% This example shows how to compute a correlation coefficient standard error using bootstrap resampling of the sample data.

% Load a data set containing the LSAT scores and law-school GPA for 15 students. 
load lawdata

% Plot the data and fit a linear model
figure
plot(lsat,gpa,'ko','MarkerSize',12,'MarkerFaceColor','b')
hold
b = polyfit(lsat,gpa,1);
lsatc = [min(lsat) max(lsat)];
plot(lsatc,b(2)*[1 1] + b(1)*lsatc,'r','LineWidth',2);
xlabel('LSAT')
ylabel('GPA');
rhohat = corr(lsat,gpa);
title(sprintf('Correlation: %f',rhohat));
%%
% Next compute the correlations for jackknife samples, and compute their mean.
rng default;  % For reproducibility
jackrho = jackknife(@corr,lsat,gpa);
% Note how there are 15 correlations corresponding to the 15 jackknife samples

meanrho = mean(jackrho);
%%
% Calculate an estimate of the bias.
n = length(lsat);
biasrho = (n-1) * (meanrho-rhohat)
% The sample correlation probably underestimates the true correlation by about this amount.

% Use bootstrap to obtain PDF for correlation estimates
% These 15 data points are resampled to create 1000 different data sets. 
% The correlation between the two variables is computed for each data set.
rng default  % For reproducibility
[bootrho,bootsam] = bootstrp(1000,@corr,lsat,gpa);


% Display the histogram of the bootstrap estimates of correlation
figure
hist(bootrho)
%%
% The histogram shows the variation of the correlation coefficient across all the bootstrap samples. 
% The sample minimum is positive, indicating that the relationship between LSAT score and GPA is not accidental.

% Finally, compute a bootstrap standard of error for the estimated correlation coefficient.
se = std(bootrho)

% Estimate the Density of Bootstrapped Statistic
% Plot an estimate of the density of these bootstrapped statistics using kernel density estimation.
figure;
[fi,xi] = ksdensity(bootrho);
plot(xi,fi);




