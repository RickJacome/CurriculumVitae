clear all; close all; clc;
N =4;
n = -(N-1)/2:(N-1)/2;

alpha = 0.1; % This makes the function thinner
w = gausswin(N,alpha);
stdev = (N-1)/(2*alpha);
y = exp(-1/2*(n/stdev).^2);
plot(n,w); hold on
plot(n,y,'o'); hold on
xlabel('Samples'); title('Gaussian Window, N = 64')

x = -100:0.1:100;
eps = 1;
A = 10;
y = A*1/(2*sqrt(pi*eps))*exp(-x.^2/(4*eps));
figure; plot(x,y)