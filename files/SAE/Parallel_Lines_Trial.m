%HERE I am trying to create the Filter of the Centerlines 
clear; close all; clc
%Google Earth Data
load('GPS1Xft.mat'); load('GPS1Yft.mat');
x2 = GPSX; y2 = GPSY;
x2 = x2'*3.281; y2 = y2'*3.281;
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
K(1,:) = []; K(end,:) = []; L(1,:) = []; L(end,:) = [];
xlabel('Length of Road'); ylabel('Radius \rho')
figure(1);
x2(1) = []; x2(end) = []; y2(1) = []; y2(end) = [];
h = plot(x2,y2); grid on; axis equal; set(h,'marker','.');
xlabel('X Coordinate'); ylabel('Y Coordinate')
title('Road with Curvature Vectors')
hold on; quiver(x2',y2',K(:,1),K(:,2)); hold off  
figure(2);
h = plot(x2,y2); grid on; axis equal; set(h,'marker','.','Linewidth',3);
xlabel('X Coordinate'); ylabel('Y Coordinate')
title('Road with Heading Vectors no parallism yet')
[O1,O2] = direction(K);
e1 = cosd(O2); e2 = sind(O2);
hold on; quiver(x2',y2',e1,e2); hold off

% Plot all lanes together
d=1000;
make_plot=1;
flag1=0;
[x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curve(x2, y2, d, make_plot, flag1);
title('All Lanes')
% Inner Lane Data
Data_Inner = [x_inner y_inner];
[~,~,K_Inner] = curvature(Data_Inner);
[O1,O2] = direction(K_Inner);
e1 = cosd(O2); e2 = sind(O2);
figure(4);
hold on; h1 = plot(x_inner,y_inner); grid on; axis equal; set(h1,'marker','.','Linewidth',3);
quiver(x_inner,y_inner,e1,e2); hold off
title('Inner Lane')
xlabel('X Coordinate (m)'); ylabel('Y Coordinate (m)');
% Outer Lane Data
Data_Outer = [x_outer y_outer];
[~,~,K_Outer] = curvature(Data_Outer);
[O1,O2] = direction(K_Outer);
e1 = cosd(O2); e2 = sind(O2);
figure(4);
hold on; h1 = plot(x_outer,y_outer); grid on; axis equal; set(h1,'marker','.','Linewidth',3);
quiver(x_outer,y_outer,e1,e2); hold off
title('Outer Lane')
xlabel('X Coordinate (m)'); ylabel('Y Coordinate (m)');

close all
%% %Here I am investigating how both Inner and Outer lanes behave
% so that I can smooth them both and create a single centerline from both
% This should be representative of what could happen after obtaining 
% two "lane recognized" sets of data representing edge roads
figure; hold on; axis equal;
plot(x_inner,y_inner,'Linewidth',3);
plot(x_outer,y_outer,'Linewidth',3);
title('Inner and Outer Lanes')


Data_Inner = [x_inner y_inner];
[L2,~,K_Inner] = curvature(Data_Inner);
[~,O2] = direction(K_Inner);
figure; subplot(2,1,1); plot(L2,O2)
xlabel('Segment S (m)'); ylabel('Angle of Velocity Vector')
title('Clean Inner Angle of Velocity Direction');
%e1 = cosd(O2); e2 = sind(O2);

Data_Outer = [x_outer y_outer];
[L2,~,K_Outer] = curvature(Data_Outer);
[~,O2] = direction(K_Outer);
subplot(2,1,2); plot(L2,O2)
xlabel('Segment S (m)'); ylabel('Angle of Velocity Vector')
title('Clean Outer Angle of Velocity Direction');
%e1 = cosd(O2); e2 = sind(O2);

%%
% Now lets add some random noise:
figure; hold on; axis equal; title('Inner and Outer Lanes Noisy')
y_inner_noisy = awgn(y_inner,120,'measured');
plot(x_inner,y_inner_noisy,'Linewidth',3);
y_outer_noisy = awgn(y_outer,120,'measured');
plot(x_outer,y_outer_noisy,'Linewidth',3);

% Inner Noisy Angle --------------------------------------------

Data_Inner_noisy = [x_inner y_inner_noisy];
[L2,~,K_Inner_noisy] = curvature(Data_Inner_noisy);
[~,O2_noisy] = direction(K_Inner_noisy);
figure; plot(L2,O2_noisy)
xlabel('Segment S (m)'); ylabel('Angle of Velocity Vector')
title('Noisy Inner Angle of Velocity Direction');

%  Smoothing Technique on Inner Angles----------------
figure
x = L2; y = O2_noisy;
yy1 = smooth(x,y,0.15,'loess');  %Span of 15%
yy2 = smooth(x,y,0.15,'rloess');
subplot(2,1,1)
plot(x,y,'b.',x,yy1,'r-')
legend('Original data','Smoothed data using ''loess''',...
       'Location','NW')
title('Noisy Outer Angle of Velocity Direction');
xlabel('Segment S (m)'); ylabel('Angle of Velocity Vector')
subplot(2,1,2)
plot(x,y,'b.',x,yy2,'r-'); grid on
xlabel('Segment S (m)'); ylabel('Angle of Velocity Vector')
legend('Original data','Smoothed Data',...
       'Location','NW')
%-----------------      
e1 = cosd(yy2); e2 = sind(yy2);
figure
h1 = plot(x_inner,y_inner_noisy); grid on; axis equal; set(h1,'marker','.');
hold on; quiver(x_inner,y_inner_noisy,e1,e2); hold off
%title('Road with Velocity Vectors')
xlabel('X Coordinate (m)'); ylabel('Y Coordinate (m)');


k_num = diff(yy2)./diff(L2);
fd_s = L2(1:length(L2)-1);
bd_s = L2(2:length(L2));
figure;
plot(fd_s, k_num); hold on;
plot(bd_s, k_num);
title('Derivatives Inner');
hold on;
K_Inner_noisy_mag = sqrt( K_Inner_noisy(:,1).^2 + K_Inner_noisy(:,2).^2 );
plot(L2,K_Inner_noisy_mag)
xlabel('Segment Length (m)'); ylabel('Curvature (m^{-1})')
legend('Forward Difference','Backward Difference','Raw')


% Outer Noisy Angle -----------------------------------------------

Data_Outer_noisy = [x_outer y_outer_noisy];
[L2,~,K_Outer_noisy] = curvature(Data_Outer_noisy);
[~,O2_noisy] = direction(K_Outer_noisy);
figure; plot(L2,O2_noisy)
xlabel('Segment S (m)'); ylabel('Angle of Velocity Vector')
title('Noisy Outer Angle of Velocity Direction');


%  Smoothing Technique on Outer Angles----------------
figure
x = L2; y = O2_noisy;
yy1 = smooth(x,y,0.15,'loess');  %Span of 15%
yy2 = smooth(x,y,0.15,'rloess');
subplot(2,1,1)
plot(x,y,'b.',x,yy1,'r-')
legend('Original data','Smoothed data using ''loess''',...
       'Location','NW')
title('Noisy Outer Angle of Velocity Direction');
xlabel('Segment S (m)'); ylabel('Angle of Velocity Vector')
subplot(2,1,2)
plot(x,y,'b.',x,yy2,'r-'); grid on
xlabel('Segment S (m)'); ylabel('Angle of Velocity Vector')
legend('Original data','Smoothed Data',...
       'Location','NW')
%-----------------   
e1 = cosd(yy2); e2 = sind(yy2);
figure
h1 = plot(x_outer,y_outer_noisy); grid on; axis equal; set(h1,'marker','.');
hold on; quiver(x_outer,y_outer_noisy,e1,e2); hold off
%title('Road with Velocity Vectors')
xlabel('X Coordinate (m)'); ylabel('Y Coordinate (m)'); 
 
k_num = diff(yy2)./diff(L2);
fd_s = L2(1:length(L2)-1);
bd_s = L2(2:length(L2));
figure;
plot(fd_s, k_num); hold on;
plot(bd_s, k_num);
title('Derivatives Outer');
hold on;
K_Outer_noisy_mag = sqrt( K_Outer_noisy(:,1).^2 + K_Outer_noisy(:,2).^2 );
plot(L2,K_Outer_noisy_mag)
xlabel('Segment Length (m)'); ylabel('Curvature (m^{-1})')
legend('Forward Difference','Backward Difference','Raw')





%%











