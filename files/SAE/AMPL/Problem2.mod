
param L > 0; # m
param K > 0; # m^-1
param U > 0; # deg
param g > 0; # m/s^2
param e > 0; # (Percentage 0-100)
param mu > 0; # unitless

var x{1..2};


minimize Z:  x[1] - (53.7*L + U*x[2]^2/g )*K;


subject to C1:  x[2]^2*K/g - (mu + 0.01*e)/(1-0.01*mu*e) = 0;
subject to C2: x[1] <= 3;
subject to C3: x[1] >= -3;
subject to C4: x[2] >= 0;
subject to C5: x[2] <= 60;