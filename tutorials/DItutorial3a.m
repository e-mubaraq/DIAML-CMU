% DItutorial3a.m
% Calculating descriptive statistics

% Dataset: carbig.mat: Measurements of cars, 1970-1982
load carbig; 
whos

% Centrality: mean, median, mode
figure
hist(Weight,30)
xlabel('Weight')
ylabel('Number')

Wmean = mean(Weight)
Wmedian = median(Weight)
Wmode = mode(Weight)



% Variability, standard deviation and variance; 
Wstd = std(Weight)
Wvar = var(Weight)



% Ranking and ordering data: sort, prctile
Wsort = sort(Weight)
Wsort = sort(Weight,'descend')
p = [25 50 75];
Wp = prctile(Weight,p)


% Statistics from imperfect data: NaN, nansum, nanmean, nanstd
MPGmean = mean(MPG)
MPGmean = nanmean(MPG)
MPGstd = nanstd(MPG)

% printing output
fprintf(1,'Average weight = %f\n',Wmean);
fprintf(1,'Average weight = %6.2f\n',Wmean);
string = sprintf('Average weight = %6.2f',Wmean);
disp(string)

% Output statistical summary tables
Org = cellstr(Origin);
UniOrg = {'USA','Japan','Germany'};
M = length(UniOrg);
X = [Weight MPG Acceleration Horsepower];
for i=1:M
    ind = find(strcmp(Org,UniOrg(i))==1)
    Table(i,:) = nanmean(X(ind,:));
end
    
% output table of results
Colnames = {'Weight','MPG','Acceleration','Horsepower'};
Rownames = UniOrg;
Blotter = dataset([{round(Table)},Colnames],'obsnames',Rownames);
disp(Blotter);


