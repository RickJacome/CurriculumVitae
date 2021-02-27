% Google Earth Data Plots

clc; clear all; close all
load('GEOpMu8E4.mat'); GEOpMu8E4 = Op;
load('GEOpMu6E4.mat'); GEOpMu6E4 = Op;
load('GEOpMu3E4.mat'); GEOpMu3E4 = Op;
load('GEOpMu1E4.mat'); GEOpMu1E4 = Op;

s = linspace(0,2132,numel(GEOpMu8E4));
plot(s, GEOpMu1E4,'linewidth',2);  hold on;
plot(s, GEOpMu3E4,'linewidth',2);
plot(s, GEOpMu6E4,'linewidth',2); 
plot(s, GEOpMu8E4,'--','linewidth',2);

legend('\mu_1 = 0.1','\mu_2 = 0.3',...
    '\mu_3 = 0.6','\mu_4 = 0.8','location','bestoutside')
xlim([0 1900]);
ylim([33 40]); grid on;

xlabel('Segment Length (m)');
ylabel('Optimized Speed (m/s)');


load('GEOpVeDMu8E4.mat'); GEOpVeDMu8E4 = Op(:,2);
load('GEOpVeDMu6E4.mat'); GEOpVeDMu6E4 = Op(:,2);
load('GEOpVeDMu3E4.mat'); GEOpVeDMu3E4 = Op(:,2);
load('GEOpVeDMu1E4.mat'); GEOpVeDMu1E4 = Op(:,2);
figure
s = linspace(0,2132,numel(GEOpMu8E4));
plot(s, GEOpVeDMu1E4,'linewidth',2);  hold on;
plot(s, GEOpVeDMu3E4,'linewidth',2);
plot(s, GEOpVeDMu6E4,'linewidth',2); 
plot(s, GEOpVeDMu8E4,'--','linewidth',2);

legend('\mu_1 = 0.1','\mu_2 = 0.3',...
    '\mu_3 = 0.6','\mu_4 = 0.8','location','bestoutside')
xlim([0 1900]);
ylim([33 40]); grid on;

xlabel('Segment Length (m)');
ylabel('Optimized Speed (m/s)');