clc; clear all; close all
%Parameters  -------
global Q_temp e g m
L = 2.5;
Q_vector = linspace(.5,20,10);
e = 6; 
g = 9.81; 
m = 0.4;
% ---------------------

for i=1:length(Q_vector)
    Q_temp=Q_vector(i);
%Objective Function to be optimized
fun = @(x)  x(1) - (5*L + m*x(2)^2)*Q_temp;  
%Bounds
lb = [-30,-60]; % -30 < x1 < 3;
ub = [3,60];  % -60 < x2 < 60;
% There are no linear constraints, so set those arguments to |[]|. 
A = [];  b = [];
Aeq = []; beq = [];  
%Initial Conditions
x0 = [1/4,1/4];  
 
%Constraints as an annoynomous function
nonlcon = @EqConstraint;

%Optimize Command
x(i,:) = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon); 
end
%Function that defines the Constraints
function [c,ceq] = EqConstraint(x)
global Q_temp e g m

c =  x(2)^2*Q_temp/g - (m+e);
ceq = [];
end