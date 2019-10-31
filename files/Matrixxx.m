t = [1 2 3];
y = [ 1 2 3 4 0 0 0 0]';
A = [1 t(1) t(1)^2  t(1)^3  0  0     0        0;
     1 t(2) t(2)^2  t(2)^3  0  0     0        0;
     0 0     0      0       1  t(2)  t(2)^2   t(2)^3;  
     0 0     0      0       1  t(3)  t(3)^2   t(3)^3;
     0 1   2*t(2) 3*t(2)^2  0 -1    -2*t(2) -3*t(2)^2;
     0 0     2    6*t(2)    0  0    -2      -6*t(2);
     0 0     2    6*t(1)    0  0     0        0;
     0 0     0      0       0  0     2       6*t(3)];
x = A\y    

function y=lagrange(ndata,x)
% Lagrange interpolating polynomial of degree (ndata-1)
% returns the value of the polynomial at a point x
% uses givenfunc 

% number of data points =ndata
xdata=linspace(-5,5,ndata);
ydata=givenfunc(xdata);

sum=0;
for i=1:ndata,
    prod=1;
    for j=1:ndata,
        if i~=j 
            prod=prod*(x-xdata(j))/(xdata(i)-xdata(j));
        end
    end
    sum=sum+prod*ydata(i);
end
y=sum;
end


