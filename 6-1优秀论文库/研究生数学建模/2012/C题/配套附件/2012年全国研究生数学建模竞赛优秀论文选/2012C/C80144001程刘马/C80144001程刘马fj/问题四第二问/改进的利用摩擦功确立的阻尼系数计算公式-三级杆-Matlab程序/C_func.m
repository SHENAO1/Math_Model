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
global Ag
Er = 2.1*10^11; %Pa 
Rour = 8456; %kg/m^3
T= 60/4; %s
Br = 44/1000; % m
G1r = 25/1000; %m 
G1l = 523.61; %m
G2r = 22/1000; %m
G2l = 664.32; %m
G3l = 618.35; %m
G3r = 19/1000; %m
Gl=[532.61,664.32,618.35]; %
Gr=[25,22,19]/1000;        %
Ag=pi *(Gr/2).^2;          %
Zl = 1893.1; %m 
Bl =1819.56; %m
A1g= pi *(G1r/2)^2;
A2g= pi *(G2r/2)^2;
A3g= pi *(G3r/2)^2;
S = 4.2; %m
mu =4; %1/min
Rou_w = 1*10^3; %kg/m^3
Rou_o = 0.864*10^3; %kg/m^3
Pt =0.3; %MPa
Pc =0.2; %MPa
Ab = pi*(Br/2)^2; %m^2
Rou_l = 0.912*Rou_w+(1-0.912)*Rou_o; % kg /m^3
Glz=G1l+G2l+G3l; %杆的总长

D_exp =1000*load ('E_zaihe_exp3_new.dat'); %N
U_exp = load ('E_dis_exp3_new.dat');  %m

n=10;
K=143;

x=0.912;  %含水率
u_o=30*10^(-3);       %油的粘度 Pa.s
u_w=0.8937*10^(-3);   %水的粘度 Pa.s
u=10^(x*log10(u_w)+(1-x)*log10(u_o));
a=sqrt(Er/Rour);
omiga=2*pi/T;
Rour=8456;
m=Br/G3r;
B1=(m^2-1)/(2*log(m))-1;
B2=m^4-1-((m^2-1)^2)/(log(m));


h=1;
for i=1:n+1 %sigama
    sigama(h,i)=0;
    for j=1:K
        sigama(h,i)=sigama(h,i)+2/K*D_exp(j)*cos(2*(i-1)*pi*j/K);
    end
end
for i=1:n %tao
    tao(h,i)=0;
    for j=1:K
        tao(h,i)=tao(h,i)+2/K*D_exp(j)*sin(2*i*pi*j/K);
    end
end
for i=1:n+1 %mui
    v(h,i)=0;
    for j=1:K
        v(h,i)=v(h,i)+2/K*U_exp(j)*cos(2*(i-1)*pi*j/K);
    end
end
for i=1:n %deta
    deta(h,i)=0;
    for j=1:K
        deta(h,i)=deta(h,i)+2/K*U_exp(j)*sin(2*i*pi*j/K);
    end
end
alpha(1)=0;
for i=2:n+1
    alpha(i)=(i-1)*omiga/a/1.414*sqrt(1+sqrt(1+(c/(i-1)/omiga)^2));
end
beta(1)=0;
for i=2:n+1
    beta(i)=(i-1)*omiga/a/1.414*sqrt(-1+sqrt(1+(c/(i-1)/omiga)^2));
end
for i=1:n
    k(h,i)=(sigama(h,i+1)*alpha(i+1)+tao(h,i)*beta(i+1))/(Er*A1g*(alpha(i+1)^2+beta(i+1)^2));
end
for i=1:n
    mui(h,i)=(sigama(h,i+1)*beta(i+1)-tao(h,i)*alpha(i+1))/(Er*A1g*(alpha(i+1)^2+beta(i+1)^2));
end
for h=2:3
v(h,1)=sigama(h-1,1)*Gl(h-1)/Er/Ag(h-1)+v(h-1,1);
sigama(h,1)=sigama(h-1,1);
for i=2:n+1
    v(h,i)=O_func2(h-1,i-1,Gl(h-1));
    sigama(h,i)=Er*Ag(h-1)*O1_func2(h-1,i-1,Gl(h-1));
end
for i=1:n
    deta(h,i)=P_func2(h-1,i,Gl(h-1));
    tao(h,i)=Er*Ag(h-1)*P1_func2(h-1,i,Gl(h-1));
    k(h,i)=(sigama(h,i+1)*alpha(i+1)+tao(h,i)*beta(i+1))...
           /(Er*Ag(h)*(alpha(i+1)^2+beta(i+1)^2));
    mui(h,i)=(sigama(h,i+1)*beta(i+1)-tao(h,i)*alpha(i+1))...
           /(Er*Ag(h)*(alpha(i+1)^2+beta(i+1)^2));
end
end

jifen=dblquad('dudt_func1_2',0,G3l,0,T)/dblquad('dudt_func2_2',0,G3l,0,T);
G=2*pi*u/(Rour*A3g)*(1/log(m)+4/B2*(B1+1)*(B1+jifen));
end