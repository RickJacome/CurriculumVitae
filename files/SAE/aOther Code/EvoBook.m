clear all; clc; close all
syms x t; m = 20;
f = x^2/2; x1 = -2; x2 = 2; % enter your function
fx = diff(f, x);
N = [x, f] + t*[-fx, 1]/sqrt(1 + fx^2);
hold on; h = ezplot(f, [x1, x2]); set(h, 'Color', 'r', 'LineWidth', 3);
m = 20; 
for i = 0 : m
X = x1 + i*(x2 - x1)/m;
p = subs(f + fx*(t - x), x, X);
ezplot(p, [x1, x2]);
end % Figure 6.2(a), tangent lines
hold on; axis equal; h = ezplot(f, [x1, x2]); set(h, 'Color', 'r');
for i = 0 : m
Ni = subs(N, x, x1 + i*(x2 - x1)/m);
ezplot(Ni(1), Ni(2), [0, 1]);
end