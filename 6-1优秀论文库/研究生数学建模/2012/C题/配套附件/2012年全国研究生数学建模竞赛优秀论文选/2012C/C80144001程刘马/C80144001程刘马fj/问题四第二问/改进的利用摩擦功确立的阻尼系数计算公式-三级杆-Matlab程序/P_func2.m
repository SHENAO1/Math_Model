function G = P_func2(h,n,x)
global v;
global deta;
global alpha;
global beta;
global k;
global mui;
G=(k(h,n).*sinh(beta(n+1)*x)+deta(h,n).*cosh(beta(n+1)*x)).*cos(alpha(n+1)*x)-...
    (mui(h,n).*cosh(beta(n+1)*x)+v(h,n+1).*sinh(beta(n+1)*x)).*sin(alpha(n+1)*x);
end

