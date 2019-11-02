%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data and Inference, Fall 2018 %%%
% Lab 1 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Loading data into Matlab
% Using csvread function to read comma separated file
% The file SP500.csv was downloaded from yahoo finance website
% lets read the historical data for S&P 500 starting at row 1 column 0
SP500 = csvread('SP500.csv', 1, 0);
% Type "doc csvread" in the MATLAB commmand line for the documentation about "csvread" function 

%% using textread instead
% Number of outputs must match the number of unskipped input fields
% allows to specify the format and the delimiter

[Dates, open, High, Low, Close, Volume, AdjClose] = textread ('SP500.csv','%s%f%f%f%f%f%f', 'delimiter',',', 'headerlines',1);

%% Using xlsread
% lets use malaria data from WHO 
% http://www.who.int/entity/malaria/publications/world_malaria_report_2013/wmr13_annex_1.xls?ua=1
%notice what rows and column were read by the function !!
malariaData = xlsread('wmr13_annex_1.xls');

% Read specific range in the data 
malariaData2 = xlsread('wmr13_annex_1.xls', 'D:J');

%% Using fscanf
% returns column vector and works the same as fscanf in C language
% The file monaloa is from http://www.colorado.edu/geography/class_homepages/geog_4023_s11/monaloa.txt
fileID = fopen('monaloa.txt', 'r');
A = fscanf(fileID, '%s, %s, %s,%s')
B = fscanf(fileID, '%s, %s, %s,%s')
D = fscanf(fileID, '%s, %s, %s,%s')
% Have you noticed the difference between A, B and D?


%% FIND
%%%%%%%%%%%%%%%%%%%%%%%%%%
% finding the indices for numerical values 
%%%%%%%%%%%%%%%%%%%%%%%%%%%
arr = (1:100);
find(arr == 10);
find (arr> 10 & arr <15);
find (arr> 10, 5);
%% flip array/column up to down
flipedDates = flipud(Dates);

%% Manipulatating the dates
%%%%%%%%%%%%%%%%%%%%
% Example: Convert date and time to serial date number
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\
now
numberdates = datenum(Dates);
numberdates = datenum(Dates, 'yyyy-mm-dd');%for speed
disp(numberdates);
% convert date format to a string
DateVector = [2015,1,15,6,7,18];
datestr(DateVector)

%convert date and time to different format
formatOut = 'mm/dd/yy';
datestr(now,formatOut)


%% Comparing string
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% example: case sensitive comparison with strcmp function
%%%%%%%%%%%%%%%%%%%%%%%
fiveDates1 = Dates(1:5);
fiveDates2 = fiveDates1;
fiveDates2(2:4) = fiveDates1(1);
strcmp(fiveDates1, fiveDates2)

%%
%%%%%%%%%%%%%%%%
% Yahoo API
%%%%%%%%%%%%%%%%%%%
% The histogram stock data downloader is available from Mathworks website 
% http://www.mathworks.com/matlabcentral/fileexchange/18458-historical-stock-data-downloader
% lets get the historical prices for Master Card, MacDonalds and IBM 
stocks = hist_stock_data('01012015','14012015','MA', 'MCD','IBM');
% Review the concept of structures in MATLAB

%%
%%%%%%%%%%%%%%%%%%%%%
% Plotting 
%%%%%%%%%%%%%%%%%%%%%%%%
d = datenum(flipedDates,'yyyy-mm-dd');
% plot the adjusted closing prices
plot(d, flipud(AdjClose));
% Review datetick function to label the axes