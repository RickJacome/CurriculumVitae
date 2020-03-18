function [Ratio] = EnergyShanonRatio(signal,level,type)
[C,L] = wavedec(signal,level,type);
[~,Ed] = wenergy(C,L);
% Ed = E(n)
E = wentropy(C,'shannon');

Ratio = sum(abs(Ed).^2)/-1*E;
end






