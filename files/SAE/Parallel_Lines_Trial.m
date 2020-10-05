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
K(1,:) = []; K(end,:) = [];
L(1,:) = []; L(end,:) = [];
xlabel('Length of Road'); ylabel('Radius \rho')
figure(1);
x2(1) = []; x2(end) = [];
y2(1) = []; y2(end) = [];
h = plot(x2,y2); grid on; axis equal; set(h,'marker','.');
xlabel('X Coordinate'); ylabel('Y Coordinate')
title('Road with Curvature Vectors')
hold on
quiver(x2',y2',K(:,1),K(:,2)); hold off  
% Less accuracy
Lessx2 = x2(1:20:end);
Lessy2 = y2(1:20:end);
LessK1 = K(:,1); 
LessK1 = LessK1(1:20:end);
LessK2 = K(:,2);
LessK2 = LessK2(1:20:end);
figure;
plot(Lessx2,Lessy2); hold on
quiver(Lessx2',Lessy2',LessK1,LessK2);  axis equal;
title('Curvature Vectors with Less Accuracy')
xlabel('X Coordinate'); ylabel('Y Coordinate')
% ------------
y = sqrt(K(:,1).^2 + K(:,2).^2);
s = L;
%----
K = [LessK1 LessK2]; 
[O1,O2] = direction(K);
e1 = cosd(O2); e2 = sind(O2);
figure(200); h1 = plot(Lessx2,Lessy2); grid on; axis equal; set(h1,'marker','.','Linewidth',3);
hold on; quiver(Lessx2',Lessy2',e1,e2); hold off
%title('Road with Velocity Vectors')
title('Tangent Vectors with Less Accuracy')
xlabel('X Coordinate (m)'); ylabel('Y Coordinate (m)');
%-------
d=1000;
make_plot=1;
flag1=0;
%[x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curve(x2, y2, d, make_plot, flag1);
%-------

[x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curve(Lessx2, Lessy2, d, make_plot, flag1);
Data_Inner = [x_inner y_inner];
[~,~,K_Inner] = curvature(Data_Inner);
figure(3); title('Parallel Lines')
[O1,O2] = direction(K_Inner);
e1 = cosd(O2); e2 = sind(O2);
figure(200);hold on; h1 = plot(x_inner,y_inner); grid on; axis equal; set(h1,'marker','.','Linewidth',3);
quiver(x_inner,y_inner,-e1,-e2); hold off
%title('Road with Velocity Vectors')
xlabel('X Coordinate (m)'); ylabel('Y Coordinate (m)');

