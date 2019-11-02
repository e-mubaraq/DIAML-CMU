% DItutorial5b.m
% Autoregression and moving average


% Load System Demand data from Eirgrid
[date,time,x] = textread('EirGridSystemDemand.csv','%s%s%d','delimiter',',','headerlines',1);
datetime = strcat(date,{' '},time);
d = datenum(datetime,'dd/mm/yyyy HH:MM');

% Select years 2003-2005
ind = find(2003<=year(d) & year(d)<=2005);
d = d(ind);
x = x(ind);


% Autocorrelation;
n = length(x);
a = xcorr(x,'coeff');
figure
plot([0:96*10]/(96),a(n:n+96*10),'k.-')
xlabel('Lag, days')
ylabel('Autocorrelation')


% Human activity; Seasonality; 


% Month of year
for i=1:12
    imonth = find(month(d)==i);
    xavemonth(i) = nanmean(x(imonth));
end
figure
bar(xavemonth)
xlabel('Month')
ylabel('Average Demand, MW')


% Time of day
for i=1:24
    ihour = find(hour(d)==i-1);
    xavehour(i) = nanmean(x(ihour));
end
figure
bar(xavehour)
xlabel('Hour')
ylabel('Average Demand, MW')

% Time of year
toy = mod(d-datenum('01-Jan-2003'),365)+1;
figure
plot(toy,x,'.');
xlabel('Time of year')

% Time of week
for i=1:7
    iday = find(weekday(d)==i);
    xaveday(i) = nanmean(x(iday));
end
days = {'Sun','Mon','Tue','Wed','Thu','Fri','Sat'};

figure
bar(xaveday)
xlabel('Day')
ylabel('Average Demand, MW')    
set(gca,'XTickLabel',days);

% is the weekend different to weekday?
iweekend = find(weekday(d)==1 | weekday(d)==7);
iweekday = find(2<= weekday(d) & weekday(d) <=6);
xweekend = x(iweekend);
xweekday = x(iweekday);

[h,p] = ttest2(xweekday,xweekend,0.05,'both')
[h,p] = ttest2(xweekday,xweekend,0.05,'right')
