% Homework 4 Problem 6, part 1
clear all; clc; close all;
%Model Fitting function, nonlinear
%m_f =@(x,t) x(1).*exp(x(2).*t);
m_f = @(x,s) ((x(5)./(x(2)-x(1))).*s - x(1).*x(5)./(x(2)-x(1))).*(heaviside(s-x(1)) - heaviside(s-x(2))) +...
     x(5).*(heaviside(s-x(2))-heaviside(s-x(3))) + ...
((x(5)./(x(4)-x(3))).*-s + ( (x(3).*x(5))./(x(4) - x(3)) + x(5))).*(heaviside(s-x(3)) - heaviside(s-x(4)));

% Residual Function
%r_k=@(x,t,y)(x(1).*exp(x(2).*t)-y);
r_k = @(x,s,y) ((x(5)./(x(2)-x(1))).*s - x(1).*x(5)./(x(2)-x(1))).*(heaviside(s-x(1)) - heaviside(s-x(2))) +...
     x(5).*(heaviside(s-x(2))-heaviside(s-x(3))) + ...
((x(5)./(x(4)-x(3))).*-s + ( (x(3).*x(5))./(x(4) - x(3)) + x(5))).*(heaviside(s-x(3)) - heaviside(s-x(4)) - y);

% Gradient of Residual
%g_r=@(x,t) [exp(x(2).*t);...
%            x(1)*t.*exp(x(2).*t)];

g_r = @(x,s) [(heaviside(s - x(1)) - heaviside(s - x(2))).*(x(5)./(x(1) - x(2)) + (s.*x(5))./(x(1) - x(2)).^2 - (x(1).*x(5))./(x(1) - x(2)).^2) + dirac(s - x(2)).*((s.*x(5))./(x(1) - x(2)) - (x(1).*x(5))./(x(1) - x(2)));...
 - ((s.*x(5))./(x(1) - x(2)).^2 - (x(1).*x(5))./(x(1) - x(2)).^2).*(heaviside(s - x(1)) - heaviside(s - x(2))) - dirac(s - x(2)).*((s.*x(5))./(x(1) - x(2)) - (x(1).*x(5))./(x(1) - x(2))) - x(5).*dirac(s - x(2));...
 x(5).*dirac(s - x(3)) - (heaviside(s - x(3)) - heaviside(s - x(4))).*(x(5)./(x(3) - x(4)) + (s.*x(5))./(x(3) - x(4)).^2 - (x(3).*x(5))./(x(3) - x(4)).^2) - dirac(s - x(3)).*(x(5) + (s.*x(5))./(x(3) - x(4)) - (x(3).*x(5))./(x(3) - x(4)));...
                                          ((s.*x(5))./(x(3) - x(4)).^2 - (x(3).*x(5))./(x(3) - x(4)).^2).*(heaviside(s - x(3)) - heaviside(s - x(4))) + dirac(s - x(4)).*(x(5) + (s.*x(5))./(x(3) - x(4)) - (x(3).*x(5))./(x(3) - x(4)));...
 heaviside(s - x(2)) - heaviside(s - x(3)) - (s./(x(1) - x(2)) - x(1)./(x(1) - x(2))).*(heaviside(s - x(1)) - heaviside(s - x(2))) + (heaviside(s - x(3)) - heaviside(s - x(4))).*(s./(x(3) - x(4)) - x(3)./(x(3) - x(4)) + 1)];
         
%Data without outlier
s=[1 3 5 8 12]; y=[0 5 5 5 0];
%Starting point
x=[1 2 2.5 4.8 4.7]; %<--- Make sure you don't repeat values, or it will 
% be NaN
% IC In vector form
x_k(1,:) = x;
% From Equation 10.27 (right), J'*r can be calculated as:
b = r_k(x_k(1,:),s,y)*g_r(x_k(1,:),s)';
% QR Factorization for  J'J from Equation 10.27 (left)
[Q R]=qr(g_r(x_k(1,:),s)*g_r(x_k(1,:),s)');
p_k=-1*(R\Q'*b'); % Gaussian - Newton step
cond(Q)
cond(R)
i = 1;
% %Backtracking parameters
% alpha(i) = 1; c = 10e-6; rho = 0.7;
% % Stopping Criteria, norm of gradient
% % which is J'*r
% error(i)=norm(g_r(x,s)*r_k(x_k(i,:),s,y)',2);
% % Stop Parameters
% tol=1e-10;  maxi = 1e9;
% while error(i) > tol && i < maxi
%      xx=x_k(i,:);
%      b=r_k(xx,s,y)*g_r(xx,s)';
%      [Q R]=qr(g_r(xx,s)*g_r(xx,s)');
%      p_k=-1*(R\Q'*b'); % Gaussian - Newton step
%      alpha(i)=BackTracking(xx,s,y,c,rho,p_k,r_k,g_r);
%      x_k(i+1,:)=x_k(i,:)+(alpha(i)*p_k)';
%      i=i+1; % Update Step;
%     %Update Error
%      error(i)=norm(g_r(x_k(i,:),s)*r_k(x_k(i,:),s,y)',2);
% end
% x_min = x_k(i,:);   %Minimizer x*
% plot(s,y,'*r'); hold on; grid on
% T=(1:0.01:max(s)); yy = m_f(x_min,T);
% plot(T,yy,'b'); xlabel('t values'); ylabel('y values')
% title('Gauss-Newton for Minimization of Non-Linear Least-Squares')
% % The model obtained seems like a good model even though it does not
% % go through every point in the dataset (though, it doesn't need to).
% ex = 1;
% for k = 1:ex:numel(error)
%     T1 = k;
%     fprintf('Iteration Number\n %7d \n',T1)   
%     T2 = x_k(k); 
%     fprintf('Function Value \n %7.2f \n',T2)
%     T3 = error(k);
%     fprintf('Norm of Gradient \n %7.2f \n',T3)   
%     
%     fprintf('Met Stopping Criteria? \n')
%     if T3 > tol
%            fprintf('No\n')
%     else
%      fprintf('Yes, convergence by norm(r) >= tolerance\n') 
%     end           
% end
% 
% if maxi == i
%        fprintf('Convergence Achieved by Iterations >= Max# Iterations\n')
%        fprintf('With # of iterations: %7d \n',i)       
% else
%        fprintf('Convergence Achieved by norm(r) >= tolerance\n with ')
%        fprintf('With # of iterations: %7d \n',i)
% end
% 
% 
% 
% 
% 
% 
