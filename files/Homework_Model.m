Fyo = 2;
AE = 20;
eps_yo = 0.1;
F = AE*(eps - eps_p);
n = 0.1; a = 10000;
% Test Yield Function
if F >= 0
        f = F - Fyo*(1+a*xi).^n;
else
      f = -F - Fyo*(1+a*xi).^n;    
end
% Test Rate of Change for the Yield Function
if F >= 0
      fdot = F - a*n*Fyo*(1+a*xi).^n-1; 
else
     fdot = -F - a*n*Fyo*(1+a*xi).^n-1;    
end
% Plastic Flow = 0 for Trial Derivative

% 
