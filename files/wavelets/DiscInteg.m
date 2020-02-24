function [Th,TT,n] = DiscInteg(X,Y)
K = Y;  S = X;
n = numel(S);
Th  = zeros(1,n); 
TT = zeros(1,n);
    for k = 2:n-1    
        Th(k+1) =  ( (S(k)-S(k-1))*((K(k)+K(k-1))/2) ) + Th(k-1) ; 
    end
    for k = 2:n-1 
       TT(k+1) =  ( (S(k)-S(k-1))*((Th(k)+Th(k-1))/2) ) + TT(k-1) ; 
    end
end