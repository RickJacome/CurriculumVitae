%%Coilet Analysis 
clc; close all; clear all
load('FCA.mat')
Signal = FullConcreteAccel;
%Wavelet Decomposition 
 [C,L] = wavedec(Signal,6,'coif2');
approx = appcoef(C,L,'coif2');
[cd1,cd2,cd3,cd4,cd5,cd6] = detcoef(C,L,[1 2 3 4 5 6]);

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

[Ea,Ed] = wenergy(C,L);
E = wentropy(C,'shannon');
Ratio = sum(abs(Ed).^2)/E;






