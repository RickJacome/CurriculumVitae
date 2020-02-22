%%Coilet Analysis 
clc; close all; clear all
wname = 'coif2';
f = coifwavf(wname); figure(1)
plot(f); grid on
title('Coiflet 2 Scaling Coefficients')
ylabel('Amplitude'); xlabel('Section Series')

load('ApproxCoif2L6.mat'); load('SGT.mat');
Time = SplitGravelTime;
figure(2); subplot(211)
Signal = ApproxCoif2L6(1,:)*-1;
Approx = ApproxCoif2L6(6,:)*-1;
plot(Time(1:numel(Time)/2),Signal(1:numel(Signal)/2)); hold on
xlabel('Time (sec)'); ylabel('Acceleration (Gs)'); grid on
title('Raw Longitudinal Vehicle Acceleration')
xlim([15 100])

subplot(212)
tfilt = Time(1:numel(Time)/2);
signalfilt = Approx(1:numel(Signal)/2);
plot(tfilt,signalfilt)
xlabel('Time (sec)'); ylabel('Acceleration (Gs)'); grid on;
title('Filtered Longitudinal Vehicle Acceleration')
ylim([-.5 1]); xlim([15 100])


