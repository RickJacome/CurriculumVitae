clc; close all; clear all
load('matlabData\Slice\FCA1Accelx.mat'); 
plot(FCA1Accelx)

%Slice Signal 1000 Hz
figure
Signal = FCA1Accelx-2.3; Signal(isnan(Signal))=[];
[C,L] = wavedec(Signal,6,'coif2');
approx = appcoef(C,L,'coif2');
plot(approx); 

title('Coiflet2 Approximation Slice')
figure
[C,L] = wavedec(Signal,9,'haar');
approx = appcoef(C,L,'haar');
plot(approx); title('Haar Approximation Slice')


%VC4000 Signal 100 Hz
load('matlabData\FCA.mat'); 
Signal = FullConcreteAccel; 
Signal = Signal(1:(numel(Signal)-1)/2);
figure
[C,L] = wavedec(Signal,3,'coif2');
approx = appcoef(C,L,'coif2');
plot(approx); title('Coiflet2 Approximation VC4000')

figure
[C,L] = wavedec(Signal,6,'haar');
approx = appcoef(C,L,'haar');
plot(approx); title('Haar Approximation VC4000')

