
param L > 0;
param K > 0;
param U > 0; 
param g > 0;
param e > 0;
param mu > 0;

var x{1..2};


minimize Z:  x[1] - (53.7*L + U*x[2]^2/g )*K;


subject to C1:   x[2]^2*K/g - (mu + 0.01*e)/(1-0.01*mu*e) <= 0;
subject to C2: x[1] <= 5;
subject to C3: x[1] >= -5;
subject to C4: x[2] >= 0;
subject to C5: x[2] <= 60;