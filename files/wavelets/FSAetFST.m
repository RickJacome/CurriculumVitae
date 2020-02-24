clc; clear all; close all
Thrs = 0.1; WdwSize = 100;
% ---------------------------------------
% Full Sand Testing FSA et FST
load('ApproxCoif2L6CompleteSignalFSA.mat');
load('FST.mat'); load('FSA.mat')
t = FullSandTime;  sig = DecomCoif2L6CompFSA;
a  = FullSandAccel; 
CoifPlotter(t,sig);
FilterSwitch(Thrs,WdwSize,sig,t)
[v,d,n] = DiscInteg(t,a*9.81);
figure; plot(t,v); grid on;
xlabel('Time (sec)'); ylabel('Velocity m/s');
figure; plot(t,d); grid on;
xlabel('Time (sec)'); ylabel('Distance m')
% ---------------------------------------