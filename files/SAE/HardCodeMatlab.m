clear; close all; clc
%Google Earth Data
load('GPS1Xft.mat'); load('GPS1Yft.mat'); %Data is in Feet
x2 = GPSX; y2 = GPSY;
x2 = x2'*.3048; y2 = y2'*.3048; %Conversion to Meters

nu = numel(y2); x2 = x2(1:nu);
X = [x2',y2']; Li = zeros(nu,1);
for i = 2:nu
    Li(i) = Li(i-1) + norm( X(i,:)-X(i-1,:) );
end
FinerSeg = min(Li):1:max(Li);
x2 = spline(Li,x2,FinerSeg); 
y2 = spline(Li,y2,FinerSeg); 
X = [x2',y2'];
[L,R,K] = curvature(X);

[O1,O2] = direction(K);
e1 = cosd(O2); e2 = sind(O2);
hold on; quiver(x2',y2',e1,e2); hold off

%  Smoothing Technique on Center Lane Angles----------------

x = L; y = O2;
yy1 = smooth(x,y,0.15,'loess');  %Span of 15%
yy2 = smooth(x,y,0.15,'rloess');

e1 = cosd(yy2); e2 = sind(yy2);  

% Numerical Differentiation
% Central Difference Method
N = numel(yy2);
k_num_C = zeros(1,N);
for i = 2:N-1
    k_num_C(i) = (yy2(i+1) - yy2(i-1))/(L(i+1) - L(i-1));   
end

K_mag = sqrt( K(:,2).^2 + K(:,1).^2 );

% Unit Vectors in the direction of Curvature (original)
k1 = K(:,1)./K_mag;
k2 = K(:,2)./K_mag;

% Align the differentiated magnitudes
% with the direction of the original curvature
kp1 = k_num_C'.*k1; 
kp2 = k_num_C'.*k2;

% %---------------------------------------------------
% Detect When the Average Changes Drastically
Signal = yy2;
n = numel(Signal);  o = zeros(n,1);
threshold = 0.01; % Maximum Rate of change in heading
Sig1 = zeros(n,1);
Sig2 = zeros(n,1);
for i = 1:n-2
        if  abs(diff([Signal(i),Signal(i+1),Signal(i+2)])) < threshold  
          o(i) = 0;
          Sig1(i) = Signal(i);
        else  
          o(i) = 120;  
          Sig2(i) = Signal(i);
        end      
end
% %---------------------------------------------------
% Align the differentiated magnitudes
% with the direction of the original curvature
ksign1 = -sign(k_num_C)'.*K(:,1).*k1; 
ksign2 = sign(k_num_C)'.*K(:,2).*k2;
%%%%%%

K_mag = sqrt( K(:,2).^2 + K(:,1).^2 );
Ksigned = K_mag.*sign(k_num_C)';


function [O1,O2] = direction(K2)
    %Orthogonal Shift Function 
     O1 = atand(K2(:,2)./K2(:,1));  %Angle in Degrees
     O2 = O1 + 90;   % 90 Degrees
end


function [L,R,kappa] = curvature(X)
% Radius of curvature and curvature vector for 2D or 3D curve
%  [L,R,Kappa] = curvature(X)
%   X:   2 or 3 column array of x, y (and possibly z) coordiates
%   L:   Cumulative arc length
%   R:   Radius of curvature
%   k:   Curvature vector

  n = size(X,1);
  dims = size(X,2); %Check Dimension Size
  if dims == 2
    X = [X,zeros(n,1)];  % Do all calculations in 3D
  end
  L = zeros(n,1);
  R = NaN(n,1);  %NaN Vector Size of N
  kappa = NaN(n,3); 
  for i = 2:n-1
      %The input for the Circumcenter function 
      %is X current (BOTH coordinates of 1 point), X previous (BOTH
      % coordinates of second point, and X future (both coordinates of
      % third point)
      % Outputs are Radius R and Curvature k
    [R(i),~,kappa(i,:)] = circumcenter(X(i,:)',X(i-1,:)',X(i+1,:)');
    L(i) = L(i-1)+norm(X(i,:)-X(i-1,:));
  end
  i = n;
  L(i) = L(i-1)+norm(X(i,:)-X(i-1,:));
  if dims == 2
    kappa = kappa(:,1:2);
  end
end

function [R,M,k] = circumcenter(A,B,C)
% Center and radius of the circumscribed circle for the triangle ABC
%  A,B,C  3D coordinate vectors for the triangle corners
%  R      Radius
%  M      3D coordinate vector for the center
%  k      Vector of length 1/R in the direction from A towards M
%         (Curvature vector)
  D = cross(B-A,C-A);
  b = norm(A-C);
  c = norm(A-B);
%   if nargout == 1
%     a = norm(B-C);     % slightly faster if only R is required
%     R = a*b*c/2/norm(D);
%     return
%   end
  E = cross(D,B-A);
  F = cross(D,C-A);  
  G = (b^2*E-c^2*F)/norm(D)^2/2;
  M = A + G;
  R = norm(G);  % Radius of curvature
%   if R == 0
%     k = G;
%   else
%     k = G'/R^2;   % Curvature vector
%   end

k = G'/R^2;
end
