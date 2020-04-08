param n >= 1; 			# number of measurements
param xpts{1..n}; 		# measurement points (x_i)
param D{1..n};		        # Data to fit y_i
var a;
var b;
var c;

minimize z: sum{i in 1..n} ( a^2*xpts[i]^2 + b*xpts[i] + c - D[i])^2;

subject to Constraint1: a>=0;

subject to Constraint2: b>=0;