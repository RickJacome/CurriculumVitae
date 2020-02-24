clc; clear all; close all
Thrs = 0.1; WdwSize = 100;
% ---------------------------------------
% Split Sand Testing SSA et SST
load('ApproxCoif2L6CompleteSignalSSA.mat');
load('SST.mat'); load('SSA.mat')
a = SplitSandAccel;
t = SplitSandTime;  sig = DecomCoif2L6CompSSA;
CoifPlotter(t,sig);
FilterSwitch(Thrs,WdwSize,sig,t)
[v,d,n] = DiscInteg(t,a*9.81);
figure; plot(t,v); grid on;
xlabel('Time (sec)'); ylabel('Velocity m/s');
figure; plot(t,d); grid on;
xlabel('Time (sec)'); ylabel('Distance m')
% ---------------------------------------