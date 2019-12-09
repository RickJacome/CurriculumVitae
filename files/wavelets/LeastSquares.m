function [t_LS,p] = LeastSquares(t,y,D,n)
N = numel(t); 
A = zeros(N,D+1);  %Prelocation Matrix
for i=1:length(t)
    for j=1:D+1
       A(i,j) = t(i)^(D+1-j); %Vandermonde Matrix Definition 
    end
end
A = fliplr(A); %Flip the Matrix to fit LS method
M = A'*A;  b = A'*y; %Create a Minimization Problem for Normal Equations
x = M\b;  %Solve them through Matlab function
t_LS = linspace( t(1) , t(length(t)), n); %Create a t vector for n values
p  = polyval(flip(x),t_LS);
%Fit the polynomial found in x, to the values of t 
end