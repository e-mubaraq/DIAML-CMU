% DItutorial2a.m
% Manipulating Data

% intersect
a = [9 9 9 9 9 9 8 8 8 8 7 7 7 6 6 6 5 5 4 2 1]
b = [1 1 1 3 3 3 3 3 4 4 4 4 4 10 10 10]
 
[c1,ia1,ib1] = intersect(a,b)
% returns
c1 = [1 4], ia1 = [21 19], ib1 = [3 13]
 
[c2,ia2,ib2] = intersect(a,b,'stable')
% returns
c2 = [4 1], ia2 = [19 21]', ib2 = [9 1]'
 

% setdiff
[c1,ia1] = setdiff(a,b)
c1 = [2 5 6 7 8 9]
ia1 = [20 18 16 13 10 6]
 
[c2,ia2] = setdiff(a,b,'stable')
% returns
c2 = [9 8 7 6 5 2]
ia2 = [1 7 11 14 17 20]'
 
       
       
% union
[c1,ia1,ib1] = union(a,b)
% returns
c1 = [1 2 3 4 5 6 7 8 9 10]
ia1 = [20 18 16 13 10 6]
ib1 = [3 8 13 16]
 
[c2,ia2,ib2] = union(a,b,'stable')
% returns
c2 = [9 8 7 6 5 4 2 1 3 10]
ia2 = [1 7 11 14 17 19 20 21]'
ib2 = [4 14]'
 
 

% unique
a = [9 9 9 9 9 9 8 8 8 8 7 7 7 6 6 6 5 5 4 2 1]
 
[c1,ia1,ic1] = unique(a)
% returns
c1 = [1 2 4 5 6 7 8 9]
ia1 = [21 20 19 18 16 13 10 6]
ic1 = [8 8 8 8 8 8 7 7 7 7 6 6 6 5 5 5 4 4 3 2 1]
 
[c2,ia2,ic2] = unique(a,'stable')
% returns
c2 = [9 8 7 6 5 4 2 1]
ia2 = [1 7 11 14 17 19 20 21]'
ic2 = [1 1 1 1 1 1 2 2 2 2 3 3 3 4 4 4 5 5 6 7 8]'

% dates in the year
d = datenum('01-Jan-2014'):datenum('31-Dec-2014');
d1 = datenum('04-Apr-2014');
ind = find(d==d1)

% dates with US daylight saving
ddls = datenum('09-Mar-2014'):datenum('02-Nov-2014');
c = intersect(d,ddls);
Nddls = length(c);
% dates without US daylight saving
c = setdiff(d,ddls);
ndwdls = length(c);


% for loop
x = 1;
for i=1:10
   x = x+x;
end

% while loop
% find how many doubles to exceed 1000
i = 1;
x = 1;
while x<1000
    disp(sprintf('i = %d, x = %d',i,x));
    i = i+1;
    x = x+x; 
end


% find occurences of Friday the 13th in 2015
d = datenum('01-Jan-2015'):datenum('31-Dec-2015');
for i=1:length(d)
    if (weekday(d(i))==6 & day(d(i))==13)
        disp(datestr(d(i)))
    end
end

% find end of the month dates
ind = find(month(d(1:end-1)) ~= month(d(2:end)));
datestr(d(ind))

% find end of month falling on Mon or Tue
ind = find(month(d(1:end-1)) ~= month(d(2:end)) & (weekday(d(1:end-1))==2 | weekday(d(1:end-1))==3));
datestr(d(ind))

% function example
% function to calculate mean square error

function MSE = meansquarederror(x, xhat)
% MSE = meansquarederror(x, xhat) calculates the mean-squared-error using
% observations x and forecasts xhat. 
MSE = mean((x- xhat).^2);

% use a structure to return more information
function stats = meansquarederror(x, xhat)
% stats = meansquarederror(x, xhat) calculates the mean-squared-error using
% observations x and forecasts xhat. 
stats.x = x;
stats.xhat = xhat;
stats.n = length(x);
stats.MSE = mean((x- xhat).^2);



