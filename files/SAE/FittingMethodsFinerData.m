%HERE I am trying to create the Filter of the Centerlines 
clear; close all; clc
%Google Earth Data (General Highway Curve)
load('GPS1Xft.mat'); load('GPS1Yft.mat'); %Data is in Feet
x2 = GPSX; y2 = GPSY;
x2 = x2'*.3048; y2 = y2'*.3048; %Conversion to Meters
% xlim([725000 728000])
% ylim([4543000 4549000])
%%%%Google Earth Data (Constant Radius )
% load('xGEfeet.mat'); load('yGEfeet.mat');
% x2 = xGEfeet; y2 = yGEfeet;
% x2 = x2'*.3048; y2 = y2'*.3048; %Conversion to Meters
%%%%%%
%%%%Google Earth Data (Interchange Road)
% load('xInterChngft.mat'); load('yInterChngft.mat');
% x2 = xInterChngft; y2 = yInterChngft;
% x2 = x2'*.3048; y2 = y2'*.3048; %Conversion to Meters

%%%%
x2 = unique(x2,'stable'); y2 = unique(y2,'stable');
%%%
% For Google Earth GPS1Xft.mat... This captures the constant radius curve
%x2 = x2(110:180); y2 = y2(110:180); %110-180
%%%%
nu = numel(y2); x2 = x2(1:nu);
X = [x2',y2']; Li = zeros(nu,1);
for i = 2:nu
Li(i) = Li(i-1) + norm( X(i,:)-X(i-1,:) );
end
FinerSeg = min(Li):1:max(Li);
x2 = spline(Li,x2,FinerSeg); y2 = spline(Li,y2,FinerSeg); 
X = [x2',y2'];
[L,R,K] = curvature(X);

figure(1);
h = plot(x2,y2); grid on; axis equal; set(h,'marker','.');
xlabel('X Coordinate (m)'); ylabel('Y Coordinate (m)')
title('Road with Curvature Vectors')
hold on; quiver(x2',y2',K(:,1),K(:,2)); hold off  
figure(2);
h = plot(x2,y2); grid on; axis equal; set(h,'marker','.','Linewidth',3);
xlabel('X Coordinate (m)'); ylabel('Y Coordinate (m)')
title('Road with Heading Vectors')
%%%%%%-------------------------------------------------------------
% CHANGE if traveling northbound or southbound
[O1,O2] = direction(K);
%%%%%%-------------------------------------------------------------
e1 = cosd(O2); e2 = sind(O2);
hold on; quiver(x2',y2',e1,e2); hold off
figure(3)
plot(L,O1);
title('Angle of Curvature Direction');
xlabel('Segment S (m)'); ylabel('Angle of Velocity Vector (degrees)')

%  Smoothing Technique on Center Lane Angles----------------
figure(4)
x = L; y = O2;
yy1 = smooth(x,y,0.15,'rloess');  %Span of 15%
yy2 = smooth(x,y,0.15,'loess');

subplot(2,1,1)
plot(x,y,'b.',x,yy1,'r-','linewidth',1.5); grid on
%
legend('Original data','Smoothed data using ''rloess''',...
       'Location','NW')
title('Central Angle of Velocity Direction');
xlabel('Segment Length (m)'); ylabel('Tangent Vector Direction (degrees)')
subplot(2,1,2)
plot(x,y,'b.',x,yy2,'r-','linewidth',1.5); grid on
xlabel('Segment Length (m)'); ylabel('Tangent Vector Direction (degrees)')

%
legend('Original data','Smoothed Data',...
       'Location','NW')

e1 = cosd(yy2); e2 = sind(yy2);
figure(5)
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
close all
figure(6);
plot(fd_s, k_num,'b--','linewidth',1.5); hold on;
%plot(bd_s, k_num);
plot(L,k_num_C,'r--','linewidth',1.5); hold on;
%title('Derivatives Central');
hold on;
K_mag = sqrt( K(:,2).^2 + K(:,1).^2 );
plot(L,K_mag)
xlabel('Segment Length (m)'); ylabel('Curvature (m^{-1})')
%
%legend('Forward Difference','Backward Difference','Central Difference','Raw')
legend('Forward Difference','Central Difference','MDC Raw')

