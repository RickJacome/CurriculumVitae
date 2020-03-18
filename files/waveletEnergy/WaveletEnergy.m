%%Coilet Analysis 
clc; close all; clear all
load('FCA.mat')
Signal = FullConcreteAccel;
%Energy Shannon Ratio for level 6;
[R] = EnergyShanonRatio(Signal,'coif2')
[R] = EnergyShanonRatio(Signal,'coif1')
[R] = EnergyShanonRatio(Signal,'haar')
[R] = EnergyShanonRatio(Signal,'db1')
[R] = EnergyShanonRatio(Signal,'dmey')