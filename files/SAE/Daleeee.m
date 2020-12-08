clear; close all; clc
%Google Earth Data
load('GPS1Xft.mat'); load('GPS1Yft.mat'); %Data in Feet
x2 = GPSX; y2 = GPSY;
x2 = x2'*.3048; y2 = y2'*.3048; %Conversion to Meters
x2 = unique(x2,'stable');
y2 = unique(y2,'stable');
x2 = x2(1:numel(y2));X = [x2',y2'];
[L2,R2,K2] = curvature(X);
figure(1); plot(L2,R2); grid on;
title('Curvature radius \rho vs. Cumulative curve length')
%The Radius of Curvature is High at the Ends and Small at the middle
%Which is opposite for the Curvature Kappa
xlabel('Length of Road'); ylabel('Radius \rho')
figure(2);
h = plot(x2,y2); grid on; axis equal; set(h,'marker','.');
xlabel('X Coordinate'); ylabel('Y Coordinate')
title('Road with Curvature Vectors')
hold on   
quiver(x2',y2',K2(:,1),K2(:,2)); hold off

KK = sqrt(K2(:,2).^2+K2(:,1).^2);
figure(5); plot(L2,KK); grid on
xlabel('Lenght of Road'); ylabel('Curvature \kappa')
title('Curvature \kappa vs. Cumulative curve length')
[Th,n] = DiscInteg2(K2,L2);
figure(20)
plot(L2(1:n),Th*180/pi); grid on
xlabel('Segment S'); ylabel('Heading Angle \theta degrees')
title('Numerically Integrated Heading \theta')

Thk = atand(K2(:,2)./K2(:,1));
figure; plot(L2,Thk); title(' Angle of K')
figure; plot(L2,Thk + 90); title(' Adding 90 deg to Angle of K')

[Thk1,n] = DiscInteg2(K2(:,1),L2);
[Thk2,n] = DiscInteg2(K2(:,2),L2);
ThkTotal = sqrt(Thk1.^2 + Thk2.^2);
figure; plot(L2,rad2deg(ThkTotal)+36.48); title('Angle of Integrated K')


function [Th,n] = DiscInteg2(K,L2)
%Discrete Integration Function
S = L2;
%K = K2(:,2)-K2(:,1);

n = numel(S);
%% Leave everything below
Th  = zeros(1,n);   D  = zeros(1,n);
for k = 2:n-1 
   Th(k+1) =  ( (S(k+1)-S(k))*((K(k+1)+K(k))/2) ) + Th(k) ; 
end

for k = 2:n-1 
   D(k+1) =  ( (S(k+1)-S(k))*((Th(k+1)+Th(k))/2) ) + D(k) ; 
end
% figure(3)
% plot(S(1:n),Th)
% xlabel('Segment S'); ylabel('Angle \theta')
% title('Numerically Integrated \theta')
% figure(4)
% plot(S(1:n),D)
% xlabel('Segment S'); ylabel('Integrated Angle')
% title('Numerically Integrated Angle')
end
