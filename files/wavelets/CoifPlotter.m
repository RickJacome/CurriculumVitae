function [] = CoifPlotter(t,sig)

figure; subplot(211)
Signal = sig(1,:)*-1;
Approx = sig(6,:)*-1;

plot(t,Signal); hold on
xlabel('Time (sec)'); ylabel('Acceleration (Gs)'); grid on
title('Raw Longitudinal Vehicle Acceleration')
subplot(212)
plot(t,Approx)
xlabel('Time (sec)'); ylabel('Acceleration (Gs)'); grid on;
title('Coiflet Filtered Longitudinal Vehicle Acceleration')
figure
plot(t,Signal); hold on; plot(t,Approx,'r','Linewidth',2)
xlabel('Time (sec)'); ylabel('Acceleration (Gs)'); grid on;
title('Pure Signal and Wavelet Transform Signal')
end


