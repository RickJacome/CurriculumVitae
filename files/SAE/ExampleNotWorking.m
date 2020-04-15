clc; clear all; close all

% THIS CODE DOESNT WORK.
%Now lets imagine I want to do this code, and optimize an x(1), x(2), x(n)
% For the following Q

s = 1:.01:500; n = numel(s)-1;
q = 2.*s(1:n/2) - 1;

Q = awgn(q,25,'measured');



%Parameters  -------
L = 2.5;
e = 6; g = 9.81; m = 0.4;
% ---------------------

%Now I want to loop all Q's here...

 for i = 1:n


%Objective Function to be optimized
fun = @(x)  x(1) - (5*L + m*x(2)^2)*Q(i);  
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

 end

%Function that defines the Constraints
function [c,ceq] = EqConstraint(x)
%Now, here there no Q defined....
 %Nor parameters...

c =  x(2)^2*Q(i)/g - (m+e);
ceq = [];
end