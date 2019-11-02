% Data Inference and Applied Machine Learning
% Assignment1
% Name: Mubarak Mikail
% Andrew ID: mmikail

%% Q1
%{
This code assumes that the paper is folded from up to down not folded in
half and another half. Hence it will be an arithmetic progression A.P with
a common difference of 1mm = 0.001m
%}
syms a n d T S
a = 0.001;
d = 0.001;
T = a+(n-1)*d > 8848;
num_of_folds = round(solve(T,n));
num_of_folds = num_of_folds(1)

%% Q2
%{
This program solves for t from the decay formula given using the matlab
symbolic solve function
%}
syms v vo a t
a = 0.1;
v = vo * exp(-a*t) == 0.5*vo;
time_to_reduce = double(solve(v,t))

%% Q3
%{
Compound interest for 1,2,3,4 and 5 years on a principal of $100 and annual rate of 5%
%}
P = 100;
n = 12;
r = 0.05;
t=1:5;
Amount = round(P*(1+(r/n)).^(n*t))
figure
plot(t,Amount)
title("Question 3")
xlabel("Years")
ylabel("Compounded Amount")
grid("on");

%% Q4
%{
    Here we calculate the montly amount to be paid back for 1,2 and 3
    years on a loan of $20,000 by using the Loan formula.
%}
p = 20000; % Principal
r = 0.01;  % interest rate: 1%;
n = 12:12:36;    % number of months
amount = round(p*r*(1+r).^n./((1+r).^n -1)); % Loan formula

monthly_payments = amount

%% Q5
%{
Cummulative profits based on initial investment and increasing number of
customers
%}
syms a r n S
a = 100;
r = 1.01;
S = a*(r^n -1)/(r-1) == 10000;

n = round(solve(S,n))   % number of days to make a profit equal to the initial investment
n = 1:100;
profit = 1000*(r.^n -1)/(r-1);
intep = interp1(profit,n,100000) % interpolated number of days to make a profit equal to the initial investment
plot(n,profit,intep,100000,'o');
% plot(n,profit);
grid('on');
title('Graph of cummulated profits per day');
xlabel('Days');
ylabel('Cummulated Profits');

%% Q6
%{ Use xls read to read out data from the xls file and then do matrix
% manipulation to take values for each column out and assign them to new
% variables.
%}
ebola = xlsread('ebola_download.xls');
cases = ebola(:,2);
deaths = ebola(:,3);
dates = ebola(:,1) -1;

date = datetime(dates,'ConvertFrom', 'excel');
missing_dates = (date(1):date(80))';
%interpolate to get ths missing cases and deaths corresponding to the
%missing dates in the data, missing implies all the data in this scenario
missing_cases = round(interp1(date,cases,missing_dates));
missing_deaths = round(interp1(date,deaths,missing_dates));

%index for cases when cases > 100, 500... the index is used to find the dates and number of cases on that day.
cindex_100 = min(find(missing_cases>100));
case100 = missing_dates(cindex_100);
c100 = missing_cases(cindex_100);
cindex_500 = min(find(missing_cases>500));
case500 = missing_dates(cindex_500);
c500 = missing_cases(cindex_500);
cindex_1000 = min(find(missing_cases>1000));
case1000 = missing_dates(cindex_1000);
c1000 = missing_cases(cindex_1000);
cindex_2000 = min(find(missing_cases>2000));
case2000 = missing_dates(cindex_2000);
c2000 = missing_cases(cindex_2000);
cindex_5000 = min(find(missing_cases>5000));
case5000 = missing_dates(cindex_5000);
c5000 = missing_cases(cindex_5000);

c_dates = [case100 case500 case1000 case2000 case5000] %dates when number of cases exceeded 100,500 ...
cases_intp = [c100 c500 c1000 c2000 c5000];     %corresponding cases at these dates

%index for cases when deaths > 100, 500... the index is used to find the dates and number of deaths on that day
dindex_100 = min(find(missing_deaths>100));
death100 = missing_dates(dindex_100);
d100 = missing_deaths(dindex_100);
dindex_500 = min(find(missing_deaths>500));
death500 = missing_dates(dindex_500);
d500 = missing_deaths(dindex_500);
dindex_1000 = min(find(missing_deaths>1000));
death1000 = missing_dates(dindex_1000);
d1000 = missing_deaths(dindex_1000);
dindex_2000 = min(find(missing_deaths>2000));
death2000 = missing_dates(dindex_2000);
d2000 = missing_deaths(dindex_2000);
dindex_5000 = min(find(missing_deaths>5000));
death5000 = missing_dates(dindex_5000);
d5000 = missing_deaths(dindex_5000);

