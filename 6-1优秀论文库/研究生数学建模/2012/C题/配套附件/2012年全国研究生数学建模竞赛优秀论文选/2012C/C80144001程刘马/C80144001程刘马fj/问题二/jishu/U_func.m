function G = U_func(x,t)
global omiga
global n;
global Er;
global tao;
global A1g;
global sigama;
global v;
global deta;
global alpha;
global beta;
global K;
global mui;
sum=0;
for i=1:n
    sum=sum+(O_func(i,x)*cos(i*omiga*t)+P_func(i,x)*sin(i*omiga*t));
end

G = sigama(1)*x/(2*Er*A1g)+0.5*v(1)+sum;
