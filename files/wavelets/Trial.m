clc; close all; clear all
load('matlabData\Slice\FCA1Accelx.mat'); 
load('matlabData\Slice\FCT1Slc.mat');
plot(FCT1Slc,FCA1Accelx)

%Slice Signal 1000 Hz
figure
y = mean(FCA1Accelx(1:1000));
Signal = FCA1Accelx-y;
idx = isnan(Signal);
Signal(idx == 1)=[];

%FCT1Slc = FCT1Slc(idx);

[C,L] = wavedec(Signal,6,'coif2');
approx = appcoef(C,L,'coif2');
plot(approx); 

title('Coiflet2 Approximation Slice')
hold on;
[C,L] = wavedec(Signal,9,'haar');
approx = appcoef(C,L,'haar');
plot(approx); title('Haar Approximation Slice')
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

