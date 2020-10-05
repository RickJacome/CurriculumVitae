function [x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curve_New(x, y, d, make_plot, flag1)
if nargin < 1 || isempty(x) || ~isnumeric(x)
    x=1:100;
end
if nargin < 2 || isempty(y) || ~isnumeric(y)
    y=x.^2;
end
if nargin < 3 || isempty(d) || ~isnumeric(d)
    d=1;
end
if nargin < 4 || isempty(make_plot) || ~isnumeric(make_plot)
    make_plot=1;
end
if nargin < 5 || isempty(flag1) || ~isnumeric(flag1)
    flag1=1;
end
% % Make sure that x and y are column vectors.
x=x(:);
y=y(:);
% % Calculate the unit gradient in the x-direction.
dx=gradient(x);
% % Calculate the unit gradient in the y-direction.
dy=gradient(y);
% % Calculate the unit second gradient in the x-direction.
dx2=gradient(dx);
% % Calculate the unit second gradient in the y-direction.
dy2=gradient(dy);
% % Calculate the normal vector
nv=[dy, -dx];
% % normalize the normal vector
unv=zeros(size(nv));
norm_nv=norm(nv, 2);
unv(:, 1)=nv(:, 1)./norm_nv;
unv(:, 2)=nv(:, 2)./norm_nv;
% % determine radius of curvature
R=(dx.^2+dy.^2).^(3/2)./abs(dx.*dy2-dy.*dx2);
% % Determine overlap points for inner normal curve
overlap=R < d;
% % Determine concavity
concavity=2*(dy2 > 0)-1;
if isequal(flag1, 1)
    
    % % For inner normal curve
    x_inner=x-unv(:, 1).*concavity.*d;
    y_inner=y-unv(:, 2).*concavity.*d;
    % % For outer normal curve
    x_outer=x+unv(:, 1).*concavity.*d;
    y_outer=y+unv(:, 2).*concavity.*d;
    
else

    % % For inner normal curve
    x_inner=x-unv(:, 1).*d;
    y_inner=y-unv(:, 2).*d;

    % % For outer normal curve
    x_outer=x+unv(:, 1).*d;
    y_outer=y+unv(:, 2).*d;

end

%  % Make a simple plot of the curve and the parallels
if isequal(make_plot, 1)

    figure; plot(x, y, 'b'); hold on;
    plot(x_inner, y_inner, 'r'); plot(x_outer, y_outer, 'g');
    legend({'Curve', 'Inner Parallel', 'Outer Parallel'}, 'location', 'Best');
    % The axis scaling can be modified.
    % axis equal makes the plots more realistic for geometric
    % constructions.  if this is a problem, change to axis normal.
    axis equal
    % axis normal

end