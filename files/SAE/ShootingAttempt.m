clc; clear all;



[x,y] = shooting;
figure; hold on;
plot(y(:,1),x,'k-','Linewidth',2)
plot(y(:,2),x,'r-','Linewidth',2)
plot(y(:,3),x,'b-','Linewidth',2)

%% Supplementary Functions

function [x,y] = shooting
% Use fsolve to ensure the boundary function is zero. The result is the
% unknown initial condition.
opt = optimset('Display','off','TolFun',1E-20);
F = fsolve(@(F) eval_boundary(F),[0,0,0.33],opt);

% Solve the ODE-IVP with the converged initial condition
[x,y] = solve_ode(F);
end

function x_prime = SystemOdeKC(~,x)
C = 3e-3;
x_prime =[x(3);x(4);-(C.^2)*x(1);-(C.^2)*x(2)];  
end

function [x,y] = solve_ode(F)
% Solve the ODE-IVP with initial condition F on [0 100] (arbitrary upper
% bound)
[x,y] = ode45(@SystemOdeKL,[0 10],F); %solve BVP                
end

function [g] = eval_boundary(F)
% Get the solution to the ODE with inital condition F
[x,y] = solve_ode(F);

% Get the function values (for BCs) at the starting/end points
f_start = y(1,1); %f(0) = 0
df_start = y(1,2); %f'(0) = 0
df_end = y(end,2); %f'(inf) - 1 = 0

% Evaluate the boundary function
g = [f_start
     df_start
     df_end - 1];
end
