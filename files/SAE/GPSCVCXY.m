clear; close all; clc
load('CVF9LatX.mat')
load('CVF9LongY.mat')
x2 = LatX'; y2 = LongY';   
%x2(1:2:end) = [];  y2(1:2:end) = [];
x2 = unique(x2);
y2 = unique(y2);
x2 = x2(1:numel(y2));X = [x2',y2'];
[L2,R2,K2] = curvature(X);
figure(1); plot(L2,R2); grid on;
title('Curvature radius \rho vs. Cumulative curve length')
%The Radius of Curvature is High at the Ends and Small at the middle
%Which is opposite for the Curvature Kappa
xlabel('Lenght of Road'); ylabel('Radius \rho')
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
figure(5); plot(L2,(sqrt(K2(:,2).^2+K2(:,1).^2))); grid on
xlabel('Lenght of Road'); ylabel('Curvature \kappa')
title('Curvature \kappa vs. Cumulative curve length')

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
figure(22); scatter(L2,O2)
xlabel('Segment S (m)'); ylabel('Angle of Velocity Vector')
title('Angle of Velocity Direction'); 
grid on;
% ----------------
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




% figure(333)
% scatter(x2,e1)
% scatter(y2,e2)
% 
% t = x2;
% y = e1;
% n = 100;
% D = 5;
% [t_LS,p] = LeastSquares(t,y,D,n);
% figure(3333)
% plot(t_LS,p,'Linewidth',3); hold on;
% xlabel('t values'); ylabel('y label')
% grid on; legend show; legend('location','best')
% plot(t,y,'o', 'MarkerSize', 10, 'LineWidth', 2); 






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





% figure(333)
% scatter(x2,e1)
% scatter(y2,e2)

% 
% KKK = sqrt(K2(:,2).^2+K2(:,1).^2);
% KKK(1) = []; KKK(end) = [];
% L2(1) = []; L2(end) = [];
% t = L2;
% y = e1;
% n = 100;
% D = 5;
% [t_LS,p] = LeastSquares(t,y,D,n);
% figure(3333)
% plot(t_LS,p,'Linewidth',3); hold on;
% xlabel('t values'); ylabel('y label')
% grid on; legend show; legend('location','best')
% plot(t,y,'o', 'MarkerSize', 10, 'LineWidth', 2); 
% 
% function [t_LS,p] = LeastSquares(t,y,D,n)
% N = numel(t); 
% A = zeros(N,D+1);  %Prelocation Matrix
% for i=1:length(t)
%     for j=1:D+1
%        A(i,j) = t(i)^(D+1-j); %Vandermonde Matrix Definition 
%     end
% end
% A = fliplr(A); %Flip the Matrix to fit LS method
% M = A'*A;  
% b = A'*y; %Create a Minimization Problem for Normal Equations
% x = M\b;  %Solve them through Matlab function
% 
% x = A\y;
% 
% t_LS = linspace( t(1) , t(length(t)), n); %Create a t vector for n values
% p  = polyval(flip(x),t_LS);
% Fit the polynomial found in x, to the values of t 
% end
% 
% 
% 
