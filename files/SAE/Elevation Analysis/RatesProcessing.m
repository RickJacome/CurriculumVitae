clc; clear all; close all
load('Gyro3.mat');
tm = Gyro3.time;
xr = Gyro3.wxrads;
yr = Gyro3.wyrads;
zr = Gyro3.wzrads;
tm = tm'; xr = xr'; yr = yr'; zr = zr';
plot(tm,xr,tm,yr,tm,zr,'linewidth',1.5)
xlabel('Time(sec)'); ylabel('Angular Rate (rad/sec)');
legend('Roll Rate','Pitch Rate','Yaw Rate')

n = numel(tm);
xd = zeros(1,n); yd = zeros(1,n); zd = zeros(1,n); 

for i = 1:n-1
    %Numerical Quadrature, Trapezoidal Approach
    xd(i+1) = (tm(i+1)-tm(i)).*((xr(i+1)+xr(i))/2) + xd(i);
    yd(i+1) = (tm(i+1)-tm(i)).*((yr(i+1)+yr(i))/2) + yd(i);
    zd(i+1) = (tm(i+1)-tm(i)).*((zr(i+1)+zr(i))/2) + zd(i);

end
figure; plot(tm,xd,tm,yd,tm,zd,'linewidth',1.5)
xlabel('Time(sec)'); ylabel('Angular Displacement (rad)');
legend('Roll','Pitch','Yaw')
figure; plot(tm,rad2deg(xd),tm,rad2deg(yd),tm,rad2deg(zd),'linewidth',1.5)
xlabel('Time(sec)'); ylabel('Angular Displacement (deg)');

c = asin(1./sqrt( (cos(xd)).^2 + (cos(yd)).^2 +(cos(zd)).^2 ));
cdeg = rad2deg(c);
figure; plot( tm,cdeg ); % Good elevation, on average it is almost flat
title('c-method elevation profile');
xlabel('Time(sec)'); ylabel('Elevation (deg)');

% vector of 1-D look-up table "x" points
XI = linspace(min(tm),max(tm),20);
% obtain vector of 1-D look-up table "y" points
YI = lsq_lut_piecewise( tm', cdeg', XI );
figure; plot(tm,cdeg,'.',XI,YI,'+-'); grid on;
legend('experimental data','LUT points','location','best')
title('Piecewise 1-D look-up table least square estimation')



% % Linear Least Square - Regression Approach
% A = [ones(n,1) tm' (tm').^2 (tm').^3];
% x = A\c';
% figure; s = x(1)+ x(2)*tm + x(3)*tm.^2 + x(4)*tm.^3; plot(tm,s)
% % Normal Equations Approach
% C = A'*c'; %Making the matrices positive definite
% M = A'*A;
% R = chol(M);
% x = R\(R'\C);
% figure; s = x(1)+ x(2)*tm + x(3)*tm.^2 + x(4)*tm.^3; plot(tm,s)