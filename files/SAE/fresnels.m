clear all; close all; clc;
x = 3.75:0.01:4;
C = ( - sin(pi.*abs(x).^2/2)./(pi*(abs(x) + 20*pi.*exp(-200*pi.*sqrt(abs(x))))) + ...
    (8/25).*(1-exp(-69./100*pi.*abs(x).^3)) + (2/25)*(1-exp(-9/2*pi*abs(x).^2)) + ...
    (1/10).*(1-exp(-1.55294068198794*pi*abs(x)))).*sign(x);
S = (- cos(pi.*abs(x).^2/2)./(pi.*(abs(x) + 16.7312774552827*pi.*exp(-1.57638860756614*pi.*sqrt(abs(x))))) + ...
    (8/25).*(1-exp(-0.608707749430681*pi.*abs(x).^3)) + ...
    (2/25).*(1-exp(-1.71402838165388*pi.*abs(x).^2)) +...
    (1/10).*(1-exp(-9/10*pi.*abs(x)))).*sign(x);
figure; plot(x,C)
title('Cosine Fresnel Function')
figure; plot(x,S)
title('Sine Fresnel Function')
figure; plot(C,S)
title('Cosine vs Sine')
%x2 = C((end-1)/2:end); y2 = S((end-1)/2:end);   
x2 = C; y2 = S;
X = [x2',y2'];
[L2,R2,K2] = curvature(X);
KK = sqrt(K2(:,2).^2+K2(:,1).^2);
figure; scatter(L2,KK); grid on
title('Curvature Numerics')
% figure; syms x
% fplot(fresnelc(x),[-10 10]); grid on
% figure; syms x
% fplot(fresnels(x),[-10 10]); grid on
