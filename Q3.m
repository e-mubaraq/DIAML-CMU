manufacturing = xlsread('valueAddedManufacturing.xlsx'); % Investment in transport with private participation (current US$)
transport_data = xlsread('transportInvestment.xlsx'); % Machinery and transport equipment (% of value added in manufacturing)
date = ['2000';'2001';'2002';'2003';'2004';'2005';'2006';'2007';'2008';'2009';'2010';'2011';'2012';'2013';'2014';'2015']
m_india = manufacturing(88,:)';
t_india = transport_data(88,:)';

corrCoeffic = corrcoef(t_india , m_india , 'Rows', 'Complete')
years = datenum(date,'yyyy');
y2020 = datenum('2020','yyyy');

india_mdl = fitlm(t_india , m_india, 'VarNames',{'indiaTransport','indiaManufacturing'})
plot(india_mdl)
xlabel('Investment in transport')
ylabel('Value added in manufacturing')
title('Regression model for Transport investments and Value added in manufacturing')

t_mdl = fitlm(years,t_india); % Linear regression model of my x against years
t2020 = predict(t_mdl, y2020);
manuf2020 = predict(india_mdl, y2020)


airTr = xlsread('AirTraffic.xlsx');
gdpData = xlsread('GDPperCapita2010');

corrCoeffic = corrcoef(gdpData , airTr , 'Rows', 'Complete')

air_mdl = fitlm(gdpData, airTr, 'VarNames',{'gdpPerCapita','airTrafficFreights'})

plot(air_mdl)
xlabel('GDP per capita');
ylabel('Air Traffic Freights');
title('Regression model for Air Traffic(Freights) and GDP per capita');

[h,p,ci,stats] = ttest2(gdpData,airTr)