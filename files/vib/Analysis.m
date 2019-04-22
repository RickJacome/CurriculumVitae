clear all; clc; close all; format compact
load('R1.mat'); load('R2.mat'); load('R3.mat'); load('R4.mat');
A1x = R1.AX; A1y = R1.AY; A1z = R1.AZ;
Ang1x = R1.AngleX; Ang1y = R1.AngleY; Ang1z = R1.AngleZ;

figure(1);
t = linspace(0,60,numel(A1x));
plot(t,A1x,'LineWidth',2); hold on;
t = linspace(0,60,numel(A1y));
plot(t,A1y,'LineWidth',2);
t = linspace(0,60,numel(A1z));
plot(t,A1z,'LineWidth',2);
t = linspace(0,60,numel(Ang1x));
plot(t,Ang1x,'LineWidth',2);
t = linspace(0,60,numel(Ang1y));
plot(t,Ang1y,'LineWidth',2);
t = linspace(0,60,numel(Ang1z));
plot(t,Ang1z,'LineWidth',2);
legend('A_x','A_y','A_z','\theta_x','\theta_y','\theta_z')
title('Trial 1'); xlabel('Time (sec)');
ylabel('Amplitudes')

A2x = R2.AX; A2y = R2.AY; A2z = R2.AZ;
Ang2x = R2.AngleX; Ang2y = R2.AngleY; Ang2z = R2.AngleZ;
figure(2);
t = linspace(0,60,numel(A2x));
plot(t,A2x,'LineWidth',2); hold on;
t = linspace(0,60,numel(A2y));
plot(t,A2y,'LineWidth',2);
t = linspace(0,60,numel(A2z));
plot(t,A2z,'LineWidth',2);
t = linspace(0,60,numel(Ang2x));
plot(t,Ang2x,'LineWidth',2);
t = linspace(0,60,numel(Ang2y));
plot(t,Ang2y,'LineWidth',2);
t = linspace(0,60,numel(Ang2z));
plot(t,Ang2z,'LineWidth',2);
legend('A_x','A_y','A_z','\theta_x','\theta_y','\theta_z')
title('Trial 2'); xlabel('Time (sec)');
ylabel('Amplitudes')

A3x = R3.AX; A3y = R3.AY; A3z = R3.AZ;
Ang3x = R3.AngleX; Ang3y = R3.AngleY; Ang3z = R3.AngleZ;
figure(3);
t = linspace(0,60,numel(A3x));
plot(t,A3x,'LineWidth',2); hold on;
t = linspace(0,60,numel(A3y));
plot(t,A3y,'LineWidth',2);
t = linspace(0,60,numel(A3z));
plot(t,A3z,'LineWidth',2);
t = linspace(0,60,numel(Ang3x));
plot(t,Ang3x,'LineWidth',2);
t = linspace(0,60,numel(Ang3y));
plot(t,Ang3y,'LineWidth',2);
t = linspace(0,60,numel(Ang3z));
plot(t,Ang3z,'LineWidth',2);
legend('A_x','A_y','A_z','\theta_x','\theta_y','\theta_z')
title('Trial 3'); xlabel('Time (sec)');


A4x = R4.AX; A4y = R4.AY; A4z = R4.AZ;
Ang4x = R4.AngleX; Ang4y = R3.AngleY; Ang4z = R4.AngleZ;
figure(4); 
t = linspace(0,60,numel(A4x));
plot(t,A4x,'LineWidth',2); hold on;
t = linspace(0,60,numel(A4y));
plot(t,A4y,'LineWidth',2);
t = linspace(0,60,numel(A4z));
plot(t,A4z,'LineWidth',2);
t = linspace(0,60,numel(Ang4x));
plot(t,Ang4x,'LineWidth',2);
t = linspace(0,60,numel(Ang4y));
plot(t,Ang4y,'LineWidth',2);
t = linspace(0,60,numel(Ang4z));
plot(t,Ang4z,'LineWidth',2);
legend('A_x','A_y','A_z','\theta_x','\theta_y','\theta_z')
title('Trial 4'); xlabel('Time (sec)');


figure(5); hold on;
t = linspace(0,60,numel(A1x));
plot(t,A1x,'LineWidth',2);
t = linspace(0,60,numel(A2x));
plot(t,A2x,'LineWidth',2);
t = linspace(0,60,numel(A3x));
plot(t,A3x,'LineWidth',2); 
t = linspace(0,60,numel(A4x));
plot(t,A4x,'LineWidth',2);  
legend('Test 1','Test 2','Test 3','Test 4');
title('Acceleration X'); xlabel('Time (sec)');
ylabel('Acceleration Gs ');


figure(6); hold on;
t = linspace(0,60,numel(A1y));
plot(t,A1y,'LineWidth',2);
t = linspace(0,60,numel(A2y));
plot(t,A2y,'LineWidth',2);
t = linspace(0,60,numel(A3y));
plot(t,A3y,'LineWidth',2);
t = linspace(0,60,numel(A4y));
plot(t,A4y,'LineWidth',2);
legend('Test 1','Test 2','Test 3','Test 4');
title('Acceleration Y'); xlabel('Time (sec)');
ylabel('Acceleration Gs ');


