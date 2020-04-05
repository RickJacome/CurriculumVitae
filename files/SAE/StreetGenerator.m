% delete('vpathr2.xlsx')
clear all; clc; close all
%% Tranversing a curve with radius R, 90degrees not counting transitions
% Curve and transitions are based on AASHTO guidelines
minradius = xlsread('min_radius');
%K  = xlsread('Understeer Gradient');
e = 12; %percent
v = 60; %mph
c = 4; %ft/s^3
vn = v*1.46667; %ft/s
tstep = 0.025;  %CarSim Time Step
[m, n] = find(minradius==e);
minradius_1 = minradius(m,:);
[m1, n1] = find(minradius_1 == v);
R = minradius_1(m1, 4); %ft
quad = (2*pi*R)/8; %Eight Section of Perfect Circle
curve_t = quad/vn;  %Time it takes to go through it
Ltrans = (3.15*(vn^3))/(R*c); %ft  from book Eq 3-27
Ltime = Ltrans/vn; %seconds   %time to traverse Ltrans
w_constant = vn/R; %rad/s  Omega for constant radius
a = w_constant/Ltime; %rad/s^2  Assuming Constant Acceleration on everything
%that is NOT the constant radius curve. 
sum_t = 2*Ltime + curve_t;  
pathlength = round(sum_t/tstep)+100;   % + 100 is just extra lenght
%% Road Path
w = zeros(pathlength,1); theta = zeros(pathlength,1);
t = zeros(pathlength,1);
x = zeros(pathlength,1);  y = zeros(pathlength,1);
r = zeros(pathlength,1);
r(1,1) = 61958;  % Interpolated Starting Point (to avoid Zero)
for i = 2:round(Ltime/tstep)
     t(i,1) = t(i-1,1) + tstep;
     w(i,1) = w(i-1,1) +tstep*a;
     theta(i,1) = theta(i-1,1) + tstep*w(i,1);
     x(i) = x(i-1) + vn*cos(theta(i))*tstep;
     y(i) = y(i-1) + vn*sin(theta(i))*tstep;
     r(i,1) =  vn/w(i);
end
for i = round(Ltime/tstep)+1:round((Ltime+curve_t)/tstep)
     t(i,1) = t(i-1,1) + tstep;
     w(i,1) = w_constant;
     theta(i,1) = theta(i-1,1) + tstep*w(i,1);
      x(i) = x(i-1) + vn*cos(theta(i))*tstep;
      y(i) = y(i-1) + vn*sin(theta(i))*tstep;
      r(i,1) =  vn/w(i);
end
for i = round((Ltime+curve_t)/tstep)+1:pathlength-101
     t(i,1) = t(i-1,1) + tstep;
     w(i,1) = w(i-1,1) -tstep*a;
     theta(i,1) = theta(i-1,1) + tstep*w(i,1);
     x(i) = x(i-1) + vn*cos(theta(i))*tstep;
     y(i) = y(i-1) + vn*sin(theta(i))*tstep;
     r(i,1) =  vn/w(i);
end
for i = pathlength - 101: pathlength
     t(i,1) = t(i-1,1) + tstep;
     w(i,1) = w(i-1,1);
     theta(i,1) = theta(i-1,1) + tstep*w(i,1);
     x(i) = x(i-1) + vn*cos(theta(i))*tstep;
     y(i) = y(i-1) + vn*sin(theta(i))*tstep;
     r(i,1) =  vn/w(i);
end
curvature = zeros(pathlength,1);
for i = 1:pathlength
    curvature(i,1) = 1/r(i,1);
end
s = zeros(pathlength,1);
for i = 2:pathlength
    s(i,1) = s(i-1,1) + ((1+((y(i)-y(i-1))/(x(i)-x(i-1)))^2)^.5)*(x(i)-x(i-1));
end
steer_angle = zeros(pathlength,1);
a_lat = zeros(pathlength,1);
for i = 2: pathlength
    a_lat(i,1) = vn.^2/r(i,1)/32.174;
end
for i = 2:pathlength
    steer_angle(i,1) = 57.3*curvature(i,1)*10 +1.4563*a_lat(i,1);
end
wheel_angle = steer_angle*30.74;
xm = zeros(pathlength,1);
ym = zeros(pathlength,1);
for i = 2:pathlength
    xm(i,1) = x(i,1)*.3048;
    ym(i,1) = y(i,1)*.3048;
end
%% Plotting
figure(1); plot(x,y);
figure(2); plot(t,r);
figure(3); plot(t,wheel_angle);