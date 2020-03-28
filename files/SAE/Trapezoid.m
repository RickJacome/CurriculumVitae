% Trapezoid
close all; clear all; clc
x1 = 2; x2 = 6;
x3 = 12; x4 = 21;
x5 = 7;
syms s
theta = atand((x2-x1)/x5);
eq1 = (x5/(x2-x1))*s - x1/tand(theta);
f1 = eq1*(heaviside(s-x1) - heaviside(s-x2));

f2 = x5*(heaviside(s-x2)-heaviside(s-x3));

alpha = atand((x4-x3)/x5);
eq2 = (x5/(x4-x3))*-s + ( (x3)/tand(alpha) + x5);
f3 = eq2*(heaviside(s-x3) - heaviside(s-x4));

fplot(f1 + f2 + f3 ,[0 x4+2])
ylim([0 x5+2])

