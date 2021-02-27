% AASHTO Data Plots


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

legend('\mu_1 = 0.1','\mu_2 = 0.3',...
    '\mu_3 = 0.6','\mu_4 = 0.8','location','bestoutside')
xlim([0 550]);
ylim([25 40]); grid on;

xlabel('Segment Length (m)');
ylabel('Optimized Speed (m/s)');


load('OpVeDMu8E4.mat'); OpVeDMu8E4 = Op(:,2);
load('OpVeDMu6E4.mat'); OpVeDMu6E4 = Op(:,2);
load('OpVeDMu3E4.mat'); OpVeDMu3E4 = Op(:,2);
load('OpVeDMu1E4.mat'); OpVeDMu1E4 = Op(:,2);
figure
s = linspace(0,632,numel(OpMu8E4));
plot(s, OpVeDMu1E4,'linewidth',2);  hold on;
plot(s, OpVeDMu3E4,'linewidth',2);
plot(s, OpVeDMu6E4,'linewidth',2); 
plot(s, OpVeDMu8E4,'--','linewidth',2);

legend('\mu_1 = 0.1','\mu_2 = 0.3',...
    '\mu_3 = 0.6','\mu_4 = 0.8','location','bestoutside')
xlim([0 550]);
ylim([23 40]); grid on;

xlabel('Segment Length (m)');
ylabel('Optimized Speed (m/s)');