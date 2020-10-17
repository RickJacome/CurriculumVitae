%HERE I am trying to create the Filter of the Centerlines 
clear; close all; clc
%Google Earth Data
load('GPS1Xft.mat'); load('GPS1Yft.mat'); %Data is in Feet
x2 = GPSX; y2 = GPSY;
x2 = x2'*.3048; y2 = y2'*.3048; %Conversion to Meters
%GPS DATA
%load('CVF9LatX.mat'); load('CVF9LongY.mat');
%x2 = LatX'; y2 = LongY'; 
%Ideal AASHTO
%load('MichXm.mat'); load('MichYm.mat');  
%x2 = xm'; y2 = ym';
x2 = unique(x2,'stable'); y2 = unique(y2,'stable');
x2 = x2(1:numel(y2));

X = [x2',y2'];
[L,R,K] = curvature(X);

figure;
h = plot(x2,y2); grid on; axis equal; set(h,'marker','.');
xlabel('X Coordinate (m)'); ylabel('Y Coordinate (m)')
title('Road with Curvature Vectors')
hold on; quiver(x2',y2',K(:,1),K(:,2)); hold off  
figure;
h = plot(x2,y2); grid on; axis equal; set(h,'marker','.','Linewidth',3);
xlabel('X Coordinate (m)'); ylabel('Y Coordinate (m)')
title('Road with Heading Vectors no parallism yet')
[O1,O2] = direction(K);
e1 = cosd(O2); e2 = sind(O2);
hold on; quiver(x2',y2',e1,e2); hold off
figure
plot(L,O1);
title('Central Angle of Curvature Direction');

%  Smoothing Technique on Center Lane Angles----------------
figure
x = L; y = O2;
yy1 = smooth(x,y,0.15,'loess');  %Span of 15%
yy2 = smooth(x,y,0.15,'rloess');
subplot(2,1,1)
plot(x,y,'b.',x,yy1,'r-'); grid on
% Comment for anything not MATLAB 2020 after Use
yyaxis left
%
legend('Original data','Smoothed data using ''loess''',...
       'Location','NW')
title('Central Angle of Velocity Direction');
xlabel('Segment S (m)'); ylabel('Angle of Velocity Vector (degrees)')
subplot(2,1,2)
plot(x,y,'b.',x,yy2,'r-'); grid on
xlabel('Segment S (m)'); ylabel('Angle of Velocity Vector (degrees)')
% Comment for anything not MATLAB 2020 after Use
yyaxis left
%
legend('Original data','Smoothed Data',...
       'Location','NW')

e1 = cosd(yy2); e2 = sind(yy2);
figure
subplot(1,2,1)
h1 = plot(x2,y2); grid on; axis equal; set(h1,'marker','.');
hold on; quiver(x2',y2',e1,e2); hold off
title('Road with Velocity Vectors')
subplot(1,2,2)
h1 = plot(x2,y2); grid on; axis equal; set(h1,'marker','.');
hold on;
quiver(x2',y2',K(:,1),K(:,2));
hold off; 
title('Road with Curvature Vectors')
xlabel('X Coordinate (m)'); ylabel('Y Coordinate (m)');   
   
   

% Numerical Differentiation
% MATLABs approach
k_num = diff(yy2)./diff(L);
fd_s = L(1:length(L)-1); %Forward Difference
bd_s = L(2:length(L));   %Backward Difference

%Central Difference Method
N = numel(yy2);
k_num_C = zeros(1,N);
for i = 2:N-1
k_num_C(i) = (yy2(i+1) - yy2(i-1))/(L(i+1) - L(i-1));   
end

figure;
plot(fd_s, k_num); hold on;
plot(bd_s, k_num);
plot(L,k_num_C);
title('Derivatives Central');
hold on;
K_mag = sqrt( K(:,2).^2 + K(:,1).^2 );
plot(L,K_mag)
xlabel('Segment Length (m)'); ylabel('Curvature (m^{-1})')
% Comment for anything not MATLAB 2020 after Use
yyaxis left
%
legend('Forward Difference','Backward Difference','Central Difference','Raw')

% Unit Vectors
k1 = K(:,1)./K_mag;
k2 = K(:,2)./K_mag;
figure
h1 = plot(x2,y2); grid on; axis equal; set(h1,'marker','.');
kp1 = k_num_C'.*k1;
kp2 = k_num_C'.*k2;
hold on; quiver(x2',y2',kp1,kp2); hold off

%---------------------------------------------------

figure;
plot(L,O2); hold on
ylabel('Heading Angle (degrees)')
xlabel('Segment Length (m)')
yyaxis right
plot(L,k_num_C,'color','k');
hold on;
plot(L,zeros(1,N));
ylabel('Curvature (m^{-1})')
grid on
legend('Heading Angle','Curvature','location','NW')

%---------------------------------------------------

xs = min(L):.01:max(L);
ys = spline(L,k_num_C,xs);
figure; plot(L,k_num_C,'o',xs,ys); 





