clc; clear all; close all
% Same as CurveFitlsq but uses a higher amount of data points
% Behavior is good because even though there should be 
% a "drop" the function compensates and does not generate a drop
s = 1:.01:12;
%y = [0 2 4.8 5.2 5 5.6];
n = numel(s)-1;
y1 = 2.*s(1:n/2) - 1;
y2 = 11*ones(1,n/2);
y1o = awgn(y1,20,'measured');
y2o = awgn(y2,20,'measured');

y = [y1o y2o];
x0 = [0.9 2.9 4.89 7.85 11.50];
% Find the "minimized error".
fun1 = @(x,s) ((x(5)./(x(2)-x(1))).*s - x(1).*x(5)./(x(2)-x(1))).*(heaviside(s-x(1)) - heaviside(s-x(2))) +...
     x(5).*(heaviside(s-x(2))-heaviside(s-x(3))) + ...
    x(5).*(heaviside(s-x(3)) - heaviside(s-x(4)));

x = lsqcurvefit(fun1,x0,s(1:end-1),y)
times = linspace(s(1),s(end-1));
hold on; plot(s(1:end-1),y,'ko')
plot(times,fun1(x,times),'b-')
xlim([times(1), times(end)+5])
legend('Data','Fitted Response'); title('Data and Fitted Curve')
