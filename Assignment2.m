% Data Inference and Applied Machine Learning
% Assignment2
% Name: Mubarak Mikail
% Andrew ID: mmikail
%% Q1
% This code reads data on GDP per capita and Malutrition and then plot a graph
% for all the countries
gdpData = xlsread('GDP_all_years.xlsx');
malData = xlsread('country_malnutrition.xlsx');
gData = gdpData((1:217) ,(24:57));

figure;
plot(gData , malData, 'o');
title('Scatter plot of malnutrition against GDP per capita');
xlabel('GDP per capita (current US$)');
ylabel('Malnutrition prevalence, weight for age(% of children under 5)');

%% Second part of Question 1
% This code reads data on GDP per capita and Malutrition and then plot a graph for
% all the developing regions 
gdpRegData = xlsread('GDP_6regions.xlsx');
malRegData = xlsread('malnutrition_regions.xlsx');

gRegData = gdpRegData((1:6) ,(31:58));

figure;
plot(gRegData , malRegData, 'd');
title('Scatter plot of malnutrition against GDP per capita for all 6 developing regions');
xlabel('GDP per capita (current US$)');
ylabel('Malnutrition prevalence, weight for age(% of children under 5)');
legend('Middle East & North Africa', 'East Asia & Pacific', 'Europe & Central Asia', 'Latin America & Caribbean', 'South Asia', 'Sub-Saharan Africa');

%% Third part of Question 1
% This code reads data on GDP per capita and Malutrition and the plot a graph
% for all 4 income levels
gdpILData = xlsread('GDP_all_years.xlsx' , 'Income_Level');
malILData = xlsread('malnutrition_income.xlsx');

gILData = gdpILData(: ,(31:58));

figure;
plot(gILData , malILData, 'x');
title('Scatter plot of malnutrition against GDP per capita for all 4 income levels');
xlabel('GDP per capita (current US$)');
ylabel('Malnutrition prevalence, weight for age(% of children under 5)');
legend('Low income', 'High income', 'Upper middle income', 'Lower middle income');

%% End of Q1

%% Q2
% This code uses quandl to get data. This timeseries were then plotted with
% the maximum and minimum prices indicated on the time series appropriately
Quandl.api_key('aKV-d1yoC1-RFhu3z_M-');

wheatData = Quandl.get('ODA/PWHEAMT_USD');
crudeOilData = Quandl.get('WGEC/WLD_CRUDE_WTI');
goldData = Quandl.get('BUNDESBANK/BBK01_WT5511');

[wheatData,crudeOilData] = synchronize(wheatData , crudeOilData, 'intersection');
[wheatData,goldData] = synchronize(wheatData , goldData, 'intersection');
[crudeOilData , goldData] = synchronize(crudeOilData, goldData, 'intersection');

sa = get(crudeOilData , 'length');
sz = 1:sa; % dimension of the synchronized time series

oil = getdatasamples(crudeOilData , sz);
gold = getdatasamples(goldData , sz);
wheat = getdatasamples(wheatData , sz);

gold_max_i =  find(gold == max(gold));
co_max_i =  find(oil == max(oil));
wheat_max_i =  find(wheat == max(wheat));
gold_min_i =  find(gold == min(gold));
co_min_i =  find(oil == min(oil));
wheat_min_i =  find(wheat == min(wheat));

cDate = datetime(getabstime(crudeOilData));
gDate = datetime(getabstime(goldData));
wDate = datetime(getabstime(wheatData));


plot(wheatData);
hold on;
plot(crudeOilData);
hold on;
plot(goldData);
hold on;
plot(cDate(co_max_i),max(oil), 'o', cDate(co_min_i),min(oil), '>')
plot(gDate(gold_max_i),max(gold), 'o', gDate(gold_min_i),min(gold), '>')
plot(wDate(wheat_max_i),max(wheat), 'o', wDate(wheat_min_i),min(wheat), '>')
legend('Wheat' , 'Crude Oil' , 'Gold','maximum', 'minimum');
xlabel('Date');
ylabel('Price of commodity');
title('Timeseries for Oil, Gold and Wheat prices');

