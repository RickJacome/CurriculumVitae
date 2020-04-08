clear all; clc; close all
x1 = linspace(-1000,1000);
x2 = linspace(-2,2);
[X,Y] = meshgrid(x1,x2);
Z = X./(1 + (Y.^2)).^(3/2);
figure; meshc(X,Y,Z);
figure; meshc(X,Y,Z); hold on
Z2 = 1e-3*X.^2 + 1e-3*Y.^2;
meshc(X,Y,Z2); colorbar; 
xlabel('x1'); ylabel('x2')

Z1 = X./(1 + (Y.^2)).^(3/2) - 1000;
figure; meshc(X,Y,Z1); colorbar; 
xlabel('x1'); ylabel('x2')






