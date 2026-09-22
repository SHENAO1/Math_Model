clc;
clear;

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

x1 = G1l;
x2 = G2l;
x3 = G3l;

D_expr = 1000*load ('E_zaihe_exp3_new.dat'); %KN
U_exp = load ('E_dis_exp3_new.dat');  %m

W_fz1 = (Rour-Rou_l)*A1g*G1l*9.8;
W_fz2 = W_fz1+(Rour-Rou_l)*A2g*G2l*9.8;
W_fz3 = W_fz2+(Rour-Rou_l)*A3g*G3l*9.8;

D_exp1 = D_expr-W_fz1;
D_exp2 = D_expr-W_fz2;
D_exp3 = D_expr-W_fz3;

N_data = size(D_expr); %number of exp_data

delta_t = T/(N_data(:,1)-1);
t = [0: delta_t: T]';

b=(Rour-Rou_l)/Rour;
Wr=A1g * Rour * Bl;
Wr_p=Wr * b;
deltaW = (Ab-A1g)*Bl*Rou_l; %kg
Wl_p = Ab * G1l * Rou_l *9.8; 
Pr = Wl_p * S * mu / (6*10^4) ;

a = sqrt (Er/Rour);   %m/s
Q = (Ab * S * mu * 60 *24 )* Rou_l; % kg/d
Lf = (deltaW*9.8-10^6*(Pt-Pc)*Ab)/(Ab*Rou_l*9.8);
H = Lf + (Pt-Pc)/(Rou_l*9.8)*10^6;
Ph = Q/1000*H*9.8/86400;
gama = (4.42*10^(-2)*(G1l*3.28)*(Pr-Ph)/0.73549875*T^2)/((A1g*1550)*(G1l*3.28)*(S*3.28)^2);
c = pi*(a*3.28)*gama/(2*((G1l+G2l+G3l)*3.28));

omiga=2*pi/T;
theta=omiga*t;

i=1;

% 1级杆
for n =0:1:10
sigma1(:,i)= omiga/pi*trapz(D_expr.*cos(n*omiga*t)*delta_t);
v1(:,i) =  omiga/pi*trapz(U_exp.*cos(n*omiga*t)*delta_t);
i=i+1;
end
alpha1(:,1)=0;
beta1(:,1)=0;
i=1;
for n=1:1:10
alpha1(:,i+1) = n*omiga/a/1.414*sqrt(1+sqrt(1+(c/n/omiga)^2));
beta1(:,i+1)= n*omiga/a/1.414*sqrt(-1+sqrt(1+(c/n/omiga)^2));
tao1(:,i) = omiga/pi*trapz(D_expr.*sin(n*omiga*t)*delta_t);
delta1(:,i) = omiga/pi*trapz(U_exp.*sin(n*omiga*t)*delta_t);
kaba1(:,i) = (sigma1(:,i+1)*alpha1(:,i+1) + tao1(:,i)*beta1(:,i+1))...
    /(Er*A1g*(alpha1(:,i+1)^2+beta1(:,i+1)^2));
mun1(:,i) = (sigma1(:,i+1)*beta1(:,i+1) - tao1(:,i)*alpha1(:,i+1))...
    /(Er*A1g*(alpha1(:,i+1)^2+beta1(:,i+1)^2));
i=i+1;
end

i=1;
for n=1:1:10 
O1(:,i) = (kaba1(:,i)*cosh(beta1(:,i+1)*x1)+delta1(:,i)*...
    sinh(beta1(:,i+1)*x1))*sin(alpha1(:,i+1)*x1)+ (mun1(:,i)*sinh(beta1(:,i+1)*x1)+...
    v1(:,i+1)*cosh(beta1(:,i+1)*x1))*cos(alpha1(:,i+1)*x1);
