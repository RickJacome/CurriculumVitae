clc; clear all; close all
load('K.mat')
K = K_vector;
 g = 9.81;
 
 
% v = linspace(30,38, numel(K));
% [V,Ka] = meshgrid(v,K);
% a = V.^2.*Ka/g;
% 
% surf(V,Ka,a)
% colorbar
% view(90,90)

e = 4;
mu = linspace(0.1,0.9, numel(K));
[MU,Ka] = meshgrid(mu,K);

v = sqrt( ((MU - 0.01*e)./(1 - 0.01.*MU.*e)).*g./Ka);

surf(MU,Ka,v); xlabel('mu'); ylabel('kappa'); zlabel('v')
colorbar; view(90,90)

figure
surf(MU,Ka,v); xlabel('mu'); ylabel('kappa'); zlabel('v')
colorbar; view(0,90)

figure
surf(MU,Ka,v); xlabel('mu'); ylabel('kappa'); zlabel('v')
colorbar; view(0,0)


