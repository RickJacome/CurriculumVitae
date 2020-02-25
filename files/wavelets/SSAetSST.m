clc; clear all; close all
Thrs = 0.1; WdwSize = 100;
% ---------------------------------------
% Split Sand Testing SSA et SST
load('ApproxCoif2L6CompleteSignalSSA.mat');
load('SST.mat'); load('SSA.mat')
a = SplitSandAccel;
t = SplitSandTime;  sig = DecomCoif2L6CompSSA;
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
% Take average of 1+.45
% Select Appropiate Ranges for Braking Incident
% First Event
idx1 = find(t ==36); idx2 = find(t ==42);
% Second Event
idx3 = find(t ==114); idx4 = find(t ==122);
% The following inputs, the Range of Braking Incident
% The Integrated Velocity, and the FricCoeff from Filter Switch
[FGmu1,FGmu2] = FrictionEst(FricCoeff,v,idx1,idx2,idx3,idx4)
LitValue = 0.605;
Relative_Error1 = abs((FGmu1 - LitValue))/LitValue*100
Relative_Error2 = abs((FGmu2 - LitValue))/LitValue*100