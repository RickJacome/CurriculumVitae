x=[0:0.1:0.5];
y=[0.4 0.375 0.35 0.325 0.275 0.15];
p=polyfit(x,y,3);
x=0:.01:.5;
y=polyval(p,x);
d=0.07;
make_plot=1;
flag1=0;
[x_inner, y_inner, x_outer, y_outer, R, unv, concavity, overlap]=parallel_curve(x, y, d, make_plot, flag1);

