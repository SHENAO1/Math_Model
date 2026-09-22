function G = O_func(n,x)
global v;
global deta;
global alpha;
global beta;
global k;
global mui;

G=(k(n)*cosh(beta(n+1)*x)+deta(n)*sinh(beta(n+1)*x))*sin(alpha(n+1)*x)+...
    (mui(n)*sinh(beta(n+1)*x)+v(n+1)*cosh(beta(n+1)*x))*cos(alpha(n+1)*x);
end