function StepLength=BackTracking(x,t,y,c,rho,p_k,f,df)
alpha = 1;
fk1 = 0.5*f(x,t,y)*f(x,t,y)';
df = df(x,t) * f(x,t,y)';
xx = x' + alpha*p_k;
fk2= 0.5*f(xx,t,y)*f(xx,t,y)';
    while  fk2 > fk1 + c*alpha*(p_k*df')
        alpha = alpha*rho;
        xx = x'+ alpha*p_k;
        fk2= 0.5*f(xx,t,y)*f(xx,t,y)';
    end
StepLength=alpha;
end