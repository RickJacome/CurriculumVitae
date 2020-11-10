function [] =  DynamicOptimization(S_length,K_curv)

%From this point forward, I am doing the Optimization Semi-Dynamic Routine
% Initial Conditions, NEVER repeat them.
%Google Earth IC.
 x0 =[S_length(1) 0.75*mean(S_length) ...
     1.25*mean(S_length) S_length(end) max(K_curv)];
% x0 = [1 2 3 4 5]
 % Curvature Model M.1
M1 = @(x,s) ((x(5)./(x(2)-x(1))).*(s - x(1))).*(heaviside(s-x(1)) - heaviside(s-x(2))) +...
     x(5).*(heaviside(s-x(2))-heaviside(s-x(3))) + ...
( ( x(5)./(x(4)-x(3))).*(-s+x(3))+ x(5) ).*(heaviside(s-x(3)) - heaviside(s-x(4))); 
% Pr.1
fprintf('Pr. 1, Least Squares Min. Has finalized');
options = optimset('Display','off');


x = lsqcurvefit(M1,x0,S_length,K_curv,[],[],options);
snew = linspace(S_length(1),S_length(end),100); % <--- This defines the 
% size of the "K_vector".
figure; hold on; 
plot(S_length,K_curv,'bo');
plot(snew,M1(x,snew),'k-','linewidth',2);
xlim([snew(1), snew(end)+5]);
xlabel('Segment Length s (m)'); ylabel('Curvature \kappa (m^{-1})')
legend('Data','Fitted Response','location','best'); 
title('Data and Fitted Curve'); grid on

% -------------------------
%Parameters 
global K_temp e g mu U
% Vehicle Only
L = 2.5;  %U = 1.95;
U = 3;
% Road Only
%e = 12; mu = 0.4;
e = 6; mu = 0.3;
% Both
g = 9.81; K_vector = M1(x,snew);
% -------------------------
%Iterative Optimization Routine for Pr.2 given Optimized M.1
    for i = 1:length(K_vector)
        K_temp = K_vector(i);  
        % Objective Function Pr.2
        fun = @(x)  x(1) - (53.7*L + U*x(2)^2/g)*K_temp;    
        %C.1 (Bounds)
        lb = [-3,25]; % -3 < x1 < 3;
        %ub = [30,35];
        ub = [3,36];  % 60 < x2 < 80; mph
        % There are no linear constraints, so set those arguments to |[]|. 
        A = [];  b = []; % Linear In-equality Constraints
        Aeq = []; beq = [];  % Linear Equality Constraints
        %Initial Conditions
        x0 = [1/4,1/2];  
        %Constraints as an annoynomous function
        nonlcon = @EqConstraint;
        options = optimoptions('fmincon','Display','off');
        Op(i,:) = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);  
    end

%Nonlinear Constaints (Not bounds)
    function [c,ceq] = EqConstraint(x)
        global K_temp e g mu 
        %Pr.2
        % Nonlinear Inequality Constraints
        c = x(2)^2*K_temp/g - (mu + 0.01*e)/(1-0.01*mu*e);
        % Nonlinear Equality Constraints
        ceq = [];
    end


end

