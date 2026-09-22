function G = O1_func2(h,n,x)

global Er;
global tao;
global Ag;
global v;
global deta;
global alpha;
global beta;
global sigama
G=(tao(h,n).*sinh(beta(n+1).*x)./(Er*Ag(h))+(deta(h,n).*beta(n+1)-v(h,n+1).*alpha(n+1)).*cosh(beta(n+1).*x)).*sin(alpha(n+1)*x)...
    +(sigama(h,n+1).*cosh(beta(n+1).*x)./(Er*Ag(h))+(v(h,n+1).*beta(n+1)+deta(h,n).*alpha(n+1)).*sinh(beta(n+1).*x)).*cos(alpha(n+1)*x);
end