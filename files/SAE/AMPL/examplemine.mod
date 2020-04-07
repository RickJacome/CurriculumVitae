param n;
param m;
param k;
set J := {1..n};  #set of decision variables
set I := {1..m};  #set of constraints
set E := {1..k}; # set of equality constraints

param C {J} >= 0;  #objective function coefficients
param A {I,J} >= 0;  #constraint coefficients matrix
param B {I} >= 0;  #rhs of the constraints

var X {J} >=0 integer;  #decision variables

minimize z:  sum {j in J} C[j] * X[j];

subject to Constraint1 {i in I}:
	sum {j in J} A[i,j] * X[j] >= B[i];
subject to Constraint2 {i in E}:
	sum {j in J} A[i,j] * X[j] = B[i];