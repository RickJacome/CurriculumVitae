



t = randn(1,4); % Data for the example

% Coefficients To be Optimized
vars = {'A1','A2','A3','A4'};

x = optimvar('x',vars,'LowerBound',0);

obj = sum((x - t).^2); % Explicit sum of squares

prob = optimproblem("Objective",obj);

% Check to see the default solver
opts = optimoptions(prob);
% Solve Problem to obtain Minimized Coefficients
[linsol,fval] = solve(prob);
% Display Table Data
tbl = table(vars',linsol.x')


