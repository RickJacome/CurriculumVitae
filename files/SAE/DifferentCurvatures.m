clc; clear all; close all; format compact
%--------------------------------------------------------
% % Zeroth Case, No Curvature  y = 0
% s =[1 2 3 5 6 7 8 12];
% y =[0 0 0 0 0 0 0 0]; 
% fun = @(x,s)  x(2)./(1 + (x(1).^2)).^(3/2) - y;
% x0 = [1 1];
% % The expected results would be 0 for second derivative (no inflection)
% % and zero for first derivative (since, f(x) should be constant)
% fprintf('No Curvature -----------------------------------')
% x = lsqcurvefit(fun,x0,s,y)
% x_nonlin = lsqnonlin(fun,x0)
% 
% fun = @(x,s)  (x(1).*x(2) - x(3).*x(4))./(x(1).^2 + (x(3).^2)).^(3/2) - y;
% x0 = [0.1 0.1 0.1 0.1];
% x = lsqcurvefit(fun,x0,s,y)
% x_nonlin = lsqnonlin(fun,x0)
% % The fact that this model converges at any initial condition 
% % (with exactly the same starting point) means that when curvature is zero
% % the values taken by x(1)..x(4) can be ANYTHING as long as they cancel
% % out.
% % 
%--------------------------------------------------------
% Ramping up Case, Curvature is linear
s =[1 2 3 5 6 7 8 12];
y = s.*2 + 1; 
fun = @(x,s)  x(2)./(1 + (x(1).^2)).^(3/2) - y;
x0 = [ 1 1];
fprintf('Linear Curvature -----------------------------------')
x = lsqcurvefit(fun,x0,s,y)
x_nonlin = lsqnonlin(fun,x0)
fun = @(x,s)  (x(1).*x(2) - x(3).*x(4))./(x(1).^2 + (x(3).^2)).^(3/2) - y;
x0 = [1 1 1 1];
x = lsqcurvefit(fun,x0,s,y)
x_nonlin  = lsqnonlin(fun,x0)


% %--------------------------------------------------------
% % Constant Radius Case, Curvature is Constant
% s = [1 2 3 5 6 7 8 12];
% y =  ones(numel(s),1); 
% fun = @(x,s)  x(2)./(1 + (x(1).^2)).^(3/2) - y;
% x0 = [1 1];
% % The expected results would be 0 for second derivative (no inflection)
% % and zero for first derivative (since, f(x) should be constant)
% fprintf('Constant Curvature')
% x = lsqcurvefit(fun,x0,s,y)