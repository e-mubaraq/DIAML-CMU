% Data Inference and Applied Machine Learning
% Assignment4
% Name: Mubarak Mikail
% Andrew ID: mmikail

%% Q1

house_data = xlsread("monthlyHousePricesUK.xls");
h_dates = datetime(house_data(:,1) , 'ConvertFrom', 'excel');
avg_price = round(house_data(:,2));

[Dates, open, High, Low, Close,Volume, AdjClose] = textread ('FTSE100.csv','%s%f%f%f%f%f%f', 'delimiter',',', 'headerlines',1);
Dates = flipud(Dates);
f_date = datetime(Dates,'InputFormat','MM/dd/uuuu');
AdjClose = flipud(AdjClose);

b = length(avg_price);
for k= 2:b
    house_ret(k) = (avg_price(k)/avg_price(k-1)) - 1; % explanatory variable
    ftse_ret(k) = (AdjClose(k)/AdjClose(k-1)) - 1; % dependent variable
end

mdl = fitlm(house_ret,ftse_ret, 'VarNames',{'HouseReturns','FTSEReturns'})
figure;
plot(mdl);
xlabel('house monthly returns ');
ylabel('FTSE100 index monthly returns');
title('Regression model for monthly house returns and FTSE returns');
corr_coefficient = corrcoef(house_ret,ftse_ret)

% Conduct hypothesis testing

%[h,p,ci,stats] = ttest(house_ret,ftse_ret)

%% Q2

college_data = csvread('College.csv', 1, 2);

% exploratory variables
num_of_apps = college_data(:,1);
num_of_enrol = college_data(:,3);
num_of_out = college_data(:,8);
num_of_top10 = college_data(:,4);
num_of_top25 = college_data(:,5);

grad_rate = college_data(:,17); % dependent variable

% Correlation coefficients
apps_coeff = corrcoef(num_of_apps,grad_rate)
enrol_coef = corrcoef(num_of_enrol,grad_rate)
out_coeff = corrcoef(num_of_out,grad_rate)
top10_coeff = corrcoef(num_of_top10,grad_rate)
top25_coeff = corrcoef(num_of_top25,grad_rate)

% exploratory matrix
X = [num_of_apps, num_of_enrol, num_of_out, num_of_top10, num_of_top25];
X_str = {'num_of_apps', 'num_of_enrol', 'num_of_out', 'num_of_top10', 'num_of_top25','GradRate'};
%f_mdl = fitlm(X,grad_rate,'VarNames',{'num_of_apps', 'num_of_enrol', 'num_of_out', 'num_of_top10', 'num_of_top25','GradRate'})
f_mdl = fitlm(X,grad_rate,'VarNames',X_str)
stepW_mdl = stepwiselm(X,grad_rate,'linear','VarNames',X_str)

bic_mdl = stepwiselm(X,grad_rate,'linear', 'Criterion', 'bic','VarNames',X_str)

aGRate = predict(f_mdl, X);
gRate = predict(stepW_mdl , X);
mapeA = mean(abs(aGRate - grad_rate)./ grad_rate)
mapeG = mean(abs(gRate - grad_rate)./ grad_rate)

grCMU = aGRate(88)
gradCMU = grad_rate(88)

%% Q3
manufacturing = xlsread('valueAddedManufacturing.xlsx'); % Investment in transport with private participation (current US$)
transport_data = xlsread('transportInvestment.xlsx'); % Machinery and transport equipment (% of value added in manufacturing)

date = ['2000';'2001';'2002';'2003';'2004';'2005';'2006';'2007';'2008';'2009';'2010';'2011';'2012';'2013';'2014';'2015'];
m_india = manufacturing(88,:)';
t_india = transport_data(88,:)';

corrCoeffic = corrcoef(t_india , m_india , 'Rows', 'Complete')
years = datenum(date,'yyyy');
y2020 = datenum('2020','yyyy');

india_mdl = fitlm(t_india , m_india, 'VarNames',{'indiaTransport','indiaManufacturing'})
figure;
plot(india_mdl)
xlabel('Investment in transport')
ylabel('Value added in manufacturing')
title('Regression model for Transport investments and Value added in manufacturing')

t_mdl = fitlm(years,t_india); % Linear regression model of my x against years
t2020 = predict(t_mdl, y2020);
manuf2020 = predict(india_mdl, y2020)

%% Q4

Quandl.api_key('aKV-d1yoC1-RFhu3z_M-');
isr_unemp = Quandl.get('ODA/ISR_LUR');

isr_date = datenum(getabstime(isr_unemp));
isr_date = isr_date(1:34);
unemp_data = getdatasamples(isr_unemp , 1:34);

isr_mdl = fitlm(isr_date , unemp_data, 'VarNames',{'date','unemployementRate'})
plot(isr_mdl)
unemp_predict_err = isr_mdl.Residuals.Raw;
% mape_unemp = sum(abs(unemp_predict_err)./ unemp_data)/34
mape_unemp = mean(abs(unemp_predict_err)./ unemp_data)

unemp_2020 = predict(isr_mdl, 738155)
% MAPE = abs(unemp_2020 - 3.9740)/3.9740  %percentage accuracy

