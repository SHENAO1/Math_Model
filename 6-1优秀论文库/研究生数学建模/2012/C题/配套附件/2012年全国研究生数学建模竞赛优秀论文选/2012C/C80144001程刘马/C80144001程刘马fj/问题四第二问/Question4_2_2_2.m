clc
clear
format long;
Er = 2.1*10^11; %Pa 
Rour = 8456; %kg/m^3
T= 60/7.6; %s
Br = 44/1000; % m
G1r = 25/1000; %m 
G2r = 22/1000; %m 
G3r = 19/1000; %m 
G1l = 792.5; %m
Bl =1819.56; %m
A1g= pi *(G1r/2)^2;
A2g= pi *(G2r/2)^2;
A3g= pi *(G3r/2)^2;
S = 4.2; %m
mu =4; %1/min
G1l=523.61;
G2l=664.32;
G3l=618.35;
x=0.912;  %含水率
u_o=30*10^(-3);       %油的粘度 Pa.s
u_w=0.8937*10^(-3);   %水的粘度 Pa.s
u=10^(x*log10(u_w)+(1-x)*log10(u_o));
T=60/mu;
a=sqrt(Er/Rour);
omiga=2*pi/T;
Gl=G1l+G2l+G3l;
m=Br/G3r;
B1=(m^2-1)/(2*log(m))-1;
B2=m^4-1-((m^2-1)^2)/(log(m));
z=omiga*Gl/a;
c_new2=2*pi*u/(Rour*A3g)*(1/log(m)+4/B2*...
    (B1+1)*(B1+2/(z/sin(z)+cos(z))))