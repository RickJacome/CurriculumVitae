clc; clear all; close all
Input = 30;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%GPS DATA
%load('CVF9LatX.mat'); load('CVF9LongY.mat');
%Ideal AASHTO
load('MichXm.mat'); load('MichYm.mat');
%x2 = LatX'; y2 = LongY';   
x2 = xm'; y2 = ym';
x2 = unique(x2); y2 = unique(y2);
x2 = x2(1:numel(y2));
t = linspace(0,25,numel(x2));
%figure; plot(t,x2); title('x Ideal')
%figure; plot(t,y2); title('y Ideal')
x2 = awgn(x2,Input,'measured');
figure; plot(t,x2); title('x Noise')
y2 = awgn(y2,Input,'measured');
figure; plot(t,y2); title('y Noise')

X = [x2',y2'];
[L,R,K] = curvature(X);
K(1,:) = []; K(end,:) = []; L(1,:) = []; L(end,:) = [];
x2(1) = []; x2(end) = []; y2(1) = []; y2(end) = [];
%figure; scatter(x2,y2);
%xlabel('X Coordinate (m)'); ylabel('Y Coordinate (m)')
%title('Raw Road Data')
figure;
h = scatter(x2,y2); grid on; axis equal; set(h,'marker','.');
xlabel('X Coordinate (m)'); ylabel('Y Coordinate (m)')
title('Road with Curvature Vectors')
hold on

quiver(x2',y2',K(:,1),K(:,2)); hold off  
y = sqrt(K(:,1).^2 + K(:,2).^2);
s = L;
figure; plot(s,y)


% Initial Conditions, NEVER repeat them.
x0 = [100 200 300 400 500];
% Curvature Model M.1
M1 = @(x,s) ((x(5)./(x(2)-x(1))).*(s - x(1))).*(heaviside(s-x(1)) - heaviside(s-x(2))) +...
     x(5).*(heaviside(s-x(2))-heaviside(s-x(3))) + ...
( ( x(5)./(x(4)-x(3))).*(-s+x(3))+ x(5) ).*(heaviside(s-x(3)) - heaviside(s-x(4))); 
% Pr.1
fprintf('Pr. 1, Least Squares Min. Has finalized');
options = optimset('Display','off');
x = lsqcurvefit(M1,x0,s(1:end),y,[],[],options)
snew = linspace(s(1),s(end),100); % <--- This defines the 
% size of the "K_vector".
figure; hold on; 
plot(s,y,'bo');
xlabel('S-Segment (m)'); ylabel ('Curvature(m^{-1})');
plot(snew,M1(x,snew),'k-','linewidth',2);
xlim([snew(1), snew(end)+5]);
legend('Data','Fitted Response','location','best'); 
title('Data and Fitted Curve'); grid on
