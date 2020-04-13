var x{1..3};


minimize norm:  x[3] - x[1]/(1+x[2]^2)^(3/2);

subject to C2: x[3] <= 1;

subject to C3: x[3] >=0;

