clc; clear all; close all
R = 6378137;N = 20;
thetavec = linspace(0,pi,N);
phivec = linspace(0,2*pi,2*N);
[th, ph] = meshgrid(thetavec,phivec);
R = R*ones(size(th)); % should be your R(theta,phi) surface in general
x = R.*sin(th).*cos(ph);
y = R.*sin(th).*sin(ph);
z = R.*cos(th);
figure;
surf(x,y,z,'FaceAlpha',0.1);
hold on

GPS = [40.8136 96.7026 358];
[px,py,pz] = LL2ECEF(GPS);
plot3(px,py,pz,'ko','MarkerSize',1,'MarkerFaceColor','k')
hold on;
GPS = [41.2565 95.9345 332];
[px,py,pz] = LL2ECEF(GPS);
plot3(px,py,pz,'ko','MarkerSize',1,'MarkerFaceColor','k')
grid on;


function [px, py, pz] = LL2ECEF(input)

lat = input(1);
long = input(2); 
alt = input(3); 
R = 6378137; % radius of eartth in meters
f = 1/298.257223563; %Flatenning WGS 84
lam = atand((1-f)^2*tand(lat));
rs = sqrt(R^2/(1 + (1/(1-f)^2-1)*sind(lam)^2));
px = rs*cosd(lam)*cosd(long) + alt*cosd(lat)*cosd(long);
py = rs*cosd(lam)*sind(long) + alt*cosd(lat)*sind(long);
pz = rs*sind(lam) + alt*sind(lat);



end