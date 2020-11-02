% This code calculates the evolute of a curve
clear; close all; clc
%GPS DATA
load('CVF9LatX.mat'); load('CVF9LongY.mat');
%Ideal AASHTO
load('MichXm.mat'); load('MichYm.mat');
%x2 = LatX'; y2 = LongY';   
x2 = xm'; y2 = ym';
x2 = unique(x2,'stable'); y2 = unique(y2,'stable');
x2 = x2(1:numel(y2));
X = [x2',y2'];
[L,R,K] = curvature(X);
figure; plot(L,R)
R(1) = []; R(end,:) = [];
K(1,:) = []; K(end,:) = [];
L(1,:) = []; L(end,:) = [];
xlabel('Length of Road'); ylabel('Radius \rho')
figure;
x2(1) = []; x2(end) = [];
y2(1) = []; y2(end) = [];
h = plot(x2,y2); grid on; axis equal; set(h,'marker','.');
xlabel('X Coordinate'); ylabel('Y Coordinate')
title('Road with Curvature Vectors')
hold on
quiver(x2',y2',K(:,1),K(:,2)); hold off  
KK = sqrt(K(:,1).^2 + K(:,2).^2);
s = L;
figure; plot(s,KK)
for i = 1:numel(x2)-1
x2p(i) = (x2(i+1) - x2(i))/(s(i+1) - s(i));
y2p(i) = (y2(i+1) - y2(i))/(s(i+1) - s(i));
end
ini = 20; 
endi = 180;
figure; plot(x2(ini:endi),y2(ini:endi),'Linewidth',2); hold on
quiver(x2',y2',K(:,1),K(:,2));
KK(end)  = []; x2(end) = []; y2(end)  = [];
Nx=- y2p./sqrt(x2p.*x2p + y2p.*y2p);
Ny=  x2p./sqrt(x2p.*x2p + y2p.*y2p);
xe=x2 + Nx./KK';      
ye=y2 + Ny./KK';
scatter(xe(ini:endi),ye(ini:endi))

