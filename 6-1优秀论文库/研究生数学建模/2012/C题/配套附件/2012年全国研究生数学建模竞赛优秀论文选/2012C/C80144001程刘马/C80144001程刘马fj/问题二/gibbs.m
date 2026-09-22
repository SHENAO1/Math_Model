clc;
clear;

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
x = G1l;
W_fz = (Rour-Rou_l)*A1g*G1l*9.8;

D_expr = 1000*load ('E_zaihe_exp_new.dat'); %KN
D_exp = D_expr;
U_exp = load ('E_dis_exp_new.dat');  %m

delta_t = 60/7.6/143;
t = [0: delta_t: 60/7.6]';

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

omiga=2*pi/T;
theta=omiga*t;

i=1;

for n =0:1:10
sigma(:,i)= omiga/pi*trapz(D_exp.*cos(n*omiga*t)*delta_t);
v(:,i) =  omiga/pi*trapz(U_exp.*cos(n*omiga*t)*delta_t);
i=i+1;
end
alpha(:,1)=0;
beta(:,1)=0;
i=1;
for n=1:1:10
alpha(:,i+1) = n*omiga/a/1.414*sqrt(1+sqrt(1+(c/n/omiga)^2));
beta(:,i+1)= n*omiga/a/1.414*sqrt(-1+sqrt(1+(c/n/omiga)^2));
tao(:,i) = omiga/pi*trapz(D_exp.*sin(n*omiga*t)*delta_t);
delta(:,i) = omiga/pi*trapz(U_exp.*sin(n*omiga*t)*delta_t);
kaba(:,i) = (sigma(:,i+1)*alpha(:,i+1) + tao(:,i)*beta(:,i+1))...
    /(Er*A1g*(alpha(:,i+1)^2+beta(:,i+1)^2));
mun(:,i) = (sigma(:,i+1)*beta(:,i+1) - tao(:,i)*alpha(:,i+1))...
    /(Er*A1g*(alpha(:,i+1)^2+beta(:,i+1)^2));
i=i+1;
end

i=1;
for n=1:1:10 
O(:,i) = (kaba(:,i)*cosh(beta(:,i+1)*x)+delta(:,i)*...
    sinh(beta(:,i+1)*x))*sin(alpha(:,i+1)*x)+ (mun(:,i)*sinh(beta(:,i+1)*x)+...
    v(:,i+1)*cosh(beta(:,i+1)*x))*cos(alpha(:,i+1)*x);
P(:,i) = (kaba(:,i)*sinh(beta(:,i+1)*x)+delta(:,i)*...
    cosh(beta(:,i+1)*x))*cos(alpha(:,i+1)*x)- (mun(:,i)*cosh(beta(:,i+1)*x)+...
    v(:,i+1)*sinh(beta(:,i+1)*x))*sin(alpha(:,i+1)*x);
O_p(:,i) = (tao(:,i)/Er/A1g*sinh(beta(:,i+1)*x)+(delta(:,i)*...
    beta(:,i+1)-v(:,i+1)*alpha(:,i+1))*cosh(beta(:,i+1)*x))*sin(alpha(:,i+1)*x)+...
    (sigma(:,i+1)/Er/A1g*cosh(beta(:,i+1)*x)+(v(:,i+1)*beta(:,i+1)+...
    delta(:,i)*alpha(:,i+1))*sinh(beta(:,i+1)*x))*cos(alpha(:,i+1)*x);
P_p(:,i) = (tao(:,i)/Er/A1g*cosh(beta(:,i+1)*x)+(delta(:,i)*...
    beta(:,i+1)-v(:,i+1)*alpha(:,i+1))*sinh(beta(:,i+1)*x))*cos(alpha(:,i+1)*x)-...
    (sigma(:,i+1)/Er/A1g*sinh(beta(:,i+1)*x)+(v(:,i+1)*beta(:,i+1)+...
    delta(:,i)*alpha(:,i+1))*cosh(beta(:,i+1)*x))*sin(alpha(:,i+1)*x);
i=i+1;
end
du_xtn=zeros(144,1);
df_xtn=zeros(144,1);
for n=1:1:10
    du_xt(:,n)=O(:,n)*cos(n*omiga*t)+P(:,n)*sin(n*omiga*t);
    du_xtn=du_xtn(:,1)+du_xt(:,n);
    df_xt(:,n)=O_p(:,n)*cos(n*omiga*t)+P_p(:,n)*sin(n*omiga*t);
    df_xtn=df_xtn(:,1)+df_xt(:,n);
end

u_xt=sigma(1)*x/(2*Er*A1g)+ v(1)/2 + du_xtn;
f_xt=sigma(1)/2+Er*A1g*df_xtn-W_fz;

u_js=load('u_js.dat');
f_js=load('f_js.dat');


figure (1)
hold on;
set(gca,'box','on')
set(gca,'linewidth',2);
plot(U_exp,D_expr,'LineWidth',2);
plot(u_xt,f_xt,'r--','LineWidth',2);
plot(u_js,f_js,'black-.','LineWidth',2);
axis([0  3 -2*10^4 8*10^4]);
xlabel('Displacement / m ','fontsize',16);
ylabel('Load / N ','fontsize',16);
legend('一级杆实测悬点示功图','Gibbs模型计算泵功图','级数法计算泵功图');

figure (2)
hold on;
set(gca,'box','on')
set(gca,'linewidth',2);
plot(t,U_exp,t,u_xt,'r--','LineWidth',2);
xlabel('Time / s ','fontsize',16);
ylabel('Displacement / m ','fontsize',16);
legend('一级杆实测位移','Gibbs模型计算位移');

figure (3)
hold on;
set(gca,'box','on')
set(gca,'linewidth',2);
plot(t,D_expr,t,f_xt,'r--','LineWidth',2);
xlabel('Time / s ','fontsize',16);
ylabel('Load / N ','fontsize',16);
legend('一级杆实测载荷','Gibbs模型计算载荷');