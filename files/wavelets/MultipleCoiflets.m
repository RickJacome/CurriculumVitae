close all; clear all% Multiple Analysis of Coefficients of Friction with Coiflet 2 
% First Obtaining a wavelet decomposition from the 
% Wavelet Analyzer Toolbox using coiflet 2 at level 6. 
% Then, just run Functions to see results.
Thrs = 0.1; WdwSize = 100;
% ---------------------------------------
% Split Gravel Testing SGA et SGT
load('ApproxCoif2L6CompleteSignal.mat'); 
load('SGT.mat'); load('SGA.mat')
a = SpliGravelAccel;
t = SplitGravelTime; sig = DecomCoif2L6Complete;
CoifPlotter(t,sig);
FilterSwitch(Thrs,WdwSize,sig,t)
[v,d,n] = DiscInteg(t,a*9.81);
figure; plot(t,v); xlabel('Time (sec)'); ylabel('Velocity m/s')
figure; plot(t,d); xlabel('Time (sec)'); ylabel('Distance m')
% ---------------------------------------
% Split Sand Testing SSA et SST
load('ApproxCoif2L6CompleteSignalSSA.mat');
load('SST.mat'); load('SSA.mat')
t = SplitSandTime;  sig = DecomCoif2L6CompSSA;
CoifPlotter(t,sig); 
FilterSwitch(Thrs,WdwSize,sig,t)
% ---------------------------------------
% Baseline Full Concrete Testing FCA et FCT
load('ApproxCoif2L6CompleteSignalFCA.mat');
load('FCT.mat');
t = FullConcreteTime;  sig = DecomCoif2L6CompFCA;
CoifPlotter(t,sig);
FilterSwitch(Thrs,WdwSize,sig,t)
% ---------------------------------------
% Full Gravel Testing FGA et FGT
load('ApproxCoif2L6CompleteSignalFGA.mat');
load('FGT.mat');
t = FullGravelTime;  sig = DecomCoif2L6CompFGA;
CoifPlotter(t,sig);
FilterSwitch(Thrs,WdwSize,sig,t)
% ---------------------------------------
% Full Sand Testing FSA et FST
load('ApproxCoif2L6CompleteSignalFSA.mat');
load('FST.mat');
t = FullSandTime;  sig = DecomCoif2L6CompFSA;
CoifPlotter(t,sig);
FilterSwitch(Thrs,WdwSize,sig,t)