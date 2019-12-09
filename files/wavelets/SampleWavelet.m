%% Sample Wavelets
clear all; close all; clc
[psi,xval] = wavefun('morl',10);
plot(xval,psi); title('Morlet Wavelet');
hold on;
x = -8:.01:8;
y = pi^(-1/4)*exp(-x.^2/2).*cos(5*x);
plot(x,y); grid on;
legend('MATLAB Morlet Wavelet','Analytical Wavelet')
xlim([-4 4])

figure
lb = -5; ub = 5; N = 1000;
[psi,xval] = mexihat(lb,ub,N);
plot(xval,psi); hold on
title('Mexican Hat Wavelet');
xm = -5:.01:5;
ym = pi^(-1/4)*exp(-xm.^2/2).*(1-xm.^2);
plot(xm,ym); grid on;
legend('MATLAB Mexican Hat Wavelet','Analytical Wavelet')
xlim([-5 5])