d_dates = [death100 death500 death1000 death2000 death5000] % dates when number of deaths exceeded 100,500 ...
deaths_intp = [d100 d500 d1000 d2000 d5000];     %corresponding deaths at these dates

figure
plot(missing_dates,missing_cases,missing_dates,missing_deaths,c_dates,cases_intp,'o',d_dates,deaths_intp,'x')
grid on;
xlabel('Time');
ylabel('Number of Ebola cases / deaths');
title('Graph showing the dates where Ebola cases and deaths exceeded certain limits');
legend('Ebola cases','Ebola deaths');

%% Q7
%{ Calculate average growth rate per day in percentage with the formula, rate = (new/old -1)*100.
%}
ebola = xlsread('ebola_download.xls');
cases = ebola(:,2);
deaths = ebola(:,3);
dates = ebola(:,1) -1;

date = datetime(dates,'ConvertFrom', 'excel');
missing_dates = (date(1):date(80))';

missing_cases = round(interp1(date,cases,missing_dates));
missing_deaths = round(interp1(date,deaths,missing_dates));

data_size = size(missing_cases);
data_size = data_size(1);
for i = 2:data_size
    dGrate(i) = (missing_deaths(i)/missing_deaths(i-1) -1)*100;
    cGrate(i) = (missing_cases(i)/missing_cases(i-1) -1)*100; 
end

avgDeathsRate = mean(dGrate)
avgCasesRate = mean(cGrate)

%% Q8
% This code helps to plot number of Ebola deaths against number of Ebola cases

ebola = xlsread('ebola_download.xls');
cases = ebola(:,2);
deaths = ebola(:,3);
dates = ebola(:,1) -1;

date = datetime(dates,'ConvertFrom', 'excel');
missing_dates = (date(1):date(80))';

missing_cases = round(interp1(date,cases,missing_dates));
missing_deaths = round(interp1(date,deaths,missing_dates));

figure
plot(missing_deaths,missing_cases); % plot number of Ebola deaths against number of Ebola cases
title('Graph of number of Ebola deaths versus number of Ebola cases');
xlabel('Number of Deaths');
ylabel('Number of Cases');
grid on

for l = 2:data_size
    ratio(l) = missing_deaths(l)/missing_cases(l); 
end
avgRatio = mean(ratio)

%% Q9
%{Extract Adjusted closing prices, 
%normalize so that first value is 100 and plot time series for both ETFs(SPY and TLT)
%}
[Dates, open, High, Low, Close, AdjClose,Volume] = textread ('TLT.csv','%s%f%f%f%f%f%f', 'delimiter',',', 'headerlines',1);
[DatesSP, openSP, HighSP, LowSP, CloseSP, AdjCloseSP, Volume,var8,var9] = textread ('SPY.csv','%s%f%f%f%f%f%f%f%f', 'delimiter',',', 'headerlines',1);
d = datetime(Dates);
dateSP = datetime(DatesSP); 
SP_Adj = AdjCloseSP.*100./AdjCloseSP(1);
TLT_Adj = AdjClose.*100./AdjClose(1);

figure
plot(dateSP,SP_Adj,d,TLT_Adj);
grid('on')
title('S&P500 index and long-term Treasury Bond Time Series.')
xlabel('TIME between 01/01/2014 - 08/31/2015');
ylabel('ETFs adjusted closing prices');
legend('SPY','TLT');

%% Q10
%Calculate average, minimum and maximum daily return for both ETFs from Q9

% r = (p/po) -1;
[Dates, open, High, Low, Close, AdjClose,Volume] = textread ('TLT.csv','%s%f%f%f%f%f%f', 'delimiter',',', 'headerlines',1);
[DatesSP, openSP, HighSP, LowSP, CloseSP, AdjCloseSP, Volume,var8,var9] = textread ('SPY.csv','%s%f%f%f%f%f%f%f%f', 'delimiter',',', 'headerlines',1);
b = size(AdjClose);
b = b(1);
for k= 2:b
    ret(k) = (AdjClose(k)/AdjClose(k-1))-1;
end
avgr = mean(ret)*100;
minr = min(ret)*100;
maxr = max(ret)*100;
TLT = [avgr minr maxr]

bs = size(AdjCloseSP);
bs = bs(1);
for j= 2:bs
    rs(j) = (AdjCloseSP(j)/AdjCloseSP(j-1))-1;
end
avgrs = mean(rs)*100;
minrs = min(rs)*100;
maxrs = max(rs)*100;
SPY = [avgrs minrs maxrs]