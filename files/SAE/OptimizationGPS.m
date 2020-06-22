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
% ------------
y = sqrt(K(:,1).^2 + K(:,2).^2);
s = L;
%-------
d=200;
make_plot=1;
flag1=0;
[x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curve(x2, y2, d, make_plot, flag1);
%-------

Data_Inner = [x_inner y_inner];
[~,~,K_Inner] = curvature(Data_Inner);

[O1,O2] = direction(K_Inner);
e1 = cosd(O2); e2 = sind(O2);
figure(200);hold on; h1 = plot(x_inner,y_inner); grid on; axis equal; set(h1,'marker','.','Linewidth',3);
quiver(x_inner,y_inner,e1,e2); hold off
%title('Road with Velocity Vectors')
xlabel('X Coordinate (m)'); ylabel('Y Coordinate (m)');


%---------
%From this point forward, I am doing the Optimization Dynamic Routine
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
plot(snew,M1(x,snew),'k-','linewidth',2);
xlim([snew(1), snew(end)+5]);
legend('Data','Fitted Response','location','best'); 
title('Data and Fitted Curve'); grid on

% -------------------------
%Parameters 
global K_temp e g mu U
% Vehicle Only
L = 2.5;  %U = 1.95;
U = 3;
% Road Only
%e = 12; mu = 0.4;
e = 6; mu = 0.3;
% Both
g = 9.81; K_vector = M1(x,snew);
% -------------------------
%Iterative Optimization Routine for Pr.2 given Optimized M.1
for i = 1:length(K_vector)
K_temp = K_vector(i);  
% Objective Function Pr.2
fun = @(x)  x(1) - (53.7*L + U*x(2)^2/g)*K_temp;    
%C.1 (Bounds)
lb = [-3,25]; % -3 < x1 < 3;
%ub = [30,35];
ub = [30,60];  % 60 < x2 < 80; mph
% There are no linear constraints, so set those arguments to |[]|. 
A = [];  b = []; % Linear In-equality Constraints
Aeq = []; beq = [];  % Linear Equality Constraints
%Initial Conditions
x0 = [1/4,1/4];  
%Constraints as an annoynomous function
nonlcon = @EqConstraint;
options = optimoptions('fmincon','Display','off');
Op(i,:) = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);  
end
fprintf('Pr. 2 Has finalized \n');
figure; plot(snew,Op(:,2))
title('Segment Length vs Velocity Optimized'); grid on
figure; plot(M1(x,snew),Op(:,2))
title('Curvature vs Velocity Optimized'); grid on

% Nonlinear Constaints (Not bounds)
function [c,ceq] = EqConstraint(x)
global K_temp e g mu 
%Pr.2
% Nonlinear Inequality Constraints
c = x(2)^2*K_temp/g - (mu + 0.01*e)/(1-0.01*mu*e);
% Nonlinear Equality Constraints
ceq = [];
end


