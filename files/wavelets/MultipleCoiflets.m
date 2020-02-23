close all; clear all
% Multiple Analysis of Coefficients of Friction with Coiflet 2 
% First Obtaining a wavelet decomposition from the 
% Wavelet Analyzer Toolbox using coiflet 2 at level 6. 
% Then, just run Functions to see results.
load('ApproxCoif2L6CompleteSignal.mat'); 
load('SGT.mat');
t = SplitGravelTime;
sig = DecomCoif2L6Complete;
CoifPlotter(t,sig);
Thrs = 0.1; WdwSize = 100;
FilterSwitch(Thrs,WdwSize,sig,t)