figure(77)
plot(L,K_mag)
xlabel('Segment Length (m)'); ylabel('Curvature (m^{-1})')

%%%%%----------------------------------------------------

% Unit Vectors in the direction of Curvature (original)
k1 = K(:,1)./K_mag;
k2 = K(:,2)./K_mag;
figure(7)
h1 = plot(x2,y2); grid on; axis equal; set(h1,'marker','.');
% Align the differentiated magnitudes
% with the direction of the original curvature
kp1 = k_num_C'.*k1; 
kp2 = k_num_C'.*k2;
hold on; quiver(x2',y2',kp1,kp2); hold off
title('Curvature Vectors with Filtered Data')



%---------------------------------------------------

figure(8);
plot(L,yy2); hold on
ylabel('Tangent Vector Angle (degrees)')
xlabel('Segment Length (m)')
yyaxis right
plot(L(1:end-1),k_num_C(1:end-1),'color','k');
hold on;
plot(L,zeros(1,N));
ylabel('Curvature (m^{-1})')
grid on
legend('Smoothed Angle','Curvature d\theta/ds','location','NW')

% %---------------------------------------------------
% 

% Detect When the Average Changes Drastically
Signal = yy2;
n = numel(Signal);  o = zeros(n,1);
% Maximum Rate of change in heading [.01,1]
threshold = .01; 
Sig1 = zeros(n,1);
Sig2 = zeros(n,1);
for i = 1:n-2
        if  abs(diff([Signal(i),Signal(i+1),Signal(i+2)])) < threshold  
          o(i) = 0;
          Sig1(i) = Signal(i);
        else  
          o(i) = 120;  
          Sig2(i) = Signal(i);
        end      
end
figure(9)
plot(L,Signal); hold on;
plot(L,o);
ylabel('Tangent Vector Angle (degrees)')
xlabel('Segment Length (m)')
legend('Data','Switch')
% %---------------------------------------------------
figure(10);

% Unit Vectors in the direction of Curvature (original)
k1 = K(:,1)./K_mag;
k2 = K(:,2)./K_mag;

h1 = plot(x2,y2); grid on; axis equal; set(h1,'marker','.');
% Align the differentiated magnitudes
% with the direction of the original curvature
ksign1 = -sign(k_num_C)'.*K(:,1).*k1; 
ksign2 = sign(k_num_C)'.*K(:,2).*k2;
hold on; quiver(x2',y2',ksign1,ksign2); hold off
title('Curvature Vectors with Filtered Data')

figure(11)

K_mag = sqrt( K(:,2).^2 + K(:,1).^2 );
Ksigned = K_mag.*sign(k_num_C)';
plot(L,Ksigned,'linewidth',1.5)
xlabel('Segment Length (m)'); ylabel('Curvature (m^{-1})')

hold on;
plot(L,k_num_C,'color','k');
ylabel('Curvature (m^{-1})')
grid on
yyaxis right
plot(L,Sig1,L,Sig2)
ylabel('Tangent Vector Angle (degrees)')
legend('MDC Raw','Curvature d\theta/ds',...
    'Straight Segment','Curved Segment','location','NW')
%%%%%%%-------------------------------------------------------------
figure(12)
K_Filter = Ksigned(Sig2~=0);
L_Filter = L(Sig2~=0);

plot(L_Filter,K_Filter,'o','color','r','linewidth',1.5); hold on; 
grid on;
plot(L,Ksigned,'-','color','b')
xlabel('Segment Length (m)'); ylabel('Curvature (m^{-1})')
% LLL = zeros(1,numel(L_Filter));
% plot(L_Filter,LLL)
yyaxis right

plot(L,Sig2,'k')
ylabel('Tangent Vector Angle (degrees)')
legend('Segmented MDC','Signed MDC','Curved Segment','location','best')

%%%%%%%-------------------------------------------------------------
% n = numel(K_Filter);
% OptRange=zeros(1,1);
% p = 1;
% for i = 1:n-2
%         if sign((K_Filter(i)).*sign(K_Filter(i+1))) ~= 1   
%           OptRange(p,:)=i;
%           p = p+1;
%         end      
% end
% a = L_Filter(1:OptRange(2));
% b = K_Filter(1:OptRange(2));
% figure
% plot(a,b)

% 
% 
% 
% 
%%%%%%%-------------------------------------------------------------






