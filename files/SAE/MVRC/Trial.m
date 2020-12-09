clear; close all; clc
%Google Earth Data
load('Road.mat'); %Data in Feet
x2 = Road.XEx;
y2 = Road.YEx;
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

kTh = atand(K2(:,2)./K2(:,1));
figure; plot(L2,kTh); title(' Angle of Kappa')
figure; plot(L2, kTh+90); title('Adding +90 to Angle of Kappa')
K2mag = sqrt(K2(:,1).^2+K2(:,2).^2);
K2Int = K2mag.*kTh;
[Th,n] = DiscInteg2(K2Int,L2);
figure; title('Integrating Kappa')
plot(L2(1:n),Th); grid on

e1 = cosd(Th); e2 = sind(Th);
figure; h1 = plot(x2,y2); grid on; axis equal; set(h1,'marker','.');
hold on; quiver(x2,y2,e1,e2); hold off
%title('Road with Velocity Vectors')
xlabel('X Coordinate (m)'); ylabel('Y Coordinate (m)');

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
end

