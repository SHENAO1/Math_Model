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

b=(Rour-Rou_l)/Rour;
Wr=A1g * Rour * Bl;
Wr_p=Wr * b;
deltaW = (Ab-A1g)*Bl*Rou_l; %kg
Wl_p = Ab * G1l * Rou_l *9.8; 
Pr = Wl_p * S * mu / (6*10^4) 

a = sqrt (Er/Rour);
Q = (Ab * S * mu * 60 *24 )* Rou_l; % kg/d
Lf = (deltaW*9.8-10^6*(Pt-Pc)*Ab)/(Ab*Rou_l*9.8);
H = Lf + (Pt-Pc)/(Rou_l*9.8)*10^6;
Ph = Q/1000*H*9.8/86400
gama = (4.42*10^(-2)*(G1l*3.28)*(Pr-Ph)/0.73549875*T^2)/((A1g*1550)*(G1l*3.28)*(S*3.28)^2);
c = pi*(a*3.28)*gama/(2*(G1l*3.28)) %Gibbs方法计算的c
gama_new=(184*G1l*(Pr-Ph)/0.73549875*T^3)/...
((Rour-Rou_l)*(G1l/G1r)*(A1g*G1l)*S^3);
c_new = pi*(a*3.28)*gama_new/(2*(G1l*3.28)) %第一种方法计算的c

