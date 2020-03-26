load('matlabData\Slice\FCA1Accelx.mat'); 
Signal = FCA1Accelx;
idx = isnan(Signal);
Signal(idx ==1) = [];

[C,L] = wavedec(Signal,6,'coif2');
[~,Ed] = wenergy(C,L);
% Ed = E(n)
E = wentropy(Signal,'shannon');

Ratio = sum(abs(Ed).^2)/-1*E
