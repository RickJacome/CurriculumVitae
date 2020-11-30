clc; clear all; close all
load('ElevationData.mat');
x = ElevationDataset{:,1}; y = ElevationDataset{:,2};
scatter(x,y,'*'); grid on;
%Elevation Profile
xlabel('Horizontal Distance (km)'); ylabel('Vertical Elevation (m)')
%Values Extracted from graph
ylim([348 354]); grid on;
z1 = 350.5; y1 = 0.0396;
z2 = 353.4; y2 = 0.6343;
z3 = 349.3; y3 = 0.9507;
z4 = 349.6; y4 = 1.643;
hold on;
plot([y1,y2,y3,y3+.5],[z1,z2,z3,z3],'linewidth',2)
xlim([0 y3+.5])
legend('Elevation Profile','Linear Approximation')
% Superelevation Angle
Fi = atand( abs( (z2 - z1)) /abs( (y2 - y1)*1000) ); 
Se = atand( abs( (z3 - z2)) /abs( (y3 - y2)*1000) );
Th = atand( abs( (z4 - z3)) /abs( (y4 - y3)*1000) );
%Superelevation as a percentage
e1 = 100*sind(Fi)
e2 = 100*sind(Se)
e3 = 100*sind(Th)