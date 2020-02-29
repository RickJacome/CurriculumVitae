clc; clear all; close all; format compact
Thrs = 0.1; WdwSize = 100;
% ---------------------------------------
% Baseline Full Concrete Testing FCA et FCT
load('ApproxCoif2L6CompleteSignalFCA.mat');
load('FCT.mat'); load('FCA.mat')
t = FullConcreteTime;  sig = DecomCoif2L6CompFCA;
a = FullConcreteAccel; 
figure; plot(t,a*-1); xlabel('Time (sec)'); ylabel('Acceleration (Gs)')
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
% Concrete Coeff Friction Sliding Value =~ 1.00
% Select Appropiate Ranges for Braking Incident
% First Event
idx1 = find(t ==38); idx2 = find(t ==42);
% Second Event
idx3 = find(t ==157); idx4 = find(t ==163);
% The following inputs, the Range of Braking Incident
% The Integrated Velocity, and the FricCoeff from Filter Switch
[FGmu1,FGmu2] = FrictionEst(FricCoeff,v,idx1,idx2,idx3,idx4)
LitValue = 1;
Relative_Error1 = abs((FGmu1 - LitValue))/LitValue*100
Relative_Error2 = abs((FGmu2 - LitValue))/LitValue*100