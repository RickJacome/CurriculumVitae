close all; clear all; clc
k0 = .2;
C0 = .1;
s_span = [0 5];
for n=1:2
    c = rand(1,3);
    for i = 1:3
     % Index i changes the unit vector
     % The Number of ICs comes from the 4th order Equation
     % The 4th Order Equation has three independent components,
     % Thus, 12 ICs are needed. 
     %Random ICs
    IC1 = 0;
    IC2 = .5*rand;
    IC3 = .7*rand;
    IC4 = .1*rand;
    ICs = [IC1; IC2; IC3; IC4];
    [s,x] = ode45(@(s,x) r1ODE(s,x,k0,C0),s_span,ICs);
    figure(1)
    plot(s,x(:,1),'-o','Color',c); hold on
    end

end

title('Solution of 4th Order SF ODE \forall \kappa (s)\in C^1(s)');
xlabel('Segment Lenght s'); ylabel('Solution r'); grid on;
legend('r_1 e_t','r_1 e_n','r_1 e_b','location','best')
%-------------------------------------

clear all; clc
k0 = .2;
C0 = .1;
k1 = .3;
s_span = [0 5];
for n = 1:2
      c = rand(1,3);
    for i = 1:3
     % Index i changes the unit vector
     % The Number of ICs comes from the 4th order Equation
     % The 4th Order Equation has three independent components,
     % Thus, 12 ICs are needed. 
     %Random ICs
    IC1 = 0;
    IC2 = .5*rand;
    IC3 = .7*rand;
    IC4 = .1*rand;
    ICs = [IC1; IC2; IC3; IC4];
    [s,x] = ode45(@(s,x) r2ODE(s,x,k0,k1,C0),s_span,ICs);
    figure(2)
    plot(s,x(:,1),'-o','Color',c); hold on
    end

end
title('Solution of 4th Order SF ODE \forall \kappa (s)\in C^2(s)');
xlabel('Segment Lenght s'); ylabel('Solution r'); grid on;
legend('r_1 e_t','r_1 e_n','r_1 e_b','location','best')


function dydt = r1ODE(s,x,k0,C0)

dydt = [x(2); x(3); x(4); -k0.^2.*x(3)-k0.*(k0.*s+C0).^2.*x(1)];
end

function dydt = r2ODE(s,x,k0,k1,C0)

dydt = [x(2); x(3); x(4); ...
    -(k0*s+k1).^2.*x(3)-((k0*s+k1)).*(3*k0+(C0/(k0*s+k1).^2).^2  ).*x(1)];
end