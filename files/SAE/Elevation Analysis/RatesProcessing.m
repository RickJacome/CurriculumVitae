clc; clear all; close all
%load('data.mat');
tm = 0:.01:180;
xr = .3*sin(0.5.*tm);
yr = .2*sin(0.35.*tm);
zr = .1*sin(0.2.*tm);
plot(tm,xr,tm,yr,tm,zr,'linewidth',1.5)
xlabel('Time(sec)')
ylabel('Angular Rate (rad/sec)');
legend('Roll Rate','Pitch Rate','Yaw Rate')
n = numel(tm);
xd = zeros(1,n); yd = zeros(1,n); zd = zeros(1,n); 
for i = 1:n-1
xd(i+1) = (tm(i+1)-tm(i)).*((xr(i+1)+xr(i))/2) + xd(i);
yd(i+1) = (tm(i+1)-tm(i)).*((yr(i+1)+yr(i))/2) + yd(i);
zd(i+1) = (tm(i+1)-tm(i)).*((zr(i+1)+zr(i))/2) + zd(i);
end
figure
plot(tm,xd,tm,yd,tm,zd,'linewidth',1.5)
legend('Roll','Pitch','Yaw')



