clc; clear all; close all
% Same as CurveFitlsq but uses a higher amount of data points
% Behavior is good because even though there should be 
% a "drop" the function compensates and does not generate a drop
% The only problem is that the function only behaves properly when the data
% starts at 0 for y-axis
s = 1:.01:30; n = numel(s)-1;
y1 = (2.*s(1:n/2) - 3)*1e-3;
y2 = 26*ones(1,n/2)*1e-3;
y1o = awgn(y1,25,'measured');
y2o = awgn(y2,25,'measured');
y = [y1o y2o]; 
x0 = [1 2 3 4 5];
% Find the "minimized error".
fun1 = @(x,s) ((x(5)./(x(2)-x(1))).*s - x(1).*x(5)./(x(2)-x(1))).*(heaviside(s-x(1)) - heaviside(s-x(2))) +...
     x(5).*(heaviside(s-x(2))-heaviside(s-x(3))) + ...
((x(5)./(x(4)-x(3))).*-s + ( (x(3).*x(5))./(x(4) - x(3)) + x(5))).*(heaviside(s-x(3)) - heaviside(s-x(4)));

x = lsqcurvefit(fun1,x0,s(1:end-1),y)
times = linspace(s(1),s(end-1));
hold on; plot(s(1:end-1),y,'bo')
plot(times,fun1(x,times),'k-','linewidth',2)
xlim([times(1), times(end)+5])
legend('Data','Fitted Response','location','best'); 
title('Optimization of Curvature Model \kappa_1'); grid on
xlabel('Segment of Length s'); ylabel('Curvature \kappa');
 

fun2 = @(x,s) ((x(5)./(x(2)-x(1))).*(s - x(1))).*(heaviside(s-x(1)) - heaviside(s-x(2))) +...
     x(5).*(heaviside(s-x(2))-heaviside(s-x(3))) + ...
( ( x(5)./(x(4)-x(3))).*(-s+x(3))+ x(5) ).*(heaviside(s-x(3)) - heaviside(s-x(4))); 


x = lsqcurvefit(fun1,x0,s(1:end-1),y)
times = linspace(s(1),s(end-1));
figure
hold on; plot(s(1:end-1),y,'bo')
plot(times,fun2(x,times),'k-','linewidth',2)
legend('Data','Fitted Response','location','best'); 
title('Optimization of Curvature Model \kappa_1'); grid on
xlabel('Segment of Length s'); ylabel('Curvature \kappa');
xlim([times(1), times(end)+5])

