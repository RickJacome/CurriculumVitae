function [Ratio] = EnergyShanonRatio(signal,type)
[C,L] = wavedec(signal,6,type);
approx = appcoef(C,L,type);
[cd1,cd2,cd3,cd4,cd5,cd6] = detcoef(C,L,[1 2 3 4 5 6]);
[Ea,Ed] = wenergy(C,L);
E = wentropy(C,'shannon');
Ratio = sum(abs(Ed).^2)/-1*E;
end



