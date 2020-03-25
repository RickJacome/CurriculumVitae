clc; clear all; close all
Thrs = 0.1; WdwSize = 100;
% ---------------------------------------
% Split Gravel Testing SGA et SGT
load('matlabData\ApproxCoif2L6CompleteSignal.mat'); 
load('matlabData\SGT.mat'); load('matlabData\SGA.mat')
a = SpliGravelAccel;
t = SplitGravelTime; sig = DecomCoif2L6Complete;
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
% Take average of 1+.55
% Select Appropiate Ranges for Braking Incident
% First Event
idx1 = find(t ==39); idx2 = find(t ==47);
% Second Event
idx3 = find(t ==176); idx4 = find(t ==183);
% The following inputs, the Range of Braking Incident
% The Integrated Velocity, and the FricCoeff from Filter Switch
[FGmu1,FGmu2] = FrictionEst(FricCoeff,v,idx1,idx2,idx3,idx4)
LitValue = 0.70;
Relative_Error1 = abs((FGmu1 - LitValue))/LitValue*100
Relative_Error2 = abs((FGmu2 - LitValue))/LitValue*100