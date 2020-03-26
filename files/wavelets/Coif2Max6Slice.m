%%Coilet2 Analysis, Max Level 6, Slice 1e3 Hz.   
clc; close all; clear all
load('matlabData\Slice\FCA1Accelx.mat'); 
load('matlabData\Slice\FCT1Slc.mat');

Signal = FCA1Accelx; Signal(isnan(Signal))=[];
[C,L] = wavedec(Signal,6,'coif2');
approx = appcoef(C,L,'coif2');
[cd1,cd2,cd3,cd4,cd5,cd6] = detcoef(C,L,[1 2 3 4 5 6]);
figure(1)
subplot(7,1,1); plot(approx)
title('Approximation Coefficients')
subplot(7,1,2); plot(cd6)
title('Level 6 Detail Coefficients')
subplot(7,1,3); plot(cd5)
title('Level 5 Detail Coefficients')
subplot(7,1,4); plot(cd4)
title('Level 4 Detail Coefficients')
subplot(7,1,5); plot(cd3)
title('Level 3 Detail Coefficients')
subplot(7,1,6); plot(cd2)
title('Level 2 Detail Coefficients')
subplot(7,1,7); plot(cd1)
title('Level 1 Detail Coefficients')

figure(2); plot(approx*-1)
title('Approximation Coefficients')
figure(3); plot(Signal); title('Raw Signal');
load('matlabData\Slice\FCA1CFC180avec10msAvgAccelx.mat')
figure(4); plot(-1*FCA1CFC180avec10msAvgAccelx)
title('FCA1CFC180avec10msAvgAccelx');
figure(5);
load('matlabData\Slice\FCA1ZeroCFC180Accelx.mat')
plot(-1*FCA1ZeroCFC180Accelx)
title('FCA1ZeroCFC180Accelx')

figure(6)

