%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data and Inference
% Lab 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

timeSpent  = [NaN 20 11 NaN NaN NaN 36 30 12 30 24 48 NaN 13 14 NaN 30];
mean(timeSpent(~isnan(timeSpent)))
std(timeSpent(~isnan(timeSpent)))
noResponse = length(timeSpent(isnan(timeSpent)));
bar(timeSpent); ylabel('Time spent in hours');

%% World Bank Data API
% review the content of the data on the website http://data.worldbank.org/
% Reading data 
% The file below was downloaded from World bank and contains the data for
% Forest area (% of land area)
% download a csv file from worldbank and put it in your working directory
filename = 'wordbankcsvfile';
fid = fopen(filename,'r');
formatSpec = strcat(repmat('%s', 1, 5 + length(1960:2012)));
land_data = textscan(fid,formatSpec, 'delimiter',',','headerlines',3, 'CollectOutput', 1);
land_data = land_data{1};
fclose(fid);
% select only the numeric data 
nland_data = land_data;
%# check where numeric data starts and adjust the column extracted below (1:34) accordingly
nland_data(:, 1:34) = []; %# make sure you do this only once
% select the country names
countryNames = land_data;
countryNames(:, 2:end) = [];
[nr, nc] = size(countryNames);
for ii = 1:nr
   disp(strrep(countryNames{ii}, '"', ' '));
end

%# read the documentation about cell manupulation
% another option to read this data is to use functions such as
%# "importdata", "xlsread", "textread","csvread", ...

%% Select a portion of the data 
array1 = [12 125 13 16 177 19 100 -14 -25 -10 25 55 900]';
% select the values of the array between 0 and 100
array1((array1 > 0 & array1 <100))
%# This can be done to stratify data based on a characteristic of your
% choice

%% Using Quandl API
%# Instructions for using quandly from matlab
% https://www.quandl.com/help/matlab

%# You will need an authentication token unless you are doing fewer than 50
% calls per day

%# step 1: install the API 
%# step 2: get the "Quandl code" for the dataset you want to retrieve
BitcoinMarketPriceUSD_code = 'BCHAIN/MKPRU';

bitcoinMarketPriceUSD_data  = Quandl.get(BitcoinMarketPriceUSD_code); 
Quandl.auth('GsUx4-7ZE6bAxBpDg2jD')
data  = bitcoinMarketPriceUSD_data.Data;
t = datenum(bitcoinMarketPriceUSD_data.Time);
%plot.....eg:
plot(t,data)







