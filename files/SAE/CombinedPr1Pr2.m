clc; clear all; close all
% This model implements both Pr. 1 and Pr. 2 in one matlab script
% however, both of the problems are independent (for now).
% Results coincide with AMPL optimization;
s = 1:.01:25; n = numel(s)-1;
y1 = (2.*s(1:n/2) - 3)*1e-3;
y2 = 26*ones(1,n/2)*1e-3;

y1o = awgn(y1,25,'measured'); y2o = awgn(y2,25,'measured');

y = [y1o y2o];
x0 = [0.9 2.9 4.89 7.85 11.50];

M1 = @(x,s) ((x(5)./(x(2)-x(1))).*(s - x(1))).*(heaviside(s-x(1)) - heaviside(s-x(2))) +...
     x(5).*(heaviside(s-x(2))-heaviside(s-x(3))) + ...
( ( x(5)./(x(4)-x(3))).*(-s+x(3))+ x(5) ).*(heaviside(s-x(3)) - heaviside(s-x(4))); 

x = lsqcurvefit(M1,x0,s(1:end-1),y)
times = linspace(s(1),s(end-1),1000); % <--- This defines the 
% size of the "K_vector".
figure; hold on; 
plot(s(1:end-1),y,'bo');
plot(times,M1(x,times),'k-','linewidth',2);
xlim([times(1), times(end)+5]);
legend('Data','Fitted Response','location','best'); 
title('Data and Fitted Curve'); grid on

% -------------------------
%Parameters 
global K_temp e g mu U
L = 2.5; 
K_vector = M1(x,times);
%K_vector = 0.0167;
U = 1.95; g = 9.81;  e = 6; mu = 0.4;
% -------------------------
for i = 1:length(K_vector)
K_temp = K_vector(i);  
% Objective Function 
fun = @(x)  x(1) - (53.7*L + U*x(2)^2/g)*K_temp;    
lb = [-3,0]; % -3 < x1 < 3;
ub = [3,60];  % 0 < x2 < 60;
% There are no linear constraints, so set those arguments to |[]|. 
A = [];  b = [];
Aeq = []; beq = [];  
%Initial Conditions
x0 = [1/4,1/4];  
%Constraints as an annoynomous function
nonlcon = @EqConstraint;


Op(i,:) = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon);  
end
figure; plot(Op(:,2))
title('Velocity Optimized'); grid on
function [c,ceq] = EqConstraint(x)
global K_temp e g mu 
c = x(2)^2*K_temp/g - (mu + 0.01*e)/(1-0.01*mu*e);
ceq = [];
end

