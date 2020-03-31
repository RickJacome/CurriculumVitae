clear; close all; clc
load('CVF9LatX.mat'); load('CVF9LongY.mat')
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
xlabel('Length of Road'); ylabel('Radius \rho')
figure(2);
h = plot(x2,y2); grid on; axis equal; set(h,'marker','.');
xlabel('X Coordinate'); ylabel('Y Coordinate')
title('Road with Curvature Vectors')
hold on
quiver(x2',y2',K2(:,1),K2(:,2)); hold off  
% A = optimvar('A',3);  %  
% x(1) = []; x(end) = [];
% 
% %fun = @(A) A(1)+A(2).*x;
% %fun =  @(A) A(1)+A(2).*x + A(3).*x.^2 + A(4).*x.^3;
% fun = @(A) A(1).*x.^4 + A(2).*x.^2 + A(3);
% %fun = @(A) A(1).*x.^5 + A(2).*x.^3 + A(3).*x;
% 
% response = fcn2optimexpr(fun,A,'OutputSize',...
%     [218,1],'ReuseEvaluation',true);
% yy2(1) = []; yy2(end) = [];
% x0.A = [0.25,1,.25];%,3.2];
% 
% obj = sum( (response - yy2).^2 );
% lsqproblem = optimproblem("Objective",obj);
% [sol,fval] = solve(lsqproblem,x0);
% 
% figure(1052)
% responsedata = evaluate(response,sol);
% plot(x,yy2,'r*',x,responsedata,'b-')
% legend('Original Data','Fitted Curve')
% xlabel 'Segment S'
% ylabel 'Curvature Kappa'
% title("Fitted Response")