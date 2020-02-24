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
xq = t(1):.01:t(end);
yy = spline(t,a,xq);
plot(xq,yy); hold on;
[v,d,n] = DiscIntegSims(xq,yy*9.81);

figure; plot(xq,v); grid on;
xlabel('Time (sec)'); ylabel('Velocity m/s');
figure; plot(xq,d); grid on;
xlabel('Time (sec)'); ylabel('Distance m')
% ---------------------------------------