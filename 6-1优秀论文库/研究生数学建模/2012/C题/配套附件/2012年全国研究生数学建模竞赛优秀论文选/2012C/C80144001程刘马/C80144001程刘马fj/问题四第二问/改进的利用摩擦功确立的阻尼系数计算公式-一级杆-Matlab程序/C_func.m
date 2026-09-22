function G = C_func(c)

format long;
global a
global n
global K
global Er
global omiga
global A1g
global G1l
global T
global sigama
global tao
global v
global deta
global alpha
global beta
global k
global mui
Er = 2.1*10^11; %Pa 
Rour = 8456; %kg/m^3
T= 60/7.6; %s
Br = 70/1000; % m
G1r = 22/1000; %m 
G1l = 792.5; %m
Bl =793; %m
A1g= pi *(G1r/2)^2;
S = 3.2; %m
mu =7.6; %1/min
D_exp =1000*load ('E_zaihe_exp.dat'); %N
U_exp = load ('E_dis_exp.dat');  %m
n=10;
K=144;
G1l=792.5;
T=60/7.6;
x=0.98;  %含水率
u_o=30*10^(-3);       %油的粘度 Pa.s
u_w=0.8937*10^(-3);   %水的粘度 Pa.s
u=10^(x*log10(u_w)+(1-x)*log10(u_o));
a=sqrt(Er/Rour);
omiga=2*pi/T;
Rour=8456;
m=Br/G1r;
B1=(m^2-1)/(2*log(m))-1;
B2=m^4-1-((m^2-1)^2)/(log(m));


for i=1:n+1 %sigama
    sigama(i)=0;
    for j=1:K
        sigama(i)=sigama(i)+2/K*D_exp(j)*cos(2*(i-1)*pi*j/K);
    end
end
for i=1:n %tao
    tao(i)=0;
    for j=1:K
        tao(i)=tao(i)+2/K*D_exp(j)*sin(2*i*pi*j/K);
    end
end
for i=1:n+1 %v
    v(i)=0;
    for j=1:K
        v(i)=v(i)+2/K*U_exp(j)*cos(2*(i-1)*pi*j/K);
    end
end
for i=1:n %deta
    deta(i)=0;
    for j=1:K
        deta(i)=deta(i)+2/K*U_exp(j)*sin(2*i*pi*j/K);
    end
end
alpha(1)=0;
for i=2:n+1
    alpha(i)=(i-1)*omiga/a/1.414*sqrt(1+sqrt(1+(c/(i-1)/omiga)^2));
end %计算alpha的值
beta(1)=0;
for i=2:n+1
    beta(i)=(i-1)*omiga/a/1.414*sqrt(-1+sqrt(1+(c/(i-1)/omiga)^2));
end%计算beta的值
for i=1:n
    k(i)=(sigama(i+1)*alpha(i+1)+tao(i)*beta(i+1))/(Er*A1g*(alpha(i+1)^2+beta(i+1)^2));
end%k
for i=1:n
    mui(i)=(sigama(i+1)*beta(i+1)-tao(i)*alpha(i+1))/(Er*A1g*(alpha(i+1)^2+beta(i+1)^2));
end%mui
jifen=dblquad('dudt_func1',0,G1l,0,T)/dblquad('dudt_func2',0,G1l,0,T);
G=2*pi*u/(Rour*A1g)*(1/log(m)+4/B2*(B1+1)*(B1+jifen));
end