% DItutorial5a.m
% Time series analysis

% Simulate random samples from a normal distribution N(0,1)
x = normrnd(0,1,1000,1);

% Integrate x to form another time series y 
y = cumsum(x);

figure
subplot(2,1,1)
plot(x)
ylabel('x')
subplot(2,1,2)
plot(y)
ylabel('y')

% The variance ratio test assesses the null hypothesis that a univariate
%     time series y is a random walk. The null model is
%         y(t) = c + y(t-1) + e(t),
%     where c is a drift constant and e(t) are uncorrelated innovations with
%     zero mean.

[h,pValue] = vratiotest(x)
[h,pValue] = vratiotest(y)

% Interpretation
% x is not a random walk and we therefore reject the null hypothesis (h=1)
% with a p-value < alpha = 0.05
% y is a random walk and we therefore accept the null hypothesis (h=0)
% with a p-value > alpha = 0.05

% what else can we say about x?
[h,pValue,stat,cValue,ratio] = vratiotest(x);
% For a mean-reverting series, the ratio is less than one. 
% Therefore x is mean reverting. 

% DFA of x and y
alphax = dfa(x,1)
alphay = dfa(y,1)

% Interpretation
% DFA alpha = 0.5 implies beta = 2*alpha - 1 = 0 (white noise)
% DFA alpha = 1.5 implies beta = 2*alpha - 1 = 2 (random walk)


% Financial data: S&P500 and Bonds
stocks = hist_stock_data('01012005','31122014','SPY','TLT');
names = {'SPY','TLT'};
p1 = flipud(stocks(1).AdjClose);
p2 = flipud(stocks(2).AdjClose);
d = flipud(datenum(stocks(1).Date,'yyyy-mm-dd'));

figure
plot(d,p1,'r')
hold
plot(d,p2,'g')
datetick('x',10)
legend('Stocks','Bonds','Location','NorthWest');
xlabel('Year')
ylabel('Price')

alpha1 = dfa(p1,1)
alpha2 = dfa(p2,1)

% Interpretation
% DFA alpha = 1.5 implies beta = 2*alpha = 1 = 2 (random walk)

% Volatility 
r1 = log(p1(2:end)) - log(p1(1:end-1));
r2 = log(p2(2:end)) - log(p2(1:end-1));
v1 = abs(r1);
v2 = abs(r2);
dv = d(2:end);

figure
subplot(2,1,1)
plot(dv,v1,'r')
xlabel('Year')
ylabel('Stock Volatility')
subplot(2,1,2)
plot(dv,v2,'g')
datetick('x',10)
xlabel('Year')
ylabel('Bond Volatility')

dfa(v1,1)
dfa(v2,1)



% Moving averages
SMA50 = tsmovavg(p1,'s',50,1);
SMA200 = tsmovavg(p1,'s',200,1);

figure
plot(d,p1,'k');
hold
plot(d,SMA50,'r');
plot(d,SMA200,'g');
datetick('x',10)
xlabel('Year')
ylabel('Price')
