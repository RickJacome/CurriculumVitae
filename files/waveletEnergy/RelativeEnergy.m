function [ERatio] = RelativeEnergy(signal,type)
n = 6; % Max number of Levels
E_n = zeros(n,1);
    for level = 1:n
         [C,L] = wavedec(signal,level,type);
        [~,Ed] = wenergy(C,L);
        E_n(level,1) = sum(abs(Ed).^2);
    end
E_t = sum(E_n);
    for level = 1:n
        ERatio = E_n(level,1)/E_t;
    end
end