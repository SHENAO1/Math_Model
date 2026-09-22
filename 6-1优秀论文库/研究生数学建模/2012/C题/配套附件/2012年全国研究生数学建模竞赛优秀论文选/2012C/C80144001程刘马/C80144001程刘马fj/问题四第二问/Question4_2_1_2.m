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
Gl=G1l+G2l+G3l; %杆的总长

deltaW = (Ab-A3g)*(G1l+G2l+G3l)*Rou_l; %kg
Wl_p = Ab *( G1l+G2l+G3l) * Rou_l *9.8; 
Pr = Wl_p * S * mu / (6*10^4) ;

a = sqrt (Er/Rour);   %m/s
Q = (Ab * S * mu * 60 *24 )* Rou_l; % kg/d
Lf = (deltaW*9.8-10^6*(Pt-Pc)*Ab)/(Ab*Rou_l*9.8);
H = Lf + (Pt-Pc)/(Rou_l*9.8)*10^6;
Ph = Q/1000*H*9.8/86400;
gama = (4.42*10^(-2)*((G1l+G2l+G3l)*3.28)*(Pr-Ph)/0.73549875*T^2)/...
    (((A1g*1550)*(G1l*3.28)+(A2g*1550)*(G2l*3.28)+(A3g*1550)*(G3l*3.28))*(S*3.28)^2);

c = pi*(a*3.28)*gama/(2*((G1l+G2l+G3l)*3.28)) %Gibbs方法计算的c

Dl_mean=2*sqrt((A1g*G1l+A2g*G2l+A3g*G3l)/(G1l+G2l+G3l)/pi);%抽油杆平均直径
gama_new=(184*Gl*(Pr-Ph)/0.73549875*T^3)/...
((Rour-Rou_l)*(Gl/Dl_mean)*(A1g*G1l+A2g*G2l+A3g*G3l)*S^3);
c_new = pi*(a*3.28)*gama_new/(2*((G1l+G2l+G3l)*3.28)) %第一种方法计算的c

