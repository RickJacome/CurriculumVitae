% LSQCURVEFIT Nonlinear Function
% Attempt Seems good
clear all; close all; clc; format compact
s =[1 2 3 5 6 7 8 12];
y=[0 2 5.4 4.8 5.2 5 5.6 0];
xx = 0:.25:12;
yy = spline(s,y,xx);
plot(s,y,'o',xx,yy)
        
fun = @(x,s) ((x(5)./(x(2)-x(1))).*s - x(1).*x(5)./(x(2)-x(1))).*(heaviside(s-x(1)) - heaviside(s-x(2))) +...
     x(5).*(heaviside(s-x(2))-heaviside(s-x(3))) + ...
((x(5)./(x(4)-x(3))).*-s + ( (x(3).*x(5))./(x(4) - x(3)) + x(5))).*(heaviside(s-x(3)) - heaviside(s-x(4)));

x0 = [0.9 2.9 4.89 7.85 11.50];
% Find the "minimized error".
x = lsqcurvefit(fun,x0,s,y)
%x = lsqnonlin(fun,x0,s,y)
times = linspace(s(1),s(end));
hold on
plot(s,y,'ko',times,fun(x,times),'b-')
legend('Data','Fitted Response')
title('Data and Fitted Curve')
%--------------------------------------------------------
s =[1 2 3 5 6 7 8 12];
y=[0 2 5.4 4.8 5.2 5 5.6 0];
fun = @(x,s) ((x(4)./(x(2)-x(1))).*s - x(1).*x(4)./(x(2)-x(1))).*(heaviside(s-x(1)) - heaviside(s-x(2))) +...
     x(4).*(heaviside(s-x(2))-heaviside(s-x(3)));
 
 x0 = [0.9 2.9 4.89 7.85 11.50];
% Find the "minimized error".
x = lsqcurvefit(fun,x0,s,y)
%x = lsqnonlin(fun,x0,s,y)
times = linspace(s(1),s(end));
figure; hold on
plot(s,y,'ko',times,fun(x,times),'b-')
legend('Data','Fitted Response')
title('Data and Fitted Curve')