clc; clear all; close all
Thrs = 0.1; WdwSize = 100;
% ---------------------------------------
% Full Gravel Testing FGA et FGT
load('ApproxCoif2L6CompleteSignalFGA.mat');
load('FGT.mat'); load('FGA.mat')
t = FullGravelTime;  sig = DecomCoif2L6CompFGA;
a  = FullGravelAccel; 
CoifPlotter(t,sig); 
FilterSwitch(Thrs,WdwSize,sig,t)
[v,d,n] = DiscInteg(t,a*9.81);
figure; plot(t,v); grid on;
xlabel('Time (sec)'); ylabel('Velocity m/s');
figure; plot(t,d); grid on;
xlabel('Time (sec)'); ylabel('Distance m')
% ---------------------------------------