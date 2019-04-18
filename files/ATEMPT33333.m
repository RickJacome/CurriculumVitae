clear all; clc; close all; format compact
% This Code Calculates 2 Polynomial Equations (on x, and y)
% that Minimize Square Jerk for
% Maximum Confortable Ride. Then, the derivatives are calculated and used
% to find the Curvature as a function of Time and Senet-Frenet formulae as 
% a function of time as well.
% With this Curvature Found, the Coefficients of the polynomial are found
% through boundary conditions. Then, these are used to obtain a curvature 
% that depends on time, and has coefficients that satisfy boundary
% conditions for a smooth ride. 
% Lets test it
syms Xs Vxs Axs Xe Vxe Axe Ys Vys Ays Ye Vye Aye T t
P1 = [Xs Vxs Axs Xe Vxe Axe Ys Vys Ays Ye Vye Aye T];
T = 100; %sec
Xs = 0; Ys = 0;  %m
Vxs = 20; Vys = 0;  %m/s    
Vtots = sqrt(Vxs^2 + Vys^2)
Axs = 0; Ays = 0;  %m/s^2
Xe =2000*cosd(45); Ye = 2000*sind(45);   %m
Vxe = 20*cosd(45); Vye = 20*sind(45);   %m/s
Vtote = sqrt(Vxs^2 + Vys^2)
Axe = 0; Aye = 0;   %m/s^2
% Format 
P2 = [Xs Vxs Axs Xe Vxe Axe Ys Vys Ays Ye Vye Aye T];
[Kt, Dt, Vt, At, IC0x_r, IC0y_r,XCoeff, YCoeff] = Curva()

Kt_test = subs(Kt,P1,P2);
Dt_test = subs(Dt,P1,P2);
Vt_test = subs(Vt,P1,P2);
At_test = subs(At,P1,P2);
tn = 0:1:T-1;
G = double(vpa(subs(Kt_test,t,tn)));
figure(1); plot(tn,G.^-1)
xlabel('Time (sec)'); ylabel('Radius of Curvature \rho (m)');
figure(2); plot(tn,G)
xlabel('Time (sec)'); ylabel('Curvature \kappa (m)');

Dplot = double(vpa(subs(Dt_test,t,tn)));
figure(3); plot(tn,Dplot); hold on
scatter([0 0],[Xs Ys])
xlabel('Time (sec)'); ylabel('Position (m)');
legend('x','y')
figure(10); plot(Dplot(1,:),Dplot(2,:))
xlabel('Position X (m)'); ylabel('Y Position (m)');

Vplot = double(vpa(subs(Vt_test,t,tn)));
figure(4); plot(tn,Vplot); hold on;
scatter([0 0],[Vxs Vys])
xlabel('Time (sec)'); ylabel('Velocity (m/s)');
legend('Vx','Vy')

Aplot = double(vpa(subs(At_test,t,tn)));
figure(5); plot(tn,Aplot); hold on;
scatter([0 0],[Axs Ays])
xlabel('Time (sec)'); ylabel('Acceleration (m/s)');
legend('Ax','Ay')