P1(:,i) = (kaba1(:,i)*sinh(beta1(:,i+1)*x1)+delta1(:,i)*...
    cosh(beta1(:,i+1)*x1))*cos(alpha1(:,i+1)*x1)- (mun1(:,i)*cosh(beta1(:,i+1)*x1)+...
    v1(:,i+1)*sinh(beta1(:,i+1)*x1))*sin(alpha1(:,i+1)*x1);
O1_p(:,i) = (tao1(:,i)/Er/A1g*sinh(beta1(:,i+1)*x1)+(delta1(:,i)*...
    beta1(:,i+1)-v1(:,i+1)*alpha1(:,i+1))*cosh(beta1(:,i+1)*x1))*sin(alpha1(:,i+1)*x1)+...
    (sigma1(:,i+1)/Er/A1g*cosh(beta1(:,i+1)*x1)+(v1(:,i+1)*beta1(:,i+1)+...
    delta1(:,i)*alpha1(:,i+1))*sinh(beta1(:,i+1)*x1))*cos(alpha1(:,i+1)*x1);
P1_p(:,i) = (tao1(:,i)/Er/A1g*cosh(beta1(:,i+1)*x1)+(delta1(:,i)*...
    beta1(:,i+1)-v1(:,i+1)*alpha1(:,i+1))*sinh(beta1(:,i+1)*x1))*cos(alpha1(:,i+1)*x1)-...
    (sigma1(:,i+1)/Er/A1g*sinh(beta1(:,i+1)*x1)+(v1(:,i+1)*beta1(:,i+1)+...
    delta1(:,i)*alpha1(:,i+1))*cosh(beta1(:,i+1)*x1))*sin(alpha1(:,i+1)*x1);
i=i+1;
end
du1_xtn=zeros(143,1);
df1_xtn=zeros(143,1);
for n=1:1:10
    du1_xt(:,n)=O1(:,n)*cos(n*omiga*t)+P1(:,n)*sin(n*omiga*t);
    du1_xtn=du1_xtn(:,1)+du1_xt(:,n);
    df1_xt(:,n)=O1_p(:,n)*cos(n*omiga*t)+P1_p(:,n)*sin(n*omiga*t);
    df1_xtn=df1_xtn(:,1)+df1_xt(:,n);
end


u1_xt=sigma1(1)*x1/(2*Er*A1g)+ v1(1)/2 + du1_xtn;
f1_xt=(sigma1(1))/2+Er*A1g*df1_xtn-W_fz1;


% 二级杆
v2(:,1)=sigma1(:,1)*x1/(Er*A1g)+v1(:,1);
sigma2(:,1)=sigma1(:,1);

for n = 1:1:10
    
v2(:,n+1) = O1(:,n);
delta2(:,n) = P1(:,n);
sigma2(:,n+1) = Er*A1g*O1_p(:,n);
tao2(:,n) = Er*A1g*P1_p(:,n);

end

alpha2 = alpha1;
beta2 = beta1;

i=1;
for n=1:1:10
kaba2(:,i) = (sigma2(:,i+1)*alpha2(:,i+1) + tao2(:,i)*beta2(:,i+1))...
    /(Er*A2g*(alpha2(:,i+1)^2+beta2(:,i+1)^2));
mun2(:,i) = (sigma2(:,i+1)*beta2(:,i+1) - tao2(:,i)*alpha2(:,i+1))...
    /(Er*A2g*(alpha2(:,i+1)^2+beta2(:,i+1)^2));
i=i+1;
end

i=1;
for n=1:1:10 
O2(:,i) = (kaba2(:,i)*cosh(beta2(:,i+1)*x2)+delta2(:,i)*...
    sinh(beta2(:,i+1)*x2))*sin(alpha2(:,i+1)*x2)+ (mun2(:,i)*sinh(beta2(:,i+1)*x2)+...
    v2(:,i+1)*cosh(beta2(:,i+1)*x2))*cos(alpha2(:,i+1)*x2);
