clear all; clc; close all
% Computes data for a parabola as a parameterized curve.
% The parameter is t, must be defined outside this script
%  with, for example, t=linspace(-1,1); (you decide the limits)
% or t=linspace(-1,1,10000) if you want LOTS of points close together.
s=linspace(-10,10); 
x=5*sin(s);        % x=t and y=t^2 are the coordinates of
y=3*cos(s);     % points on the curve.  t is a parameter along the curve.
x1=5*cos(s);    % first derivative of x(t) -- the constant function 1
y1=-3*sin(s);             % first derivative of y(t) -- the function 2t
x2=-5*sin(s);  % second derivative of x(t) -- the constant function 0
y2=-3*cos(s); % second derivative of y(t) -- the constant function 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% the code below can be used for any curve, not just the parabola

Nx=-y1./sqrt(x1.*x1+y1.*y1);   %x component of unit normal vector
Ny=x1./sqrt(x1.*x1+y1.*y1);    %y component of unit normal vector
K=(y2.*x1-x2.*y1)./(sqrt(x1.*x1+y1.*y1)).^3; %curvature
plot(x,y) % plot the curve
figure(gcf) %bring figure window to the top

% 
% 
% N=length(s);
% tcircle=round(N*.8);
% rcircle=1/K(tcircle);
% xcircle=x(tcircle)+rcircle*Nx(tcircle);
% ycircle=y(tcircle)+rcircle*Ny(tcircle);
% hold on
% v=linspace(0,2*pi);
% plot(xcircle+rcircle*cos(v),ycircle+rcircle*sin(v),'m')
% v=0:1;
% plot(x(tcircle)+v*rcircle*Nx(tcircle),y(tcircle)+v*rcircle*Ny(tcircle),'m')
% plot(x(tcircle),y(tcircle),'b.')
% text(x(tcircle)+0.2,y(tcircle),'P')
% figure(gcf)
% hold off

% Computes and plots the evolute of a curve previously computed
hold on         % will plot on top of current graph
xe=x+Nx./K;      % find points on the evolute, x coordinate (K is curvature)
ye=y+Ny./K;      % find points on the evolute, y coordinate: (Nx,Ny) is unit normal
plot(xe,ye,'c') % plot evolute in cyan
hold off
figure(gcf)     % get-current-figure and bring to top



