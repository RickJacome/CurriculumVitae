%Rates Analysis With Elevation for Sentra Trial 1
clc; clear all; close all
load('SentraTrial1.mat')
v = SentraTrial1.Speedms;
tm = SentraTrial1.time;
xr = SentraTrial1.wx; yr = SentraTrial1.wy; zr = SentraTrial1.wz;
Lat = SentraTrial1.Latitude; Long = SentraTrial1.Longitude;
xr(isnan(xr)) = []; yr(isnan(yr)) = [];
zr(isnan(zr)) = []; tm(isnan(tm)) = []; v(isnan(v)) = [];
tm = tm'; xr = xr'; yr = yr'; zr = zr';
figure; plot(tm,xr,tm,yr,tm,zr,'linewidth',1.5)
xlabel('Time(sec)'); ylabel('Angular Rate (rad/sec)');
legend('Pitch Rate','Roll Rate','Yaw Rate','location','best')
figure; plot(tm,v); xlabel('Time(sec)'); ylabel('Speed (m/s)');
n = numel(tm);
xd = zeros(1,n); yd = zeros(1,n); zd = zeros(1,n); 
for i = 1:n-1
    %Numerical Quadrature, Trapezoidal Approach
    xd(i+1) = (tm(i+1)-tm(i)).*((xr(i+1)+xr(i))/2) + xd(i);
    yd(i+1) = (tm(i+1)-tm(i)).*((yr(i+1)+yr(i))/2) + yd(i);
    zd(i+1) = (tm(i+1)-tm(i)).*((zr(i+1)+zr(i))/2) + zd(i);
end
figure; plot(tm,rad2deg(xd),tm,rad2deg(yd),tm,rad2deg(zd),'linewidth',1.5)
grid on;
xlabel('Time(sec)'); ylabel('Angular Displacement (deg)');
legend('Pitch','Roll','Yaw','location','best')
%------------------------------------
% Pitch
m_xr = mean(xr)*ones(1,n);
figure;
plot(tm,xr,tm,m_xr); 
m_xr_int = zeros(1,n); 
for i = 1:n-1
    m_xr_int(i+1) = (tm(i+1)-tm(i)).*((m_xr(i+1)+m_xr(i))/2) + m_xr_int(i);
end
figure; plot(tm,rad2deg(xd))
hold on; plot(tm,rad2deg(m_xr_int))
Zero_xd = rad2deg(xd-m_xr_int);
plot(tm,Zero_xd,'linewidth',1.5);
title('Pitch'); grid on;
legend('Integrated','Drift-Integrated','Drift Subtracted','location','best')
xlabel('Time (sec)'); ylabel ('Angular Displacement (deg)');
%------------------------------------
%Transforming the data from Disp vs Time to Disp vs X
Dist = mean(v(2:end)).*tm/1000;
figure; plot(Dist,Zero_xd); grid on
xlabel('Distance (km)'); ylabel ('Angular Displacement (deg)');

load('ElevationProfile.mat');
x = ElevationProfile.HorDist; y = ElevationProfile.VertDist;
x=x(2:end); y = y(2:end);
%Elevation Profile
yyaxis right
hold on; plot(x,y); ylabel('Vertical Elevation (m)')
yyaxis left
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
X_new = zeros(1,n);
for i = 1:1:n-1
Theta(i+1) = atand( ( (YI(i+1) - YI(i))) /( (XI(i+1) - XI(i))*1000) ); 
X_new(i+1) = XI(i+1);
end
hold on;
yyaxis right
scatter(X_new,Theta,'*')
%Superelevation as a percentage
e1 = 100*sind(Theta);
text(X_new,Theta,string(e1))
figure; plot(Dist,Zero_xd); hold on;
plot(X_new,Theta); grid on;
xlabel('Distance (km)');ylabel('Angular Displacement (deg)');
