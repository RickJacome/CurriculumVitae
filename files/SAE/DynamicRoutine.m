%%%%---------------------------------------------
% 11-10-2020

% External files used: curvature.m direction.m
%%%_---------------------------------------------
clear; close all; clc
load('OptimK.mat'); load('OptimS.mat')

% ------------
y = b;
s = a;
y(isnan(y)) = 0;
s(isnan(s)) = 0;

%------
figure; plot(s,y); grid on;
xlabel('Segment Length s (m)'); ylabel('Curvature \kappa (m^{-1})')
%---------------------------------------------------------------
%From this point forward, I am doing the Optimization Semi-Dynamic Routine
% Initial Conditions, NEVER repeat them.
x0 = [s(1) 0.75*mean(s) 1.25*mean(s) s(end) max(y)]
%x0 = [1.25*sSmoo(1) mean(sSmoo) 1.25*mean(sSmoo) .75*sSmoo(end) max(ySmoo)]
%Note: Every single time, the x0 need ot be modified to achieve the right
%form
% Curvature Model M.1
M1 = @(x,s) ((x(5)./(x(2)-x(1))).*(s - x(1))).*(heaviside(s-x(1)) - heaviside(s-x(2))) +...
     x(5).*(heaviside(s-x(2))-heaviside(s-x(3))) + ...
( ( x(5)./(x(4)-x(3))).*(-s+x(3))+ x(5) ).*(heaviside(s-x(3)) - heaviside(s-x(4))); 
% Pr.1
fprintf('Pr. 1, Least Squares Min. Has finalized');
options = optimset('Display','off');


x = lsqcurvefit(M1,x0,s,y,[],[],options)
snew = linspace(s(1),s(end),100); % <--- This defines the 
% size of the "K_vector".
figure; hold on; 
plot(s,y,'bo');
plot(snew,M1(x,snew),'k-','linewidth',2);
xlim([snew(1), snew(end)+5]);
xlabel('Segment Length s (m)'); ylabel('Curvature \kappa (m^{-1})')
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
ub = [3,36];  % 60 < x2 < 80; mph
% There are no linear constraints, so set those arguments to |[]|. 
A = [];  b = []; % Linear In-equality Constraints
Aeq = []; beq = [];  % Linear Equality Constraints
%Initial Conditions
x0 = [1/4,1/2];  
%Constraints as an annoynomous function
nonlcon = @EqConstraint;
options = optimoptions('fmincon','Display','off');
Op(i,:) = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);  
end
fprintf('Pr. 2 Has finalized \n');
figure; plot(snew,Op(:,2))
%title('Segment Length vs Velocity Optimized');
grid on
xlabel('Segment Length s (m)'); ylabel('Optimized Velocity (m/s)') 
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


