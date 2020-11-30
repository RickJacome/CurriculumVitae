clc; clear all; close all
%load('data.mat');
tm = 0:.1:180;
xr = .3*sin(0.5.*tm);
yr = .2*sin(0.35.*tm);
zr = .1*sin(0.2.*tm);
plot(tm,xr,tm,yr,tm,zr,'linewidth',1.5)
xlabel('Time(sec)'); ylabel('Angular Rate (rad/sec)');
legend('Roll Rate','Pitch Rate','Yaw Rate')

n = numel(tm);
xd = zeros(1,n); yd = zeros(1,n); zd = zeros(1,n); 

for i = 1:n-1
    
    xd(i+1) = (tm(i+1)-tm(i)).*((xr(i+1)+xr(i))/2) + xd(i);
    yd(i+1) = (tm(i+1)-tm(i)).*((yr(i+1)+yr(i))/2) + yd(i);
    zd(i+1) = (tm(i+1)-tm(i)).*((zr(i+1)+zr(i))/2) + zd(i);

end
figure; plot(tm,xd,tm,yd,tm,zd,'linewidth',1.5)
xlabel('Time(sec)'); ylabel('Angular Displacement (rad)');
legend('Roll','Pitch','Yaw')

c = asin(1./sqrt( (cos(xd)).^2 + (cos(yd)).^2 +(cos(zd)).^2 ));
figure; plot( tm,c ); % Good elevation, on average it is almost flat
xlabel('Time(sec)'); ylabel('Elevation (deg)');
A = [ones(n,1) tm' (tm').^2 (tm').^3];
x = A\c'
figure; 
s = x(1)+ x(2)*tm + x(3)*tm.^2 + x(4)*tm.^3;
plot(tm,s)

