param n >= 1; 			# number of measurements
param s{1..n}; 		# measurement points (x_i)
param k{1..n};		        # Data to fit y_i


var L1;
var L2;
var R1;
var R2;
var R3;


minimize z: sum{i in 1..n} ( <<L1, L2; R1, R2, R3>> s[i] -k[i])^2;


#subject to Constraint1: A >=0;

#subject to Constraint2: B >=0;