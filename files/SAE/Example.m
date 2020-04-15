clc; clear all; close all
% This model works, for "Q" , but i have to do it for more than
% 1 million different Qs (Which I am doing
% through a loop). Thus, I am trying to change the 
% constraint equations (lines 26 - 30) through an iterative process.
% You can also change Q manually, and never finish. 
% This same idea (for Q) I would like to implement it to all 
% parameters below, but, they will only change as User input (i.e. no
% need to change variable, m, e,L, a million times, just every time,)
%Parameters  -------
L = 2.5; Q = 2; 
e = 6; g = 9.81; m = 0.4;
% ---------------------


%Objective Function to be optimized
fun = @(x)  x(1) - (5*L + m*x(2)^2)*Q;  
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
x = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon)   

%Function that defines the Constraints
function [c,ceq] = EqConstraint(x)
% As you saw before, I had to re-type all this consntant values
% in order this code to work. I DONT want to do this. 
Q = 2; 
e = 6; g = 9.81; m = 0.4;

c =  x(2)^2*Q/g - (m+e);
ceq = [];
end