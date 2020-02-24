clc; clear all; close all
Thrs = 0.1; WdwSize = 100;
% ---------------------------------------
% Split Gravel Testing SGA et SGT
load('ApproxCoif2L6CompleteSignal.mat'); 
load('SGT.mat'); load('SGA.mat')
a = SpliGravelAccel;
t = SplitGravelTime; sig = DecomCoif2L6Complete;
CoifPlotter(t,sig);
FilterSwitch(Thrs,WdwSize,sig,t)

figure
xq1 = t(1):.01:t(end);
yy1 = spline(t,a,xq1);
plot(xq1,yy1); hold on;
[v,d,n] = DiscInteg(xq1,yy1*9.81);

figure; plot(xq1,v); grid on;
xlabel('Time (sec)'); ylabel('Velocity m/s');
figure; plot(xq1,d); grid on;
xlabel('Time (sec)'); ylabel('Distance m')
% ---------------------------------------