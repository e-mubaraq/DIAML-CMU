% DItutorial3b.m
% Statistical distributions

% Random number generators: rand and randn
n = 10000;
x1 = rand(n,1); % uniformly distributed data
y1 = rand(n,1);
x2 = randn(n,1); % normally distributed data
y2 = randn(n,1);
figure
subplot(1,2,1)
plot(x1,y1,'.');
xlabel('x_1')
ylabel('y_1')
subplot(1,2,2)
plot(x2,y2,'.');
xlabel('x_2')
ylabel('y_2')

% simulate tossing a coin using rand
n = 100;
c = rand(n,1);
cheads = find(c>0.5); % above 0.5 equals head
fheads = length(cheads)/n;

% Dataset: carbig.mat: Measurements of cars, 1970-1982
load carbig;

% Histograms
figure
x = Weight;
hist(x)

% Frequency 
xmin = min(x);
xmax = max(x);
xbin = linspace(xmin,xmax,10);
[n1,n2] = hist(x,xbin);
percentage = 100*n1/sum(n1);
bar(xbin,percentage,'k')
xlabel('Weight, pounds')
ylabel('Frequency, %')


% Cumulative Distribution Function (CDF)
n = length(x);
xsort = sort(x);
plot(xsort,[1:n]/(n+1),'k.-');
xlabel('Weight, pounds')
ylabel('Probability')


% Pie-charts
Org = cellstr(Origin);
UniOrg = unique(Org);
M = length(UniOrg);
for i=1:M
    ind = find(strcmp(Org,UniOrg(i))==1);
    freq(i) = length(ind);
end
figure
pie(freq,UniOrg)

% Horizonal bar charts
figure
barh(freq)
set(gca,'YTickLabel',UniOrg);
xlabel('Number')

% Boxplots
% Box plot of car gas mileage grouped by country
load carsmall;
boxplot(MPG, Origin)
boxplot(MPG, Origin, 'sym','r*', 'colors',hsv(7))
boxplot(MPG, Origin, 'grouporder', ...
       {'France' 'Germany' 'Italy' 'Japan' 'Sweden' 'USA'})
ylabel('MPG') 
   
% Plot by median gas mileage
[sortedMPG,sortedOrder] = sort(grpstats(MPG,Origin,@median));
pos(sortedOrder) = 1:6;
boxplot(MPG, Origin, 'positions', pos)
ylabel('MPG') 

% qq plots
% Is weight normally distributed
figure
qqplot(Weight)



% Exploring data in 2D 
load carbig;
figure
plot(Weight,Acceleration,'k.');
xlabel('Weight')
ylabel('Acceleration')

figure
plot(Horsepower,MPG,'k.');
xlabel('Horsepower')
ylabel('MPG')

figure
plot(Weight,MPG,'k.');
xlabel('Weight')
ylabel('MPG')

% histogram on a 7x7 grid of bins.
load carbig;
X = [MPG,Weight];
figure
hist3(X,[7 7]);
xlabel('MPG'); ylabel('Weight');zlabel('Frequency')
set(gcf,'renderer','opengl');
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
       
% Exploring data in 3D  
plot3(Weight,Horsepower,MPG,'.')
xlabel('Weight')
ylabel('Horsepower')
zlabel('MPG')
grid;

% Visualizing matrices
X = randn(10,20);
figure
imagesc(X);
colorbar;
xlabel('x');ylabel('y');

% Surface plots
Z = peaks;
plot(peaks)

figure
surf(Z);
xlabel('x');ylabel('y');zlabel('z');

% Barplot in 3D
figure
bar3(Z);
xlabel('x');ylabel('y');zlabel('z');

% Mesh plots
mesh(Z)
xlabel('x');
ylabel('y');
zlabel('z');


% Visualization in 4D
load carbig;
Org = cellstr(Origin);
ind1 = find(strcmp(Org,'USA')==1);
ind2 = find(strcmp(Org,'USA')~=1);
plot3(Weight(ind1),Horsepower(ind1),MPG(ind1),'r.')
hold;
plot3(Weight(ind2),Horsepower(ind2),MPG(ind2),'b.')
xlabel('Weight')
ylabel('Horsepower')
zlabel('MPG')
grid
legend('USA','Non-USA');


