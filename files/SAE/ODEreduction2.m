close all; clear all; clc
k0 = .2;
C0 = .1;
s_span = [0 1];
ICs = [0; 0; 1; 1];
[s,x] = ode45(@(s,x) r1ODE(s,x,k0,C0),s_span,ICs);

plot(s,x(:,1),'-o',s,x(:,2),'-o'); hold on
plot(s,x(:,3),'-o',s,x(:,4),'-o'); hold on
title('Solution of the 4th Order SF ODE with ODE45');
xlabel('Segment Lenght s');
ylabel('Solution r');
legend('r_1','r_2','r_3','r_4')




 clear all; clc
k0 = .2;
C0 = .1;
k1 = .3;
s_span = [0 1];
ICs = [0; 0; 1; 1];
[s,x] = ode45(@(s,x) r2ODE(s,x,k0,k1,C0),s_span,ICs);

figure
plot(s,x(:,1),'-o',s,x(:,2),'-o'); hold on
plot(s,x(:,3),'-o',s,x(:,4),'-o'); hold on
title('Solution of the 4th Order SF ODE with ODE45');
xlabel('Segment Lenght s');
ylabel('Solution r');
legend('r_1','r_2','r_3','r_4')



function dydt = r1ODE(s,x,k0,C0)

dydt = [x(2); x(3); x(4); -k0.^2.*x(3)-k0.*(k0.*s+C0).^2.*x(1)];
end



function dydt = r2ODE(s,x,k0,k1,C0)

dydt = [x(2); x(3); x(4); ...
    -(k0*s+k1).^2.*x(3)-((k0*s+k1)).*(3*k0+(C0/(k0*s+k1).^2).^2  ).*x(1)];
end
