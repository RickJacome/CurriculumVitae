close all; clc; clear all
% This will represent an impulse
x = zeros(1000,1);
x(500) = 1;
figure
cwt(x,1:128,'haar','plot');
colormap jet; colorbar;