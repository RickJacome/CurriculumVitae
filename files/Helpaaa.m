xi=[0.9 1.3 1.9 2.1 2.6 3.0 3.9 4.4 4.7 5.0 6.0 7.0 8.0 ... 
    9.2 10.5 11.3 11.6 12.0 12.6 13.0 13.3]; 
a=[1.3 1.5 1.85 2.1 2.6 2.7 2.4 2.15 2.05 2.1 2.25 2.3 ... 
    2.25 1.95 1.4 0.9 0.7 0.6 0.5 0.4 .25];
% Cubic Spline Interpolation - Natural Spline 
% INPUT: xi is the grid (points on x-axis) and a are points on y-axis.
% inter is the point on the x-axis you want to know the value of on the y-axis.
cubic_spline(xi,a,10)

function [a_inter] = cubic_spline(xi,a,inter)
    if length(xi) ~= length(a) 
        error('vectors xi and a must be of same length'); 
    end
% Plotting points we want to interpolate between: 
grid on; hold on; title('Cubic Spline Interpolation'); 
plot(xi,a,'or'); n = length(xi);
% Vector h with subintervals: 
h = zeros(n-1,1); 
    for j = 1:n-1
        h(j) = xi(j+1) - xi(j); 
    end
% Coefficient matrix A: 
A = zeros(n);
% Natural Spline boundary conditions: 
A(1,1)= 1;  A(n,n) = 1;
     for i = 2:n-1 
        A(i,i-1) = h(i-1); 
        A(i,i) = 2*(h(i-1)+h(i)); 
        A(i,i+1) = h(i); 
    end
% Vector b: 
b = zeros(n,1);
    for i = 2:n-1 
        b(i) = (3/h(i))*(a(i+1)-a(i)) - (3/h(i-1))*(a(i)-a(i-1));     
    end
% Coefficient vector cj: 
cj = A\b;
% Coefficient vector bj: 
bj = zeros(n-1,1); 
    for i = 1:n-1 
        bj(i) = (1/h(i))*(a(i+1)-a(i)) - (1/3*h(i))*(2*cj(i)+cj(i+1)); 
    end
% Coefficient vector dj: 
dj = zeros(n-1,1); 
    for i = 1:n-1 
       dj(i) = (1/(3*h(i))) * (cj(i+1)-cj(i)); 
    end
% Making a matrix P with all polynomials 
P = zeros(n-1,4); 
    for i = 1:n-1 
        P(i,1) = dj(i);   P(i,2) = cj(i);   P(i,3) = bj(i); P(i,4) = a(i); 
    end
% Plotting results: 
resolution = 100;
    for i = 1:n-1 
         f = @(x) a(i) + bj(i).*(x-xi(i)) + cj(i).*(x-xi(i)).^2 + dj(i).*(x-xi(i)).^3; 
         xf = linspace(xi(i),xi(i+1),resolution); 
         plot(xf,f(xf),'b'); 
    end
% Given a value on the x-axis, inter, that we wish to know the y-value of, 
% we must first find in which interval inter is. We will use bisection 
% search to accomplish this. Interval must be ascending or descending.
jl = 1; 
ju = n; 
while (ju - jl > 1) 
   jm = ceil((jl + ju)/2); 
    if (inter < xi(jm)) 
     ju = jm; 
    else 
      jl = jm; 
    end 
end
a_inter = polyval(P(jl,:), inter-xi(jl)); 
fprintf('\n The interpolated value is: %f \n', a_inter); 
plot(inter, a_inter, 'og'); 
fprintf('The value of bj is %f \n',bj); 
fprintf('The value of cj is %f \n',cj); 
fprintf('The value of dj is %f \n',dj);
end 