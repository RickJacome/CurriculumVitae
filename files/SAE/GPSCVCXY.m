clear; close all; clc
%Google Earth Data
load('GPS1Xft.mat'); load('GPS1Yft.mat'); %Data in Feet
x2 = GPSX; y2 = GPSY;
x2 = x2'*.3048; y2 = y2'*.3048; %Conversion to Meters
%GPS DATA
%load('CVF9LatX.mat'); load('CVF9LongY.mat');
%x2 = LatX'; y2 = LongY'; 
%Ideal AASHTO
%load('MichXm.mat'); load('MichYm.mat');  
%x2 = xm'; y2 = ym';
x2 = unique(x2,'stable');
y2 = unique(y2,'stable');
x2 = x2(1:numel(y2));X = [x2',y2'];
[L2,R2,K2] = curvature(X);
figure(1); plot(L2,R2); grid on;
title('Curvature radius \rho vs. Cumulative curve length')
%The Radius of Curvature is High at the Ends and Small at the middle
%Which is opposite for the Curvature Kappa
xlabel('Length of Road'); ylabel('Radius \rho')
figure(2);
h = plot(x2,y2); grid on; axis equal; set(h,'marker','.');
xlabel('X Coordinate'); ylabel('Y Coordinate')
title('Road with Curvature Vectors')
hold on   
quiver(x2',y2',K2(:,1),K2(:,2)); hold off
% figure(3); hold on;
% plot(x2,sqrt(K2(:,2).^2+K2(:,1).^2))
% xlabel('X-Coordinate'); ylabel('Curvature \kappa'); grid on;
% title('Curvature \kappa vs X Coordinate')
% figure(4); hold on;
% plot(y2,sqrt(K2(:,2).^2+K2(:,1).^2))
% xlabel('Y-Coordinate'); ylabel('Curvature \kappa'); grid on;
% title('Curvature \kappa vs Y Coordinate')

KK = sqrt(K2(:,2).^2+K2(:,1).^2);
figure(5); plot(L2,KK); grid on
xlabel('Lenght of Road'); ylabel('Curvature \kappa')
title('Curvature \kappa vs. Cumulative curve length')

%  Smoothing Technique on Curvature----------------
figure(1050)
x = L2; y = KK;
yy1 = smooth(x,y,0.15,'loess');  %Span of 15%
yy2 = smooth(x,y,0.15,'rloess');

%subplot(2,1,1)
plot(x,y,'b.',x,yy1,'r-'); ylim([0,.3]); grid on
legend('Original data','Smoothed data using ''loess''',...
       'Location','best')
xlabel('Segment S (m)'); ylabel('Curvature K')
%subplot(2,1,2)
figure(1051)
plot(x,y,'b.',x,yy2,'r-'); grid on;  ylim([0,.3])
xlabel('Segment S (m)'); ylabel('Curvature K')
legend('Original data','Smoothed Data',...
       'Location','best')
   
%-------
[Th,n] = DiscInteg(K2,L2);
figure(20)
plot(L2(1:n),Th*180/pi); grid on
xlabel('Segment S'); ylabel('Heading Angle \theta degrees')
title('Numerically Integrated Heading \theta')
%Note: This angle is in reference to the completely horizontal line 
% that was defined from the road design perpesctive

figure(21)
O = atand(K2(:,2)./K2(:,1));
plot(L2,O) 
xlabel('S'); ylabel('Angle from Inverse Tan')
title('Angle from Inverse Tan')

figure(22)
[O1,O2] = direction(K2);
figure(21); plot(L2,O1)
xlabel('Segment S (m)'); ylabel('Angle from Inverse Tangent')
title('Angle of Curvature Direction'); grid on;
figure(22); plot(L2,O2)
xlabel('Segment S (m)'); ylabel('Angle of Velocity Vector')
title('Angle of Velocity Direction'); 
grid on;
%  Smoothing Technique on Angles----------------
figure(1000)
x = L2; y = O2;
yy1 = smooth(x,y,0.15,'loess');  %Span of 15%
yy2 = smooth(x,y,0.15,'rloess');

%subplot(2,1,1)
plot(x,y,'b.',x,yy1,'r-')
legend('Original data','Smoothed data using ''loess''',...
       'Location','SE')
xlabel('Segment S (m)'); ylabel('Angle of Velocity Vector')
%subplot(2,1,2)
figure(1001)
plot(x,y,'b.',x,yy2,'r-'); grid on
xlabel('Segment S (m)'); ylabel('Angle of Velocity Vector')
legend('Original data','Smoothed Data',...
       'Location','SE')

% --------
e1 = cosd(O2); e2 = sind(O2);
figure(23)
subplot(1,2,1)
h1 = plot(x2,y2); grid on; axis equal; set(h1,'marker','.');
hold on; quiver(x2',y2',e1,e2); hold off
%title('Road with Velocity Vectors')
xlabel('X Coordinate (m)'); ylabel('Y Coordinate (m)');


% ---- smoothed data quiver
subplot(1,2,2)
e1 = cosd(yy2); e2 = sind(yy2);
%figure(1002)
h1 = plot(x2,y2); grid on; axis equal; set(h1,'marker','.');
hold on; quiver(x2',y2',e1,e2); hold off
xlabel('X Coordinate (m)'); ylabel('Y Coordinate (m)');

%
figure(30)
subplot(2,2,1)
plot(L2,R2); grid on;
title('\rho vs. S')
xlabel S; ylabel('\rho')
subplot(2,2,2)
plot(x2,y2); grid on; hold on
xlabel X; ylabel Y
title('Road with Curvature Vectors')
quiver(x2',y2',K2(:,1),K2(:,2)); hold off
subplot(2,2,3)
plot(L2,(sqrt(K2(:,2).^2+K2(:,1).^2)))
grid on;
title('\kappa vs. S')
xlabel S; ylabel('\kappa')
subplot(2,2,4)
plot(L2(1:n),Th*180/pi); grid on
title('Integrated Heading \theta')
xlabel S; ylabel('\theta')


