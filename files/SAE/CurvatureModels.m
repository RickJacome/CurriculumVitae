clear all; close all; clc
s =[1 2 3 5 6 7 8 12];
y=[0 2 5.4 4.8 5.2 5 5.6 0];
fun = @(x,s) x(1)/(1+ x(2)^2)^(3/2) -s
x0 = [0.9 2.9];
% Find the "minimized error"
x = lsqcurvefit(fun,x0,s,y)
%x = lsqnonlin(fun,x0,s,y)
times = linspace(s(1),s(end));
hold on; plot(s,y,'ko',times,fun(x,times),'b-')
title('Data and Fitted Curve')




fun = @(x,s) (x(1)*x(2) - x(3)*x(4))...
    /(x(1)^2 + x(3)^2)^(3/2) -s
x0 = [0.9 2.9 3.2 .5];
% Find the "minimized error"
x = lsqcurvefit(fun,x0,s,y)
times = linspace(s(1),s(end));
figure; hold on;
plot(s,y,'ko',times,fun(x,times),'b-')
title('Data and Fitted Curve')



