close all; clear all; clc
k0 = 1e-3;
C0 = 0;
% C0 = Tau0 - k0*S0; %Zero Initial Torsion
s_span = [0 1000];
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
    r = x(:,1);
    A{:,i} = r;
    plot(s,r,'-o','Color',c); hold on
    end
    B{n} = A;
end
title('Solution of 4th Order SF ODE \forall \kappa (s)\in C^1(s)');
xlabel('Segment Lenght s'); ylabel('Solution r'); grid on;
legend('r_1 e_t','r_1 e_n','r_1 e_b','location','best')

r11 = B{1,2}{1,1};
r22 = B{1,2}{1,2};
r33 = B{1,2}{1,3};
s = linspace(0,s_span(end),numel(r11));
xx = 0:.1:s_span(end);
yr11 = spline(s,r11,xx);
s = linspace(0,s_span(end),numel(r22));
xx = 0:.1:s_span(end);
yr22 = spline(s,r22,xx);
s = linspace(0,s_span(end),numel(r33));
xx = 0:.1:s_span(end);
yr33 = spline(s,r33,xx);
figure(2)
plot3(yr11,yr22,yr33,'o')



%-------------------------------------

k0 = .2;
C0 = 0;
k1 = 0.1;
% C0 = Tau0*(k0*S0 + k1).^2; %Zero Initial Torsion

s_span = [0 1000];
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
    figure(3)
    r = x(:,1);
    M{:,i} = r;
    plot(s,r,'-o','Color',c); hold on
    end
    N{n} = M;
end
title('Solution of 4th Order SF ODE \forall \kappa (s)\in C^2(s)');
xlabel('Segment Lenght s'); ylabel('Solution r'); grid on;
legend('r_1 e_t','r_1 e_n','r_1 e_b','location','best')


r11 = N{1,2}{1,1};
r22 = N{1,2}{1,2};
r33 = N{1,2}{1,3};
s = linspace(0,s_span(end),numel(r11));
xx = 0:.1:s_span(end);
yr11 = spline(s,r11,xx);
s = linspace(0,s_span(end),numel(r22));
xx = 0:.1:s_span(end);
yr22 = spline(s,r22,xx);
s = linspace(0,s_span(end),numel(r33));
xx = 0:.1:s_span(end);
yr33 = spline(s,r33,xx);
figure(4)
plot3(yr11,yr22,yr33,'o')




function dydt = r1ODE(s,x,k0,C0)
    dydt = [x(2); x(3); x(4); -k0.^2.*x(3)-k0.*(k0.*s+C0).^2.*x(1)];
end

function dydt = r2ODE(s,x,k0,k1,C0)
dydt = [x(2); x(3); x(4); ...
    -(k0*s+k1).^2.*x(3)-((k0*s+k1)).*(3*k0+(C0/(k0*s+k1).^2).^2  ).*x(1)];
end