fun = @root2d(x,;
x0 = [0,0];
options = optimoptions('fsolve',...
    'Display','none','PlotFcn',@optimplotfirstorderopt);
xx = fsolve(fun,x0,options)

function [Kt, Dt, Vt, At, IC0x_r, IC0y_r,XCoeff, YCoeff] = Curva()
syms a0 a1 a2 a3 a4 a5 b0 b1 b2 b3 b4 b5 t
D = [a0 + a1*t + a2*t^2 + a3*t^3 + a4*t^4 + a5*t^5;...
    b0 + b1*t + b2*t^2 + b3*t^3 + b4*t^4 + b5*t^5];
V = [a1 + 2*a2*t + 3*a3*t^2 + 4*a4*t^3 + 5*a5*t^4; ...
    b1 + 2*b2*t + 3*b3*t^2 + 4*b4*t^3 + 5*b5*t^4; 0];
A = [2*a2 + 6*a3*t + 12*a4*t^2 + 20*a5*t^3; ...
    2*b2 + 6*b3*t + 12*b4*t^2 + 20*b5*t^3; 0];
magV = sqrt ( (a1 + 2*a2*t + 3*a3*t^2 + 4*a4*t^3 + 5*a5*t^4)^2  +...
(b1 + 2*b2*t + 3*b3*t^2 + 4*b4*t^3 + 5*b5*t^4)^2 );
Et = V/magV;
Et_dt = diff(Et, t);
K = cross(V,A)/(magV)^(3); %Curvature as a function of Time and 
% polynomial Coefficients
En = Et_dt/K(3);

% Let us Find all Coefficient values of a_n and b_n through
% Boundary Conditions
% Where s = start, e = exit,  T = Time for Bonudary Condition
%x(t = 0) = Xs
%xdot(t = 0) = Vxs
%x2dot(t = 0) = Axs
%x(t = T) = Xe
%xdot(t = T) = Vxe
%x2dot(t = T) = Axe
% 
%y(t = 0) = Ys
%ydot(t = 0) = Vys
%y2dot(t = 0) = Ays
%y(t = T) = Ye
%ydot(t = T) = Vye
%y2dot(t = T) = Aye

syms Xe Xs Vxe Vxs Axs Axe a3 a4 a5 T
% From 0 ICs
% a0 = Xs; a1 = Vxs;  a2 = Axs/2;
% b0 = Ys = b1 = Vys; a3 = Ays/2;
% Equations Become:
% Xe = Xs + Vxs*T + Axs*T^2/2 + a3*T^3 + a4*T^4 + a5*T^5;  
% Vxe = Vxs + Axs*T + 3*a3*T^2 + 4*a4*T^3 + 5*a5*T^4;
% Axe = Axs + 6*a3*T + 12*a4*T^2 + 20*a5*T^3; 
% This are then re-arranged into a Matrix Solvable Form
Mx = [T^3 T^4 T^5; 3*T^2 4*T^3 5*T^4; 6*T 12*T^2 20*T^3];
Hx = [Xe-Xs-Vxs*T-Axs*T^2/2; Vxe-Vxs-Axs*T; Axe-Axs];
XCoeff = (Mx)^-1*Hx;

syms Ye Ys Vye Vys Ays Aye b3 b4 b5 T
% Similar Approach from 0 ICs
% Equations Become:
% Ye = Ys + Vys*T + Ays*T^2/2 + b3*T^3 + b4*T^4 + b5*T^5;
% Vye = Vys + Ays*T + 3*b3*T^2 + 4*b4*T^3 + 5*b5*T^4;
% Aye = Ays + 6*b3*T + 12*b4*T^2 + 20*b5*T^3; 
% This are then re-arranged into a Matrix Solvable Form
My = [T^3 T^4 T^5; 3*T^2 4*T^3 5*T^4; 6*T 12*T^2 20*T^3];
Hy = [Ye-Ys-Vys*T-Ays*T^2/2; Vye-Vys-Ays*T; Aye-Ays];
YCoeff = (My)^-1*Hy; 

%Assign Coefficients to Vector for easier Substitution
IC0x = [a0; a1; a2];
Sx = [a3; a4; a5];
IC0y = [b0; b1; b2];
Sy = [b3; b4; b5];
IC0x_r = [Xs; Vxs; Axs/2];
IC0y_r = [Ys; Vys; Ays/2];
Kfunc = K(3);  % Only need the third term from the Curvature Vector
%This is just Consecutive Substitution of coefficients an and bn for its values which were already calculated
Kt = subs(Kfunc,[IC0x,IC0y,Sx,Sy],[IC0x_r, IC0y_r,XCoeff, YCoeff]); %Curvature as a function of Time and Initial conditions
% Lets also get the polynomial function with all its coefficients in terms
% of ICs
Dt = subs(D,[IC0x,IC0y,Sx,Sy],[IC0x_r, IC0y_r,XCoeff, YCoeff]);
Vt = [V(1); V(2)];
Vt = subs(Vt,[IC0x,IC0y,Sx,Sy],[IC0x_r, IC0y_r,XCoeff, YCoeff]);
At = [A(1); A(2)];
At = subs(At,[IC0x,IC0y,Sx,Sy],[IC0x_r, IC0y_r,XCoeff, YCoeff]);
end

function L = root2d(IC0x_r,XCoeff,x)
syms a0 a1 a2 a3 a4 a5 
IC0x = [a0; a1; a2];
Sx = [a3; a4; a5];
L(1) = subs(a1 + 2*a2*x(1) + 3*a3*x(1)^2 + 4*a4*x(1)^3+ 5*a5*x(1)^4 ...
    - 6*a3*x(2)-24*a4*x(1)*x(2)-60*a5*x(1)^2*x(2) ...
    ,[IC0x,Sx],[IC0x_r,XCoeff])
L(2) =  subs(2*a2* + 6*a3*x(1) + 12*a4*x(1)^2 + 20*a5*x(1)^3 - .8*9.81...
    ,[IC0x,Sx],[IC0x_r,XCoeff])
end