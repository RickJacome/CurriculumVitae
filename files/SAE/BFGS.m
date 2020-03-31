% BFGS Method Solver 
clc; clear; close all
syms s
f = @(x) ((x(5)/(x(2)-x(1)))*s - x(1)*x(5)/(x(2)-x(1)))*(heaviside(s-x(1)) - heaviside(s-x(2))) +...
     x(5)*(heaviside(s-x(2))-heaviside(s-x(3))) + ...
((x(5)/(x(4)-x(3)))*-s + ( (x(3)*x(5))/(x(4) - x(3)) + x(5)))*(heaviside(s-x(3)) - heaviside(s-x(4)));

%f = @(x) 100*(x(2)-x(1).^2).^2+(1-x(1)).^2;
%dfx1=@(x1,x2)  -400*x1*x2 + 400*x1.^3 + 2*x1-2; 
%dfx2=@(x1,x2) 200*(x2-x1.^2); 

%gradf=@(x) [ dfx1(x(1),x(2)) ; dfx2(x(1), x(2))];

gradf = @(x) [(heaviside(s - x(1)) - heaviside(s - x(2)))*(x(5)/(x(1) - x(2)) + (s*x(5))/(x(1) - x(2))^2 - (x(1)*x(5))/(x(1) - x(2))^2) + dirac(s - x(2))*((s*x(5))/(x(1) - x(2)) - (x(1)*x(5))/(x(1) - x(2)));
 - ((s*x(5))/(x(1) - x(2))^2 - (x(1)*x(5))/(x(1) - x(2))^2)*(heaviside(s - x(1)) - heaviside(s - x(2))) - dirac(s - x(2))*((s*x(5))/(x(1) - x(2)) - (x(1)*x(5))/(x(1) - x(2))) - x(5)*dirac(s - x(2));
 x(5)*dirac(s - x(3)) - (heaviside(s - x(3)) - heaviside(s - x(4)))*(x(5)/(x(3) - x(4)) + (s*x(5))/(x(3) - x(4))^2 - (x(3)*x(5))/(x(3) - x(4))^2) - dirac(s - x(3))*(x(5) + (s*x(5))/(x(3) - x(4)) - (x(3)*x(5))/(x(3) - x(4)));
                                          ((s*x(5))/(x(3) - x(4))^2 - (x(3)*x(5))/(x(3) - x(4))^2)*(heaviside(s - x(3)) - heaviside(s - x(4))) + dirac(s - x(4))*(x(5) + (s*x(5))/(x(3) - x(4)) - (x(3)*x(5))/(x(3) - x(4)));
 heaviside(s - x(2)) - heaviside(s - x(3)) - (s/(x(1) - x(2)) - x(1)/(x(1) - x(2)))*(heaviside(s - x(1)) - heaviside(s - x(2))) + (heaviside(s - x(3)) - heaviside(s - x(4)))*(s/(x(3) - x(4)) - x(3)/(x(3) - x(4)) + 1)];
 
i=1;
x(i,:)=[0,1,3,4,5];
Hk=eye(5,5);
%Backtracking parameters
c=10e-6; rho=0.5;
% stoping conditions
error(i)=norm(gradf(x(i,:)));
tol=1^-6;
while error(i)>tol
    % Step Direction (Newton's)
    p_k= -1*Hk*gradf(x(i,:));
    % Step Lenght Calculation
    alpha(i) = BTracking(x(i,:),gradf,f,c,rho,p_k);
    % Line Search Update
    x(i+1,:)= x(i,:) + (alpha(i)*p_k)';
    % Secant Equations Update
    sk = x(i+1,:)' - x(i,:)';
    yk = gradf(x(i+1,:)) - gradf(x(i,:));
    %Update Rho with new sk and yk
    rhok= 1/(yk'*sk);
    % BFGS Hessian Matrix Update
    I = eye(size(Hk));
    Hk = (I - rhok*(sk*yk'))*Hk*(I - rhok*(yk*sk')) + rhok*(sk*sk');
    % Next Step and Calculate Error
    i=i+1;
    error(i) = norm(gradf(x(i,:)));
end
x(i,:)
i