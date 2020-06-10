

rho = R; phi = lat; theta = long;
x = rho*sin(phi)*cos(theta);
y = rho*sin(phi)*sin(theta);
z = rho*cos(phi);
plot3(x,y,z,'ko','MarkerSize',10,'MarkerFaceColor','k')
hold on

syms r s
xr = r*sin(phi)*cos(theta);
yr = r*sin(phi)*sin(theta);
zr = r*cos(phi);
fplot3(xr,yr,zr,[0 rho],'k')
fplot3(xr,yr,sym(0),[0 rho],'k')
fplot3(xr,yr,sym(z),[0 rho],'k--')
fplot3(sym(x),sym(y),rho*sin(s),[0 pi/2-phi],'k')

syms s t
xa = rho*sin(s)*cos(t);
ya = rho*sin(s)*sin(t);
fsurf(xa,ya,0,[0 phi 0 theta],'FaceColor','b','EdgeColor','none')
syms u v
xp = u*sin(v)*cos(theta);
yp = u*sin(v)*sin(theta);
zp = u*cos(v);
fsurf(xp,yp,zp,[0 rho 0 phi],'FaceColor','g','EdgeColor','none')
xlabel('x')
ylabel('y')
zlabel('z')
view(115,30)
axis equal;
hold off
