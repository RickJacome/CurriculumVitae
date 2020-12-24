clear; close all; clc
%Google Earth Data
load('Road.mat'); %Data in Feet
x2 = Road.XEx; y2 = Road.YEx;
x2 = x2'*.3048; y2 = y2'*.3048; %Conversion to Meters
x2 = unique(x2,'stable'); y2 = unique(y2,'stable');
x2 = x2(1:numel(y2));
x2 = x2(1:20:end);
y2 = y2(1:20:end);
X = [x2',y2'];
[L2,R2,K2] = curvature(X);
figure; plot(L2,R2); grid on;
title('Curvature radius \rho vs. Cumulative curve length')
%The Radius of Curvature is High at the Ends and Small at the middle
%Which is opposite for the Curvature Kappa
xlabel('Length of Road'); ylabel('Radius \rho')
figure; h = plot(x2,y2); grid on; set(h,'marker','.');
xlabel('X Coordinate (m)'); ylabel('Y Coordinate (m)')
title('Road with Curvature Vectors')
hold on   
quiver(x2',y2',K2(:,1),K2(:,2)); hold off
%---------------------------------------------------
KK = sqrt(K2(:,2).^2+K2(:,1).^2);
figure; plot(L2,KK); grid on
xlabel('Lenght of Road'); ylabel('Curvature \kappa (m^{-1})')
title('Curvature \kappa vs. Cumulative curve length')
% Cummulative Because is always positive, No good
[Th,n] = DiscInteg2(KK,L2); figure
plot(L2(1:n),Th*180/pi); grid on
xlabel('Segment S'); ylabel('Heading Angle \theta degrees')
title('Integrated Heading \theta from K magnitude')
%---------------------------------------------------
%Adding 90, instead of Integrating BEST OPTION SO FAR
Thk = atand(K2(:,2)./K2(:,1));
figure; plot(L2,Thk); title(' Angle of K'); grid on
AddedThK = transpose(Thk + 90);
figure; plot(L2,AddedThK); title(' Adding 90 deg to Angle of K'); grid on
%----------------------
%Integrating Components each- This fails  
[Thk1,n] = DiscInteg2(K2(:,1),L2);
[Thk2,n] = DiscInteg2(K2(:,2),L2);
ThkTotal = sqrt(Thk1.^2 + Thk2.^2);
Ang = rad2deg(ThkTotal);
Ang = Ang + Ang(1);  % Need an initial angle, that cannot be provided from this data,.....
figure; plot(L2,Ang); title('Angle of Integrating Components of K'); grid on
%%%%%-----------------------------------------
O2 = AddedThK;
% Smoothing Winner
x = L2; y = O2;
yy1 = smooth(x,y,0.15,'loess');  %Span of 15%
%yy1 = smooth(x,y,0.15,'rloess');
figure
plot(x,y,'b.',x,yy1,'r-'); grid on
xlabel('Segment Length (m)'); ylabel('Road Tangent Angle (deg)')
legend('Angle Data','Smoothed Data',...
       'Location','best')
%%%%%-----------------------------------------
Thk1d = rad2deg(Thk1);
Thk2d = rad2deg(Thk2);
e1 = Thk1d; e2 = Thk2d;
e1 = transpose(cosd(yy1)); e2 = transpose(sind(yy1));
figure
h1 = plot(x2,y2); grid on; set(h1,'marker','.');
hold on; 
quiver(x2(1:end),y2(1:end),e1(1:end),e2(1:end)); 
%quiver(x2(1:20:end),y2(1:20:end),e1(1:20:end),e2(1:20:end)); 
hold off
title('Road with Velocity Vectors')
xlabel('X Coordinate (m)'); ylabel('Y Coordinate (m)');
%%%%%-----------------------------------------

%Central Difference Method
N = numel(yy1);
k_num_C = zeros(1,N);
for i = 2:N-1
k_num_C(i) = (yy1(i+1) - yy1(i-1))/(L2(i+1) - L2(i-1));   
end
figure;plot(L2,k_num_C)

a=x2(1:20:end);
b=y2(1:20:end);
c=e1(1:20:end);
d=e2(1:20:end); 
e=transpose(L2(1:20:end));
f=k_num_C(1:20:end);
H = table(a',b',c',d',e',f');


%%%%%---------------------------------------------
function [Th,n] = DiscInteg2(K,L2)
%Discrete Integration Function
S = L2;
n = numel(S);
%% Leave everything below
Th  = zeros(1,n);   D  = zeros(1,n);
for k = 2:n-1 
   Th(k+1) =  ( (S(k+1)-S(k))*((K(k+1)+K(k))/2) ) + Th(k) ; 
end

for k = 2:n-1 
   D(k+1) =  ( (S(k+1)-S(k))*((Th(k+1)+Th(k))/2) ) + D(k) ; 
end
end
