clear all; clc; close all
x1 = linspace(-10,10);
x2 = linspace(0,40);
L = 2; g = 9.81; e = 3; mu = .3;
U  = 2; K = 0.001;
[X1,X2] = meshgrid(x1,x2);
Z = X1 - (53.7*L+U*X2.^2)*K;

figure; meshc(X1,X2,Z); hold on

Z2 = - X2.^2*K/g + (mu + 0.01*e)/(1-0.01*mu*e);
meshc(X1,X2,Z2); colorbar; 

xlabel('x1'); ylabel('x2')
