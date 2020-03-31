clear all; close all; clc
N = 120; 
% This n creates the "x vector"
n = -(N-1)/2:(N-1)/2;
for alpha = 2:2:16
%alpha = 4; % This makes the function thinner
w = gausswin(N,alpha);
stdev = (N-1)/(2*alpha);
y = exp(-1/2*(n/stdev).^2);

plot(n,w); hold on
plot(n,y,'.'); hold on
xlabel('Samples'); title('Gaussian Window, N = 64')
end
figure
for N = 10:10:120
n = -(N-1)/2:(N-1)/2;
alpha = 0.1; % This makes the function thinner
w = gausswin(N,alpha);
stdev = (N-1)/(2*alpha);
y = exp(-1/2*(n/stdev).^2);

plot(n,w); hold on
plot(n,y,'.'); hold on
xlabel('Samples'); title('Gaussian Window, N = 64')
end


%n = -(N-1)/2:(N-1)/2;
n = -0.01:0.0001:0.01;
N = numel(n);
alpha = 0.1; % This makes the function thinner
w = gausswin(N,alpha);
stdev = (N-1)/(2*alpha);
y = exp(-1/2*(n/stdev).^2);
figure; hold on
plot(n,w);
plot(n,y,'.'); 
xlabel('Samples'); title('Gaussian Window, N = 64')





