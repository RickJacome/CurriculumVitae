clc; clear all; close all
load('ApproxCoif2L6CompleteSignalFCA.mat');
load('FCT.mat'); load('FCA.mat')
FCt = FullConcreteTime;  FCsigcoif = DecomCoif2L6CompFCA(6,:);
FCsignal = FullConcreteAccel; 
idx1 = find(FCt ==0); idx2 = find(FCt ==60);
idx3 = find(FCt ==130); idx4 = find(FCt ==180);
DriftingRemove(FCt,FCsigcoif,FCsignal,idx1,idx2,idx3,idx4);
%---------------------------------------
load('ApproxCoif2L6CompleteSignalFGA.mat');
load('FGT.mat'); load('FGA.mat')
FGt = FullGravelTime;  FGsigcoif = DecomCoif2L6CompFGA(6,:);
FGsignal  = FullGravelAccel; 
idx1 = find(FGt ==30); idx2 = find(FGt == 90);
idx3 = find(FGt ==130); idx4 = find(FGt ==180);
DriftingRemove(FGt,FGsigcoif,FGsignal,idx1,idx2,idx3,idx4);
% %---------------------------------------
load('ApproxCoif2L6CompleteSignalFSA.mat');
load('FST.mat'); load('FSA.mat')
FSt = FullSandTime;  FSsigcoif = DecomCoif2L6CompFSA(6,:);
FSsignal  = FullSandAccel; 
idx1 = find(FSt == 0); idx2 = find(FSt == 60);
idx3 = find(FSt ==90); idx4 = find(FSt ==140);
DriftingRemove(FSt,FSsigcoif,FSsignal,idx1,idx2,idx3,idx4);
% %---------------------------------------
load('ApproxCoif2L6CompleteSignal.mat'); 
load('SGT.mat'); load('SGA.mat')
SGt = SplitGravelTime; SGsigcoif = DecomCoif2L6Complete(6,:);
SGsignal = SpliGravelAccel;
idx1 = find(SGt == 10); idx2 = find(SGt == 60);
idx3 = find(SGt ==140); idx4 = find(SGt ==190);
DriftingRemove(SGt,SGsigcoif,SGsignal,idx1,idx2,idx3,idx4);
% %---------------------------------------
load('ApproxCoif2L6CompleteSignalSSA.mat');
load('SST.mat'); load('SSA.mat')
SSt = SplitSandTime;  SSsigcoif = DecomCoif2L6CompSSA(6,:);
SSsignal = SplitSandAccel;
idx1 = find(SSt == 10); idx2 = find(SSt == 60);
idx3 = find(SSt ==90); idx4 = find(SSt ==140);
DriftingRemove(SSt,SSsigcoif,SSsignal,idx1,idx2,idx3,idx4);
