% Applied Machine Learning
% AML: Tuorial 1b
% Copyright (c) 2019 Patrick E. McSharry (patrick@mcsharry.net)


% Fitting a polynomial to a sinusoid
% Study the effect of noisy measurements, over-fitting and evaluation using
% in-sample and out-of-sample approaches

% Data generating process
T = 10;
A = 0.5;
t = linspace(0,1,T)';
noise = A*randn(T,1);
x = sin(2*pi*t);
y = x + noise;

% Visualization
figure
tp = linspace(0,1,100);
yp = sin(2*pi*tp);
plot(tp,yp,'k','LineWidth',2);
hold
plot(t,y,'ro','MarkerFaceColor','r');
xlabel('t'),ylabel('y(t)')
legend('Signal','Observations');

% Loop over polynomials of increasing order and complexity
for i=1:10
    subplot(5,2,i)
    b = polyfit(t,y,i-1);
    yphat = polyval(b,tp);
    plot(tp,sin(2*pi*tp),'k','LineWidth',2);
    hold
    plot(t,y,'ro','MarkerFaceColor','r');
    plot(tp,yphat,'b','LineWidth',2);
    title(sprintf('Order: %d',i-1));
    xlabel('t'),ylabel('y(t)')
    yhat = polyval(b,t);
    E = yhat - y;
    Ep = yphat - yp;
    RMSE(i) = sqrt(mean(E.^2));
    RMSEp(i) = sqrt(mean(Ep.^2));
end

% Monitor effect of complexity on in-sample and out-of-sample error
figure
polyorder = [0:9];
plot(polyorder,[RMSE; RMSEp]','o-','LineWidth',2);
ylabel('RMSE')
xlabel('Polynomial order');
legend('In-sample','Out-of-sample','Location','SouthWest')
