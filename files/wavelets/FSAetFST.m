clc; clear all; close all
Thrs = 0.1; WdwSize = 100;
% ---------------------------------------
% Full Sand Testing FSA et FST
load('ApproxCoif2L6CompleteSignalFSA.mat');
load('FST.mat'); load('FSA.mat')
t = FullSandTime;  sig = DecomCoif2L6CompFSA;
a  = FullSandAccel; 
CoifPlotter(t,sig);
[FricCoeff] = FilterSwitch(Thrs,WdwSize,sig,t);
% ---------------------------------------
[v,d,n] = DiscIntegSims(t,a*9.81);
figure; plot(t,v); grid on;
xlabel('Time (sec)'); ylabel('Velocity m/s');
figure; plot(t,d); grid on;
xlabel('Time (sec)'); ylabel('Distance m')
% ---------------------------------------
% From Literature, 
% Sand Coeff Friction Sliding Value = 0.55
% Select Appropiate Ranges for Braking Incident
% First Event
idx1 = find(t ==35); idx2 = find(t ==45);
% Second Event
idx3 = find(t ==116); idx4 = find(t ==123);
% The following inputs, the Range of Braking Incident
% The Integrated Velocity, and the FricCoeff from Filter Switch
[FGmu1,FGmu2] = FrictionEst(FricCoeff,v,idx1,idx2,idx3,idx4)
LitValue = 0.55;
Relative_Error1 = abs((FGmu1 - LitValue))/LitValue*100
Relative_Error2 = abs((FGmu2 - LitValue))/LitValue*100