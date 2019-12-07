clc; clear all; close all
x = [zeros(500,1); ones(500,1)];
CWTcoeffs = cwt(x,1:64,'haar','plot'); colormap jet;
% plot a few scales for visualization
subplot(311);
plot(CWTcoeffs(5,:)); title('Scale 5');
subplot(312);
plot(CWTcoeffs(10,:)); title('Scale 10');
subplot(313);
plot(CWTcoeffs(50,:)); title('Scale 50');