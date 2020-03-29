%%% Gradient of Simple Case (only two sections of trapezoid) 
% independent of x4
syms x1 x2 x3 x5 s

eq1 = (x5/(x2-x1))*s - x1*x5/(x2-x1);
f1 = eq1*(heaviside(s-x1) - heaviside(s-x2));
f2 = x5*(heaviside(s-x2)-heaviside(s-x3));

f = f1 + f2;
gradient(f,[x1 x2 x3 x5])
%%% Gradient of Complete Trapezoid
syms x1 x2 x3 x4 x5 s

eq1 = (x5/(x2-x1))*s - x1*x5/(x2-x1);
f1 = eq1*(heaviside(s-x1) - heaviside(s-x2));
f2 = x5*(heaviside(s-x2)-heaviside(s-x3));

eq2 = (x5/(x4-x3))*-s + ( (x3*x5)/(x4-x3) + x5);
f3 = eq2*(heaviside(s-x3) - heaviside(s-x4));

f = f1 + f2 + f3;
gradient(f,[x1 x2 x3 x4 x5])
