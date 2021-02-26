clc; clear all; close all
load('OpMu8E4.mat'); OpMu8E4 = Op;
load('OpMu6E4.mat'); OpMu6E4 = Op;
load('OpMu3E4.mat'); OpMu3E4 = Op;
load('OpMu1E4.mat'); OpMu1E4 = Op;

s = linspace(0,632,numel(OpMu8E4));
plot(s, OpMu1E4,'linewidth',2);  hold on;
plot(s, OpMu3E4,'linewidth',2);
plot(s, OpMu6E4,'linewidth',2); 
plot(s, OpMu8E4,'--','linewidth',2);

legend('\mu = 0.1','\mu = 0.3','\mu = 0.6','\mu = 0.8')
xlim([0 550]);
ylim([25 40]); grid on;

xlabel('Segment Length (m)');
ylabel('Optimized Speed (m/s)');