P2(:,i) = (kaba2(:,i)*sinh(beta2(:,i+1)*x2)+delta2(:,i)*...
    cosh(beta2(:,i+1)*x2))*cos(alpha2(:,i+1)*x2)- (mun2(:,i)*cosh(beta2(:,i+1)*x2)+...
    v2(:,i+1)*sinh(beta2(:,i+1)*x2))*sin(alpha2(:,i+1)*x2);
O2_p(:,i) = (tao2(:,i)/Er/A2g*sinh(beta2(:,i+1)*x2)+(delta2(:,i)*...
    beta2(:,i+1)-v2(:,i+1)*alpha2(:,i+1))*cosh(beta2(:,i+1)*x2))*sin(alpha2(:,i+1)*x2)+...
    (sigma2(:,i+1)/Er/A2g*cosh(beta2(:,i+1)*x2)+(v2(:,i+1)*beta2(:,i+1)+...
    delta2(:,i)*alpha2(:,i+1))*sinh(beta2(:,i+1)*x2))*cos(alpha2(:,i+1)*x2);
P2_p(:,i) = (tao2(:,i)/Er/A2g*cosh(beta2(:,i+1)*x2)+(delta2(:,i)*...
    beta2(:,i+1)-v2(:,i+1)*alpha2(:,i+1))*sinh(beta2(:,i+1)*x2))*cos(alpha2(:,i+1)*x2)-...
    (sigma2(:,i+1)/Er/A2g*sinh(beta2(:,i+1)*x2)+(v2(:,i+1)*beta2(:,i+1)+...
    delta2(:,i)*alpha2(:,i+1))*cosh(beta2(:,i+1)*x2))*sin(alpha2(:,i+1)*x2);
i=i+1;
end

du2_xtn=zeros(N_data(:,1),1);
df2_xtn=zeros(N_data(:,1),1);
for n=1:1:10
    du2_xt(:,n)=O2(n)*cos(n*omiga*t)+P2(n)*sin(n*omiga*t);
    du2_xtn=du2_xtn(:,1)+du2_xt(:,n);
    df2_xt(:,n)=O2_p(n)*cos(n*omiga*t)+P2_p(n)*sin(n*omiga*t);
    df2_xtn=df2_xtn(:,1)+df2_xt(:,n);
end

f2_xt=(sigma2(1))/2+Er*A2g*df2_xtn-W_fz2;
u2_xt=sigma2(1)*x2/(2*Er*A2g)+ v2(1)/2 + du2_xtn;

% 三级杆
v3(:,1)=sigma2(:,1)*x2/(Er*A2g)+v2(:,1);
sigma3(:,1)=sigma2(:,1);

for n = 1:1:10
    
v3(:,n+1) = O2(:,n);
delta3(:,n) = P2(:,n);
sigma3(:,n+1) = Er*A2g*O2_p(:,n);
tao3(:,n) = Er*A2g*P2_p(:,n);

end

alpha3 = alpha2;
beta3 = beta2;

i=1;
for n=1:1:10
kaba3(:,i) = (sigma3(:,i+1)*alpha3(:,i+1) + tao3(:,i)*beta3(:,i+1))...
    /(Er*A3g*(alpha3(:,i+1)^2+beta3(:,i+1)^2));
mun3(:,i) = (sigma3(:,i+1)*beta3(:,i+1) - tao3(:,i)*alpha3(:,i+1))...
    /(Er*A3g*(alpha3(:,i+1)^2+beta3(:,i+1)^2));
i=i+1;
end

i=1;
for n=1:1:10 
O3(:,i) = (kaba3(:,i)*cosh(beta3(:,i+1)*x3)+delta3(:,i)*...
    sinh(beta3(:,i+1)*x3))*sin(alpha3(:,i+1)*x3)+ (mun3(:,i)*sinh(beta3(:,i+1)*x3)+...
    v3(:,i+1)*cosh(beta3(:,i+1)*x3))*cos(alpha3(:,i+1)*x3);
