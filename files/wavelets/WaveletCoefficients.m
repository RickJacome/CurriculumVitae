clc; clear all; close all
load('SplitGravelAccel.mat'); load('SplitGravelTime.mat')
%Sampling Time
ts = abs(SplitGravelTime(1)-SplitGravelTime(2));
freq = (1/ts);
%%
% Plot data
plot(SplitGravelTime,SpliGravelAccel);
xlabel('sec'); ylabel('gs'); grid on
%%
% Obtain the CWT, frequencies, and cone of influence.
[wt,f,coi] = cwt(SpliGravelAccel,100);
% Plot the data, including the cone of influence.
figure
cwt(SpliGravelAccel,100);
%%
% Obtain the CWT, time periods, and cone of influence by specifying a
% time duration instead of a sampling frequency.
[wt,periods,coi] = cwt(SpliGravelAccel,seconds(ts));
%%
% View the same data by specifying a sampling period input instead of a
% frequency. 
figure
cwt(SpliGravelAccel,seconds(ts));