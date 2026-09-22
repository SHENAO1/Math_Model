clc;
clear;
global n
global x 
global t
global Er
global A1g
global omiga
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
Rou_w = 1*10^3; %kg/m^3
Rou_o = 0.864*10^3; %kg/m^3
Pt =0.3; %MPa
Pc =0.2; %MPa
Ab = pi*(Br/2)^2; %m^2
Rou_l = 0.98*Rou_w+0.02*Rou_o; % kg /m^3
W_fz = (Rour-Rou_l)*A1g*G1l*9.8;

D_exp = 1000*load ('E_zaihe_exp.dat'); %KN
U_exp = load ('E_dis_exp.dat');  %m

delta_t = 60/7.6/143;
t = 0: delta_t: 60/7.6;

b=(Rour-Rou_l)/Rour;
Wr=A1g * Rour * Bl;
Wr_p=Wr * b;
deltaW = (Ab-A1g)*Bl*Rou_l; %kg
Wl_p = Ab * G1l * Rou_l *9.8; 
Pr = Wl_p * S * mu / (6*10^4) ;

a = sqrt (Er/Rour);
Q = (Ab * S * mu * 60 *24 )* Rou_l; % kg/d
Lf = (deltaW*9.8-10^6*(Pt-Pc)*Ab)/(Ab*Rou_l*9.8);
H = Lf + (Pt-Pc)/(Rou_l*9.8)*10^6;
Ph = Q/1000*H*9.8/86400;
gama = (4.42*10^(-2)*(G1l*3.28)*(Pr-Ph)/0.73549875*T^2)/((A1g*1550)*(G1l*3.28)*(S*3.28)^2);
c = pi*(a*3.28)*gama/(2*(G1l*3.28));

global K
omiga=2*pi/T;
theta=omiga*t;
n=12;K=144;
global sigama
global tao
global v
global deta
global alpha
global beta
global k
global mui
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




for i=1:n+1 %mui
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
end

beta(1)=0;
for i=2:n+1
    beta(i)=(i-1)*omiga/a/1.414*sqrt(-1+sqrt(1+(c/(i-1)/omiga)^2));
end

for i=1:n
    k(i)=(sigama(i+1)*alpha(i+1)+tao(i)*beta(i+1))/(Er*A1g*(alpha(i+1)^2+beta(i+1)^2));
end
for i=1:n
    mui(i)=(sigama(i+1)*beta(i+1)-tao(i)*alpha(i+1))/(Er*A1g*(alpha(i+1)^2+beta(i+1)^2));
end

O_func(1,22)
U_func(700,1)
F_func(700,1)
for i=1:0.5:10
    w=U_func(700,i);
    figure(1)
    plot(i,w,'x')
    hold on  
end
for i=1:0.5:10
    y=F_func(700,i);
    figure(2)
    plot(i,y,'o')
    hold on
end
m=1;
for i=1:0.1:10
    w(m,:)=U_func(790,i);
    y(m,:)=F_func(790,i)-W_fz;
    figure(3)
    plot(w,y,'o')
    hold on
    m=m+1;
end

save u_js.dat w -ascii;
save f_js.dat y -ascii;