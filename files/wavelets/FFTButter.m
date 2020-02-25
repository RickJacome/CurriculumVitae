function [Output] = FFTButter(t,signal,fc)

del = t(2)-t(1);
fs = 1/del; afft = fft(signal);
N = numel(t)-1; Nyq = (1/(2*del));
freq = linspace(0,Nyq,N/2);
figure; plot(freq,abs(del*afft(1:(N/2))))
xlabel('Frequency (Hz)'); ylabel('Amplitude')
title('FFT to Select Cutoff Frequency')
% Use FFT to select a Cutoff Freq
[B,A] = butter(1,fc/(fs/2),'low');
Output = filter(B,A,signal);
figure;hold on; plot(t,signal);
plot(t,Output,'r','Linewidth',2)
xlabel('Time (sec)'); ylabel('Acceleration Gs');
title('Pure and Butterworth Filtered Signal')
end