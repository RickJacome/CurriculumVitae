% LSQCURVEFIT Nonlinear Function
% Attempt Seems good
clear all; close all; clc
s =[1 3 5 7 8 12];
y=[0 5.4 4.8 5 5.6 0];

fun = @(x,s) ((x(5)./(x(2)-x(1))).*s - x(1).*x(5)./(x(2)-x(1))).*(heaviside(s-x(1)) - heaviside(s-x(2))) +...
     x(5).*(heaviside(s-x(2))-heaviside(s-x(3))) + ...
((x(5)./(x(4)-x(3))).*-s + ( (x(3).*x(5))./(x(4) - x(3)) + x(5))).*(heaviside(s-x(3)) - heaviside(s-x(4)));


x0 = [0.9 2.9 4.89 7.85 11.56];
% Find the "minimized error".
x = lsqcurvefit(fun,x0,s,y)
%x = lsqnonlin(fun,x0,s,y)


times = linspace(s(1),s(end));
plot(s,y,'ko',times,fun(x,times),'b-')
legend('Data','Fitted exponential')
title('Data and Fitted Curve')