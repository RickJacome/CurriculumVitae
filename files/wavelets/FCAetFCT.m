clc; clear all; close all
Thrs = 0.1; WdwSize = 100;
% ---------------------------------------
% Baseline Full Concrete Testing FCA et FCT
load('ApproxCoif2L6CompleteSignalFCA.mat');
load('FCT.mat'); load('FCA.mat')
t = FullConcreteTime;  sig = DecomCoif2L6CompFCA;
a = FullConcreteAccel; 
CoifPlotter(t,sig); 
FilterSwitch(Thrs,WdwSize,sig,t)
[v,d,n] = DiscInteg(t,a*9.81);
figure; plot(t,v); grid on;
xlabel('Time (sec)'); ylabel('Velocity m/s');
figure; plot(t,d); grid on;
xlabel('Time (sec)'); ylabel('Distance m')
% ---------------------------------------