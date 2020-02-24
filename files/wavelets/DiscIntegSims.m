function [R,U,n] = DiscIntegSims(X,Y)
% Simpsons Rule
% (b-a)/6 (f(a) + 4*f(m) + f(b)
% m = (a+b)/2
n = numel(Y);
R = zeros(1,n); 
U = zeros(1,n);
    for k = 2:n-1   
        m = (Y(k-1) + Y(k))/2;
        R(k+1) =  ((X(k)-X(k-1))/6)*( Y(k-1) + 4*m + Y(k) ) + R(k-1) ; 
    end
    for k = 2:n-1 
        m = (R(k-1) + R(k))/2;
        U(k+1) =  ((X(k)-X(k-1))/6)*( R(k-1) + 4*m + R(k) ) + U(k-1) ;
    end
end