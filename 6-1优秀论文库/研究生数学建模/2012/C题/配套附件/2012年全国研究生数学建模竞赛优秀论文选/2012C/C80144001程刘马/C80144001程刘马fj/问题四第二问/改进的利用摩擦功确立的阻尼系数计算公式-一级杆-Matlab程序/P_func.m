function G = P_func(n,x)
global v;
global deta;
global alpha;
global beta;
global k;
global mui;
G=(k(n).*sinh(beta(n+1)*x)+deta(n).*cosh(beta(n+1)*x)).*cos(alpha(n+1)*x)-...
    (mui(n).*cosh(beta(n+1)*x)+v(n+1).*sinh(beta(n+1)*x)).*sin(alpha(n+1)*x);
end