clc
clear
format long;
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
G1l=792.5;
T=60/7.6;
x=0.98;  %含水率
u_o=30*10^(-3);       %油的粘度 Pa.s
u_w=0.8937*10^(-3);   %水的粘度 Pa.s
u=10^(x*log10(u_w)+(1-x)*log10(u_o));
a=sqrt(Er/Rour);
omiga=2*pi/T;
m=Br/G1r;
B1=(m^2-1)/(2*log(m))-1;
B2=m^4-1-((m^2-1)^2)/(log(m));
z=omiga*G1l/a;
c_new2=2*pi*u/(Rour*A1g)*(1/log(m)+4/B2*...
    (B1+1)*(B1+2/(z/sin(z)+cos(z))))