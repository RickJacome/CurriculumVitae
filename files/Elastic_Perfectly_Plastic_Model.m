% Elastic Perfectly Plastic Model
Fyo = 2;
AE = 20;
eps = 0:.1:1;
t = linspace(0,10,numel(eps));
eps_dot = eps/t;
F = AE*(eps - ;


% Test Yield Function
if F >= 0
        f = F - Fyo;
else
        f = -F - Fyo;    
end

% Trial Derivative 
if F >= 0
        trial_fdot = AE*eps_dot;
else
        trial_fdot = -AE*eps_dot;    
end

% Plastic Strain Rate of Change
if f == 0 && trial_fdot > 0
        epsdot_p = eps_dot;
else
        epsdot_p = 0;
end
    
    
    