figure(7); hold on;
t = linspace(0,60,numel(A1z));
plot(t,A1z,'LineWidth',2);
t = linspace(0,60,numel(A2z));
plot(t,A2z,'LineWidth',2);
t = linspace(0,60,numel(A3z));
plot(t,A3z,'LineWidth',2);
t = linspace(0,60,numel(A4z));
plot(t,A4z,'LineWidth',2); 
legend('Test 1','Test 2','Test 3','Test 4');
title('Acceleration Z'); xlabel('Time (sec)');
ylabel('Acceleration Gs ');


figure(8); hold on;
t = linspace(0,60,numel(Ang1x));
plot(t,Ang1x,'LineWidth',2);
t = linspace(0,60,numel(Ang2x));
plot(t,Ang2x,'LineWidth',2);
t = linspace(0,60,numel(Ang3x));
plot(t,Ang3x,'LineWidth',2);
t = linspace(0,60,numel(Ang4x));
plot(t,Ang4x,'LineWidth',2);
legend('Test 1','Test 2','Test 3','Test 4');
title('Steering Angle X'); xlabel('Time (sec)');
ylabel('Steering Angle (degrees)');


figure(9); hold on;
t = linspace(0,60,numel(Ang1y));
plot(t,Ang1y,'LineWidth',2);
t = linspace(0,60,numel(Ang2y));
plot(t,Ang2y,'LineWidth',2);
t = linspace(0,60,numel(Ang3y));
plot(t,Ang3y,'*','LineWidth',2);
t = linspace(0,60,numel(Ang4y));
plot(t,Ang4y,'LineWidth',2);
legend('Test 1','Test 2','Test 3','Test 4');
title('Steering Angle Y'); xlabel('Time (sec)');
ylabel('Steering Angle (degrees)');


figure(10); hold on;
t = linspace(0,60,numel(Ang1z));
plot(t,Ang1z,'LineWidth',2);
t = linspace(0,60,numel(Ang2z));
plot(t,Ang2z,'LineWidth',2);
t = linspace(0,60,numel(Ang3z));
plot(t,Ang3z,'LineWidth',2);
t = linspace(0,60,numel(Ang4z));
plot(t,Ang4z,'LineWidth',2); 
legend('Test 1','Test 2','Test 3','Test 4');
title('Steering Angle Z'); xlabel('Time (sec)');
ylabel('Steering Angle (degrees)');


figure(20); hold on;
del = 1/100; %From Specs
N = numel(A1x);
Nyq = 1/(2*del);
freq = linspace(0,Nyq,N/2);
plot(freq,abs(fft(A1x(1:N/2))),'LineWidth',2);
N = numel(A2x)-1;
Nyq = 1/(2*del);
freq = linspace(0,Nyq,N/2);
plot(freq,abs(fft(A2x(1:N/2))),'LineWidth',2);
N = numel(A3x)-1;
Nyq = 1/(2*del);
freq = linspace(0,Nyq,N/2);
plot(freq,abs(fft(A3x(1:N/2))),'LineWidth',2);
N = numel(A4x)-1;
Nyq = 1/(2*del);
freq = linspace(0,Nyq,N/2);
plot(freq,abs(fft(A4x(1:N/2))),'LineWidth',2);  
legend('Test 1','Test 2','Test 3','Test 4');
title('FFT on Acceleration X'); xlabel('Frequency (Hz)')
ylabel('Amplitude')

figure(21); hold on;
del = 1/100;
N = numel(A1y);
Nyq = 1/(2*del);
freq = linspace(0,Nyq,N/2);
plot(freq,abs(fft(A1y(1:N/2))),'LineWidth',2);
N = numel(A2y)-1;
Nyq = 1/(2*del);
freq = linspace(0,Nyq,N/2);
plot(freq,abs(fft(A2y(1:N/2))),'LineWidth',2);
N = numel(A3y)-1;
Nyq = 1/(2*del);
freq = linspace(0,Nyq,N/2);
plot(freq,abs(fft(A3y(1:N/2))),'LineWidth',2);
N = numel(A4y)-1;
Nyq = 1/(2*del);
freq = linspace(0,Nyq,N/2);
plot(freq,abs(fft(A4y(1:N/2))),'LineWidth',2);  
legend('Test 1','Test 2','Test 3','Test 4');
title('FFT on Acceleration Y'); xlabel('Frequency (Hz)')
ylabel('Amplitude')

figure(22); hold on;
del = 1/100;
N = numel(A1z);
Nyq = 1/(2*del);
freq = linspace(0,Nyq,N/2);
plot(freq,abs(fft(A1z(1:N/2))),'LineWidth',2);
N = numel(A2z)-1;
Nyq = 1/(2*del);
freq = linspace(0,Nyq,N/2);
plot(freq,abs(fft(A2z(1:N/2))),'LineWidth',2);
N = numel(A3z)-1;
Nyq = 1/(2*del);
freq = linspace(0,Nyq,N/2);
plot(freq,abs(fft(A3z(1:N/2))),'LineWidth',2);
N = numel(A4z)-1;
Nyq = 1/(2*del);
freq = linspace(0,Nyq,N/2);
plot(freq,abs(fft(A4z(1:N/2))),'LineWidth',2);  
legend('Test 1','Test 2','Test 3','Test 4');
title('FFT on Acceleration Z'); xlabel('Frequency (Hz)');
ylabel('Amplitude')