%% Q3
% This question reads data on C02 emmissions and School enrollment,
% primary(%net) for year 210. Some summary statistics were 
% perfromed on both datasets.

% CO2 emmissions code
co2_emmit = xlsread('CO2_emmissions.xlsx');

co2_mean = nanmean(co2_emmit);
co2_median = nanmedian(co2_emmit);
co2_std = nanstd(co2_emmit);

cperc5 = prctile(co2_emmit , 5);
cperc25 = prctile(co2_emmit , 25);
cperc75 = prctile(co2_emmit , 75);
cperc95 = prctile(co2_emmit , 95);

CO2_Table = table(co2_mean , co2_median , co2_std, cperc5, cperc25, cperc75, cperc95)

%School enrollment code

sch_enroll = xlsread('School_enrollment.xlsx');

sch_mean = nanmean(sch_enroll);
sch_median = nanmedian(sch_enroll);
sch_std = nanstd(sch_enroll);

sperc5 = prctile(sch_enroll , 5);
sperc25 = prctile(sch_enroll , 25);
sperc75 = prctile(sch_enroll , 75);
sperc95 = prctile(sch_enroll , 95);

SCH_Table = table(sch_mean , sch_median , sch_std, sperc5, sperc25, sperc75, sperc95)

%% Q4
% This program shows relationship between GDP per capita and fertility rate
% for all countries in 2010.

[GDP_data , GDP_text] = xlsread('GDP_all_years.xlsx');
[f_data , f_text] = xlsread('Fertility_1990-2010.xlsx');

f_2010 = f_data(: , 21);
GDP_2010 = GDP_data(: , 51);

figure;
scatter(GDP_2010 , f_2010);
title('Scatter plot of Fertility rate vs GDP per capital for all countries in 2010');
ylabel('Fertility rate , total (births per woman)');
xlabel('GDP per capita (current US$)');

% The code below help with visualizing cimmulative distribution function
% for fertility rate in 1990 and 2010
[cdf_f2010 , x2] = ecdf(f_2010);
ecdf(f_2010)
hold on;
ecdf(nanmean(f_2010));
ecdf(nanmedian(f_2010));


f_1990 = f_data(: , 1);
GDP_1990 = GDP_data(: , 31);

[cdf_f90 , x] = ecdf(f_1990);
hold on;
ecdf(f_1990)
ecdf(nanmean(f_1990));
ecdf(nanmedian(f_1990));

legend('CDF for 2010', 'mean for 2010' , 'median for 2010','CDF for 1990', 'mean for 1990' , 'median for 1990');
title('Cummulative distribution graph for fertility rate variable.');
xlabel('Fertility rate, total (births per woman)');
ylabel('Cummulative distribution function');


%% Q5
% Data for CPI and HPI were downloaded for all countries in the year 2016.
% A carefully labelled scatter plot was then made with each country
% uniquely identified by their name on the graph.

[cpi_ndata , cpi_text] = xlsread('CPI2016_FullDataSetWithRegionalTables.xlsx');
[hpi_ndata , hpi_text] = xlsread('hpi-data-2016.xlsx' , 'Rank order');

cpi_country = cpi_text(: , 1);
cpi_country =  cpi_country(2 : 177);
country_init = cpi_text(: , 5);
country_init = country_init(2:177);

hpi_country = hpi_text(: , 2);
hpi_country = hpi_country(6 : 145);

[i_country , hpi_rank, cpi_rank] = intersect(hpi_country , cpi_country);
scatter(cpi_rank , hpi_rank);
text(cpi_rank, hpi_rank, i_country);
title('A scatter plot of different countries HPI vs CPI');
ylabel('Happy Planet Index');
xlabel('Corruption Perception Index');
