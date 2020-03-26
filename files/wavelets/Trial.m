clc; close all; clear all
load('matlabData\Slice\FCA1Accelx.mat'); 
load('matlabData\Slice\FCT1Slc.mat');
plot(FCT1Slc,FCA1Accelx)
wv1 = 'coif2'; wv2 = 'haar';
s1 = 100; s2 = 1000; 
MaxCoif100 = wmaxlev(s1,wv1)
MaxCoif1000 = wmaxlev(s2,wv1)
MaxHaar100 = wmaxlev(s1,wv2)
MaxHaar1000 = wmaxlev(s2,wv2)


%Slice Signal 1000 Hz
[Signal,Time] = ZeroEtClean(FCA1Accelx,FCT1Slc);
save('matlabData\Slice\FCA1AccelxClean','Signal');
[C,L] = wavedec(Signal,6,'coif2');
approx = appcoef(C,L,'coif2');
time = linspace(Time(1),Time(end),numel(approx));
figure
plot(time,approx); 

title('Coiflet2 Approximation Slice')

hold on;
[C,L] = wavedec(Signal,9,'haar');
approx2 = appcoef(C,L,'haar');
time = linspace(Time(1),Time(end),numel(approx2));
plot(time,approx2); 

title('Haar Approximation Slice')
legend('Coiflet 2 Approximation','Haar Approximation')

%VC4000 Signal 100 Hz
load('matlabData\FCA.mat');
load('matlabData\FCT.mat');

Signal = FullConcreteAccel; 
Signal = Signal(1:(numel(Signal)-1)/2);
figure
[C,L] = wavedec(Signal,3,'coif2');
approx = appcoef(C,L,'coif2');
plot(approx); title('Coiflet2 Approximation VC4000')

figure;
[C,L] = wavedec(Signal,6,'haar');
approx = appcoef(C,L,'haar');
plot(approx); title('Haar Approximation VC4000')
legend('Coiflet 2 Approximation','Haar Approximation')

