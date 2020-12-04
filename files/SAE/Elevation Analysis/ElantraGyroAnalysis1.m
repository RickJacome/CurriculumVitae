clc; clear all; close all
%Hyundai Elantra Gyro Analysis Trial 1
load('ElantraTrial1.mat')
v = ElantraTrial1.Speedms;
tm = ElantraTrial1.time;
xr = ElantraTrial1.wx;
yr = ElantraTrial1.wy;
zr = ElantraTrial1.wz;
xr(isnan(xr)) = []; yr(isnan(yr)) = [];
zr(isnan(zr)) = []; tm(isnan(tm)) = []; v(isnan(v)) = [];
tm = tm'; xr = xr'; yr = yr'; zr = zr';
figure; plot(tm,xr,tm,yr,tm,zr,'linewidth',1.5)
xlabel('Time(sec)'); ylabel('Angular Rate (rad/sec)');
legend('Pitch Rate','Roll Rate','Yaw Rate','location','best')

figure; plot(tm,v)
n = numel(tm);
xd = zeros(1,n); yd = zeros(1,n); zd = zeros(1,n); 

for i = 1:n-1
    %Numerical Quadrature, Trapezoidal Approach
    xd(i+1) = (tm(i+1)-tm(i)).*((xr(i+1)+xr(i))/2) + xd(i);
    yd(i+1) = (tm(i+1)-tm(i)).*((yr(i+1)+yr(i))/2) + yd(i);
    zd(i+1) = (tm(i+1)-tm(i)).*((zr(i+1)+zr(i))/2) + zd(i);
end
figure; plot(tm,xd,tm,yd,tm,zd,'linewidth',1.5); grid on
xlabel('Time(sec)'); ylabel('Angular Displacement (rad)');
legend('Pitch','Roll','Yaw','location','best')
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
figure; plot(tm,xd)
hold on; plot(tm,m_xr_int)
Zero_xd = (xd-m_xr_int);
plot(tm,Zero_xd,'linewidth',1.5);
title('Pitch')
legend('Integrated','Drift-Integrated','Drift Subtracted','location','best')
xlabel('Time (sec)'); ylabel ('Angular Displacement (deg)');

figure; plot(tm,rad2deg(xd))
hold on; plot(tm,rad2deg(m_xr_int))
Zero_xd = (xd-m_xr_int);
plot(tm,rad2deg(Zero_xd),'linewidth',1.5);
title('Pitch'); grid on;
legend('Integrated','Drift-Integrated','Drift Subtracted','location','best')
xlabel('Time (sec)'); ylabel ('Angular Displacement (deg)');
%------------------------------------
% Roll
m_yr = mean(yr)*ones(1,n);
figure;
plot(tm,yr,tm,m_yr); 
m_yr_int = zeros(1,n); 
for i = 1:n-1
    m_yr_int(i+1) = (tm(i+1)-tm(i)).*((m_yr(i+1)+m_yr(i))/2) + m_yr_int(i);
end
figure; plot(tm,yd)
hold on; plot(tm,m_yr_int)
Zero_yd = (yd-m_yr_int);
plot(tm,Zero_yd,'linewidth',1.5);
title('Roll')
legend('Integrated','Drift-Integrated','Drift Subtracted','location','best')
xlabel('Time (sec)'); ylabel ('Angular Displacement (rad)');

figure; plot(tm,rad2deg(yd))
hold on; plot(tm,rad2deg(m_yr_int))
Zero_yd = (yd-m_yr_int);
plot(tm,rad2deg(Zero_yd),'linewidth',1.5);
title('Roll'); grid on;
legend('Integrated','Drift-Integrated','Drift Subtracted','location','best')
xlabel('Time (sec)'); ylabel ('Angular Displacement (deg)');
%------------------------------------
% Yaw
m_zr = mean(zr)*ones(1,n);
figure;
plot(tm,zr,tm,m_zr); 
m_zr_int = zeros(1,n); 
for i = 1:n-1
    m_zr_int(i+1) = (tm(i+1)-tm(i)).*((m_zr(i+1)+m_zr(i))/2) + m_zr_int(i);
end
figure; plot(tm,zd)
hold on; plot(tm,m_zr_int)
Zero_zd = (zd-m_zr_int);
plot(tm,Zero_zd,'linewidth',1.5);
title('Yaw')
legend('Integrated','Drift-Integrated','Drift Subtracted','location','best')
xlabel('Time (sec)'); ylabel ('Angular Displacement (rad)');

figure; plot(tm,rad2deg(zd))
hold on; plot(tm,rad2deg(m_zr_int))
Zero_zd = (zd-m_zr_int);
plot(tm,rad2deg(Zero_zd),'linewidth',1.5);
title('Yaw'); grid on;
legend('Integrated','Drift-Integrated','Drift Subtracted','location','best')
xlabel('Time (sec)'); ylabel ('Angular Displacement (deg)');
%------------------------------------
cab(7)
