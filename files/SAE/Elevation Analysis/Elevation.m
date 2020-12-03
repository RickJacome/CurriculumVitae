clc; clear all; close all
load('ElevationProfile.mat');
x = ElevationProfile.HorDist; y = ElevationProfile.VertDist;
x=x(2:end); y = y(2:end);
%Elevation Profile
scatter(x,y,'*'); grid on;
xlabel('Horizontal Distance (km)'); ylabel('Vertical Elevation (m)')
%Multi-Linear LLS Approximation
%vector of 1-D look-up table "x" points
XI = linspace(min(x),max(x),8);
% obtain vector of 1-D look-up table "y" points
YI = lsq_lut_piecewise( x, y, XI );
figure; plot(x,y,'.',XI,YI,'+-'); grid on;
legend('experimental data','LUT points','location','best')
title('Piecewise 1-D look-up table least square estimation')

% Superelevation Angle
Fi = atand( abs( (z2 - z1)) /abs( (y2 - y1)*1000) ); 
Se = atand( abs( (z3 - z2)) /abs( (y3 - y2)*1000) );
Th = atand( abs( (z4 - z3)) /abs( (y4 - y3)*1000) );
%Superelevation as a percentage
e1 = 100*sind(Fi)
e2 = 100*sind(Se)
e3 = 100*sind(Th)
