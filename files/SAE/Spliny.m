function [A] = spliny(s,k,n,dt)
    
    A = zeros(n-1,4);
    s_strt = [1 s(1) s(1)^2;
             1 s(2) s(2)^2;
             1 s(3)   s(3)^2 ];
         
    d_strt = [k(1) k(2) k(3)]';
    x_strt = s_strt\d_strt;
    
   t_strt = s(1):dt:s(2);
   k_strt = x_strt(1) + x_strt(2).*t_strt + x_strt(3).*t_strt.^2;
   A(1,:) = [x_strt' 0];
   plot(t_strt,k_strt,'b')
    for i = 2:2:n-2
      S =[1 s(i)   s(i)^2   s(i)^3     0   0      0         0;
          1 s(i+1) s(i+1)^2 s(i+1)^3   0   0      0         0;
          0 0      0        0          1   s(i+1) s(i+1)^2  s(i+1)^3;
          0 0      0        0          1   s(i+2) s(i+2)^2  s(i+2)^3;
          0 1      2*s(i+1) 3*s(i+1)^2 0  -1      -2*s(i+1) -3*s(i+1)^2;
          0 0      2        6*s(i+1)   0   0      -2        -6*s(i+1);
          0 0      2        6*s(i)     0   0      0         0;
          0 0      0        0          0   0      2        6*s(i+2)];
    d = [k(i) k(i+1) k(i+1) k(i+2) 0 0 0 0]';
    x = S\d;    
    t1 = s(i):dt:s(i+1);  t2 = s(i+1):dt:s(i+2);
        k1 = x(1) + x(2).*t1 + x(3).*t1.^2 +  x(4).*t1.^3;
        k2 = x(5) + x(6).*t2 + x(7).*t2.^2 +  x(8).*t2.^3;    
        plot(t1,k1,'b',t2,k2,'b'); hold on
       
    A(i,:) = x(1:4);
    A(i+1,:) = x(5:8);
    
    end
    
    if mod(n,2) == 1
        s_end = [1 s(end-2) s(end-2)^2;
                 1 s(end-1) s(end-1)^2;
                 1 s(end)   s(end)^2 ];
        d_end = [k(end-2) k(end-1) k(end)]';
        x_end = s_end\d_end;
       t_end = s(end-1):dt:s(end);
       k_end = x_end(1) + x_end(2).*t_end + x_end(3).*t_end.^2;
       A(end,:) = [x_end' 0];
       plot(t_end,k_end,'b')
    end
end