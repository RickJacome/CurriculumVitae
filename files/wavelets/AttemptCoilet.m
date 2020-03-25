close all
% load('ApproxCoif2L6.mat'); 
load('matlabData\ApproxCoif2L6COmpleteSignal.mat')
load('matlabData\SGT.mat');

Time = SplitGravelTime;
figure(2); subplot(211)
Signal = DecomCoif2L6Complete(1,:)*-1;
Approx = DecomCoif2L6Complete(6,:)*-1;
plot(Time,Signal); hold on
xlabel('Time (sec)'); ylabel('Acceleration (Gs)'); grid on
title('Raw Longitudinal Vehicle Acceleration')
%xlim([15 100])
subplot(212)
tfilt = Time;
signalfilt = Approx;
plot(tfilt,signalfilt)
xlabel('Time (sec)'); ylabel('Acceleration (Gs)'); grid on;
title('Filtered Longitudinal Vehicle Acceleration')
%ylim([-.5 1]); xlim([15 100])




