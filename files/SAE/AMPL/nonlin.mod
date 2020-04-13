param n >= 1; 			# number of measurements
param s{1..n}; 		# measurement points (x_i)
param k{1..n};		        # Data to fit y_i
var A;
var B;
var C;

minimize z: sum{i in 1..n} ( A*s[i]^2 + B*s[i] + C - k[i])^2;

subject to Constraint1: A >=0;

subject to Constraint2: B >=0;