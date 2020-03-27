% Trapezoid
close all
x1 = 0; x2 = 2;
x3 = 6; x4 = 9;
f1 = (x1 + x2*s)*(heaviside(s-x1) - heaviside(s-x2));
eq1 = (x1 + x2*x2);
f2 = eq1*(heaviside(s - x2)-heaviside(s-x3));

f3 = (x2*x3 - (eq1-x1)/(x4-x3)*s)*(heaviside(s-x3) - heaviside(s-x4));

fplot(f1 + f2 + f3 ,[0 10])
xlim([0 10])