P3(:,i) = (kaba3(:,i)*sinh(beta3(:,i+1)*x3)+delta3(:,i)*...
    cosh(beta3(:,i+1)*x3))*cos(alpha3(:,i+1)*x3)- (mun3(:,i)*cosh(beta3(:,i+1)*x3)+...
    v3(:,i+1)*sinh(beta3(:,i+1)*x3))*sin(alpha3(:,i+1)*x3);
O3_p(:,i) = (tao3(:,i)/Er/A3g*sinh(beta3(:,i+1)*x3)+(delta3(:,i)*...
    beta3(:,i+1)-v3(:,i+1)*alpha3(:,i+1))*cosh(beta3(:,i+1)*x3))*sin(alpha3(:,i+1)*x3)+...
    (sigma3(:,i+1)/Er/A3g*cosh(beta3(:,i+1)*x3)+(v3(:,i+1)*beta3(:,i+1)+...
    delta3(:,i)*alpha3(:,i+1))*sinh(beta3(:,i+1)*x3))*cos(alpha3(:,i+1)*x3);
P3_p(:,i) = (tao3(:,i)/Er/A3g*cosh(beta3(:,i+1)*x3)+(delta3(:,i)*...
    beta3(:,i+1)-v3(:,i+1)*alpha3(:,i+1))*sinh(beta3(:,i+1)*x3))*cos(alpha3(:,i+1)*x3)-...
    (sigma3(:,i+1)/Er/A3g*sinh(beta3(:,i+1)*x3)+(v3(:,i+1)*beta3(:,i+1)+...
    delta3(:,i)*alpha3(:,i+1))*cosh(beta3(:,i+1)*x3))*sin(alpha3(:,i+1)*x3);
i=i+1;
end

du3_xtn=zeros(143,1);
df3_xtn=zeros(143,1);
for n=1:1:10
    du3_xt(:,n)=O3(:,n)*cos(n*omiga*t)+P3(:,n)*sin(n*omiga*t);
    du3_xtn=du3_xtn(:,1)+du3_xt(:,n);
    df3_xt(:,n)=O3_p(:,n)*cos(n*omiga*t)+P3_p(:,n)*sin(n*omiga*t);
    df3_xtn=df3_xtn(:,1)+df3_xt(:,n);
end

f3_xt=sigma3(1)/2+Er*A3g*df3_xtn-W_fz3;
u3_xt=sigma3(1)*x3/(2*Er*A3g)+ v3(1)/2 + du3_xtn;


figure (1)
hold on;
set(gca,'box','on')
set(gca,'linewidth',2);
axis([0  7 -2*10^4 10*10^4]);
plot(U_exp,D_expr,u1_xt,f1_xt,'r--',u2_xt,f2_xt,'black-.',u3_xt,f3_xt,'g:','LineWidth',2);
xlabel('Displacement / m ','fontsize',16);
ylabel('Load / N ','fontsize',16);
legend('实测悬点示功图','一级杆示功图','二级杆示功图','泵功图(三级杆)');

figure (2)
hold on;
set(gca,'box','on')
set(gca,'linewidth',2);
plot(t,U_exp,t,u1_xt,'r--',t,u2_xt,'black-.',t,u3_xt,'g:','LineWidth',2);
xlabel('Time / s ','fontsize',16);
ylabel('Displacement / m ','fontsize',16);
legend('实测悬点位移','一级杆位移','二级杆位移','三级杆位移');

figure (3)
hold on;
set(gca,'box','on')
set(gca,'linewidth',2);
plot(t,D_expr,t,f1_xt,'r--',t,f2_xt,'black-.',t,f3_xt,'g:','LineWidth',2);
xlabel('Time / s ','fontsize',16);
ylabel('Load / N ','fontsize',16);
legend('实测悬点载荷','一级杆载荷','二级杆载荷','三级杆载荷');