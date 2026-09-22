function G = O1_func(n,x)

global Er;
global tao;
global A1g;
global v;
global deta;
global alpha;
global beta;
G=(tao(n).*sinh(beta(n+1).*x)./(Er*A1g)+(deta(n).*beta(n+1)-v(n+1).*alpha(n+1)).*cosh(beta(n+1).*x)).*sin(alpha(n+1)*x)...
    +(deta(n).*cosh(beta(n+1).*x)./(Er*A1g)+(v(n+1).*beta(n+1)+deta(n).*alpha(n+1)).*sinh(beta(n+1).*x)).*cos(alpha(n+1)*x);
end