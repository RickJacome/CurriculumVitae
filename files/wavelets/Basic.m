close all; clc; clear all
% This will represent an impulse
x = zeros(1000,1);
x(500) = 1;
%For the wavelet, pick the Haar wavelet.
[~,psi,xval] = wavefun('haar',10);
plot(xval,psi); axis([0 1 -1.5 1.5]);
title('Haar Wavelet');
%To compute the CWT using the Haar wavelet at scales 1 to 128, enter:
% CWT = Continous Wavelet Transform
CWTcoeffs = cwt(x,1:128,'haar');
% To produce a plot of the CWT coefficients,
% plot position along the x-axis, scale along the yaxis,
% and encode the magnitude, or size of the CWT coefficients 
% as color at each point in the x-y, or time-scale plane.
figure
cwt(x,1:128,'haar','plot');
colormap jet; colorbar;

figure
subplot(311)
plot(CWTcoeffs(10,:)); title('Scale 10');
subplot(312)
plot(CWTcoeffs(50,:)); title('Scale 50');
subplot(313)
plot(CWTcoeffs(90,:)); title('Scale 90');