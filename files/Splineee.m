x=[0.9 1.3 1.9 2.1 2.6 3.0 3.9 4.4 4.7 5.0 6.0 7.0 8.0 ... 
    9.2 10.5 11.3 11.6 12.0 12.6 13.0 13.3]; 
y=[1.3 1.5 1.85 2.1 2.6 2.7 2.4 2.15 2.05 2.1 2.25 2.3 ... 
    2.25 1.95 1.4 0.9 0.7 0.6 0.5 0.4 .25];
n = numel(x); h = zeros(n-1,1);

for i = 2:n-1
    h(i) = x(i) - x(i+1);
end

H = zeros(n);
for i = 2:n-1
H = [1          0         0         0            0;
     h(i) 2*(h(i)+h(i+1)) h(i+1)    0            0;
     0          0         h(i-1) 2*(h(i-1)+h(i)) h(i);     
     0          0         0         0            1]
end
d = zeros(n,1);
for i = 2:n-1
    d(i) = 6*( (y(i+1) - y(i))/h(i+1) - (y(i) - y(i-1))/h(i) );
end
M = H\d;
P = zeros(n-1,4);
for i = 1:n-1 
    P(i,1) = dj(i);  
    P(i,2) = cj(i);
    P(i,3) = bj(i); 
    P(i,4) = a(i); 
end

resolution = 100;
for i = 1:n-1 
    f = @(x) a(i) + bj(i).*(x-xi(i)) + cj(i).*(x-xi(i)).^2 + dj(i).*(x-xi(i)).^3; 
    xf = linspace(xi(i),xi(i+1),resolution); 
    plot(xf,f(xf),'b'); 
end