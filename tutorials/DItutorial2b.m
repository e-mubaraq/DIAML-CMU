% DItutorial2b.m
% Exploring data

% Graphing data in one dimension
figure
t = linspace(0,100,1000);
x = sin(t);
plot(t,x)
xlabel('t')
ylabel('x(t)')


% Scatter plots
n = 1000;
x = rand(n,1);
y = rand(n,1);
figure
plot(x,y,'.')
xlabel('x')
ylabel('y')

figure
scatter(x,y,'s','r');
xlabel('x')
ylabel('y')


% Recurrence plots;
t = linspace(0,100*pi,1000);
x = sin(t);
x1 = x(1:end-1);
x2 = x(2:end);
plot(x1,x2,'k');


% Combining plots
t = linspace(0,10*pi,1000);
x = sin(t);
y = cos(t);
figure
plot(t,x,'r');
hold
plot(t,y,'g');
xlabel('t')
legend('x = cos(t)','y = sin(t)')


% Combining plots with different verticle scales: plotyy
t = linspace(0,10*pi,1000);
x = sin(t);
y = 100+100*cos(t);
figure
[ax,h1,h2] = plotyy(t,x,t,y);
ylabel(ax(1),'x = sin(t)')
ylabel(ax(2),'y = cos(t)')


% Multiple plots: subplot
figure
subplot(2,1,1)
plot(t,x,'r');
xlabel('t')
ylabel('x = sin(t)')
subplot(2,1,2)
plot(t,y,'g');
xlabel('t')
ylabel('y = cos(t)')

figure
t1 = linspace(0,10*pi,1000);
t2 = linspace(0,10*pi,100);
x1 = sin(t1);
x2 = sin(t2);
plot(t1,x1,'r');
hold
plot(t2,x2,'ko');
xlabel('t')
ylabel('x = sin(t)')

% Semi-logarithmic axes
n = [1:10];
x = 2.^n;
figure
subplot(3,1,1)
plot(n,x,'ko-');
xlabel('n')
ylabel('x')
subplot(3,1,2)
semilogy(n,x,'ko-');
xlabel('n')
ylabel('x')
subplot(3,1,3)
loglog(n,x,'ko-');
xlabel('n')
ylabel('x')

% Labels and presentation 
figure
n = 30;
x = cumsum([1:n]);
plot(x,'ko-','LineWidth',2)
xlabel('Time, days')
ylabel('Position, m');

% Displaying time and dates
figure
d = datenum('01-Jan-2010'):datenum('31-Dec-2014');
nd = length(d);
x = cumsum([1:nd]);
plot(d,x,'k','LineWidth',2);
datetick('x',10)
grid
xlabel('Year')
ylabel('Position, m')

% printing figures

% print for a word document or internet
print figure -djpeg95

% print for publication (high resolution image)
print figure -dtiffnocompression


