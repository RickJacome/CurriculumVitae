close all; clc; clear all
load('matlabData\SGT.mat'); load('matlabData\SGA.mat')
SGA = SpliGravelAccel; SGT = SplitGravelTime;
ts = abs(SGT(1) - SGT(2));
fr = 1/ts;
plot(SGT,SGA); xlabel('sec'); ylabel('gs'); 
grid on; title('Data')
% The CWT is obtained using the analytic 
%  Morse wavelet with the symmetry parameter
% (gamma) equal to 3 and the time-bandwidth 
% product equal to 60
figure; [wt,f,coi] = cwt(SGA,fr);
cwt(SGA,fr)
figure; [wt,periods,coi] = cwt(SGA,seconds(ts));
cwt(SGA,seconds(ts))
figure; cwt(SGA,'morse');
colormap jet; colorbar;
figure; cwt(SGA,1:128,'haar','plot');
colormap jet; colorbar;