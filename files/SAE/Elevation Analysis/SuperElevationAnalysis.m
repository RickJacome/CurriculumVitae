clc; clear all; close all; format compact;
load('ElevationProfile.mat');
x = ElevationProfile.HorDist; y = ElevationProfile.VertDist;
x=x(2:end); y = y(2:end);
%Elevation Profile
scatter(x,y,'*'); grid on;
xlabel('Horizontal Distance (km)'); ylabel('Vertical Elevation (m)')
%Multi-Linear LLS Approximation
%vector of 1-D look-up table "x" points
XI = linspace(min(x),max(x),20);
% obtain vector of 1-D look-up table "y" points
YI = lsq_lut_piecewise( x, y, XI );
figure; plot(x,y,'.',XI,YI,'+-'); grid on;
legend('experimental data','LUT points','location','best')
title('Piecewise 1-D look-up table least square estimation')

% Superelevation Angle
n = numel(YI);
Theta = zeros(1,n);
for i = 1:2:n-2
Theta(i) = atand( abs( (y(i+1) - y(i))) /abs( (x(i+1) - x(i))*1000) ); 
end
%Superelevation as a percentage
e = 100*sind(Theta);
e(e==0) = [];

