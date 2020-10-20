close all

s0 = [.1;.1;.05;-.05];
s_range = [0,1]; % Segment Length total is dependent on A, and B
[s,x]=ode45(@SystemOdeKC,s_range,s0);
plot(s,x(:,1),'*'); hold on;
plot(s,x(:,2),'--')
title('Unit Vectors - \kappa = C'); legend('e_t','e_n')


[s,x]=ode45(@SystemOdeKL,s_range,s0);
figure
plot(s,x(:,1),'*'); hold on;
plot(s,x(:,2),'--')
title('Unit Vectors - \kappa = As+B'); legend('e_t','e_n')


function x_prime = SystemOdeKL(s,x)
A = 3e-3;
B = 2e-1;
x_prime =[x(3);x(4);-(A.*s+B).^2*x(1)+A*x(2); -A*x(1)-(A.*s+B).^2*x(2)];  
end

function x_prime = SystemOdeKC(s,x)
C = 3e-3;
x_prime =[x(3);x(4);-(C.^2)*x(1);-(C.^2)*x(2)];  
end
