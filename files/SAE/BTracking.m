function Step_Length =BTracking(x,df,f,c,rho,p_k)
    alphak = 1;
    fk1=f(x);
    df=df(x);
    xx = x' + alphak*p_k;
    fk2=f(xx);
    while fk2>fk1+c*alphak*(p_k*df')
        alphak=alphak*rho;
        xx=x'+alphak*p_k;
        fk2=f(xx);
    end
    Step_Length=alphak;
end