%%Coilet Analysis 
clc; close all; clear all
wname = 'coif2';
f = coifwavf(wname); 
figure(1); plot(f); grid on;
title('Coiflet 2 Scaling Coefficients')
ylabel('Amplitude'); xlabel('Section Series')

figure
plot(coifwavf('coif1'))
grid on; hold on; plot(coifwavf('coif2'))
plot(coifwavf('coif3')); plot(coifwavf('coif4'))
plot(coifwavf('coif5')); xlim([0 20])
title('Coiflet 2 Scaling Coefficients')
ylabel('Amplitude'); xlabel('Section Series')

load('ApproxCoif2L6.mat'); load('SGT.mat');
Time = SplitGravelTime;
figure; subplot(211)
Signal = ApproxCoif2L6(1,:)*-1; Approx = ApproxCoif2L6(6,:)*-1;
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

 [C,L] = wavedec(Signal,6,'coif2')
approx = appcoef(C,L,'coif2');
[cd1,cd2,cd3,cd4,cd5,cd6] = detcoef(C,L,[1 2 3 4 5 6]);

subplot(7,1,1)
plot(approx)
title('Approximation Coefficients')
subplot(7,1,2)
plot(cd6)
title('Level 6 Detail Coefficients')
subplot(7,1,3)
plot(cd5)
title('Level 5 Detail Coefficients')
subplot(7,1,4)
plot(cd4)
title('Level 4 Detail Coefficients')
subplot(7,1,5)
plot(cd3)
title('Level 3 Detail Coefficients')
subplot(7,1,6)
plot(cd2)
title('Level 2 Detail Coefficients')
subplot(7,1,7)
plot(cd1)
title('Level 1 Detail Coefficients')


