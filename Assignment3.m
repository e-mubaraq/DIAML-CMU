% Data Inference and Applied Machine Learning
% Assignment3
% Name: Mubarak Mikail
% Andrew ID: mmikail
%% Q1

daily_energy_intake = [5260, 5470, 5640, 6180, 6390, 6515, 6805, 7515, 7515, 8230, 8770];
% alt_hypo = round(mean(daily_energy_intake));    %sample mean
m_p = 7725;
n = length(daily_energy_intake);
[h,p,ci,stats] = ttest(daily_energy_intake , 7725)

m_obs = round(mean(daily_energy_intake))    %sample mean
sample_std = round(std(daily_energy_intake))    %sample standard deviation
sem = sample_std/sqrt(n)    %sample error of the mean
z = round((m_p - m_obs) / sem)    %test-statistic
df = n-1 %degree of freedom

%% Q2

mean_i = 74;
mean_o = 57;
n_i = 42;
n_o = 61;
s_i = 7.4;
s_o = 7.1;

sn1 = (s_i^2)/n_i; % to be used in the degree of freedom and test statistic formulae below
sn2 = (s_o^2)/n_o; % to be used in the degree of freedom and test statistic formulae below

df = (sn1 + sn2)^2 / (sn1^2/(n_i -1) + sn2^2/(n_o -1))
t = (mean_i - mean_o)/sqrt(sn1 + sn2)

p = 1 - tcdf(t,df)

%% Q3

[f_data,f_text] = xlsread('fertility_2013');
[g_data,g_text] = xlsread('gdp_ppp.xlsx');

f_init = f_text(:,2);
f_init = f_init(2:218);

scatter(g_data,f_data);
%text(g_data,f_data,f_init);
title("A scatter plot of fertility rate against GDP per capita PPP for different countries");
xlabel("GDP per capita PPP (current international $)");
ylabel("Fertility rate, total (births per woman) ");

c = corrcoef(g_data , f_data, 'Rows', 'complete')

%% Q4

house_data = xlsread("monthly.xls");
dates = datetime(house_data(:,1) , 'ConvertFrom', 'excel');
avg_price = round(house_data(:,2));

figure;
plot(dates,avg_price)
title('Timeseries of average house prices in the UK from Jan 1991 to Dec 2016');
xlabel('Date');
ylabel('Average House Price in Pounds');
legend('Average house prices in the UK');

b = size(avg_price);
b = b(1);
b = length(avg_price);
for k= 2:b
    ret(k) = (avg_price(k)/avg_price(k-1))-1;
end

cum_ret = cumsum(ret);
cum_ret = cum_ret';
norm_cum_ret_house = round(cum_ret.*100./cum_ret(2));
%c = corrcoef(ret);

annual_ret = ((prod(ret + 1))^(12/b) - 1) * 100

figure;
acf(ret',20);
title('Autocorrelation function of the monthly returns on housing in the UK');
ylabel('Autocorrelation function');
xlabel('Lag');
grid on;

%% Q5

[Dates, open, High, Low, Close,Volume, AdjClose] = textread ('FTSE100.csv','%s%f%f%f%f%f%f', 'delimiter',',', 'headerlines',1);

Dates = flipud(Dates);
date = datetime(Dates,'InputFormat','MM/dd/uuuu');
AdjClose = flipud(AdjClose);
s = size(AdjClose);
s = s(1);
for i= 2:s
    r(i) = (AdjClose(i)/AdjClose(i-1))-1;
end

ann_ret = ((prod(r + 1))^(12/s) - 1) * 100

cum_r = cumsum(r);
cum_r = cum_r';
norm_cum_ret = round(cum_r.*100./cum_r(2));

norm_cum_ret = norm_cum_ret(2:312);
date = date(2:312);
norm_cum_ret_house = norm_cum_ret_house(2:312); % From Q4
dates = dates(2:312);

figure;
plot(date, norm_cum_ret, dates, norm_cum_ret_house);
grid on;
title('Cummulative returns Graph for FTSE and UK house prices');
xlabel('Date');
ylabel('Cummulative returns in pounds');
legend('FTSE' , 'UK house prices');
