clc;
fai=0:0.01:2*pi;
a=4.315;
H=3.64826;
L=3.675;
b=2.495;
r=0.950;
t=60/7.6;
dt=t/628;
w=2*pi/t;
J=sqrt((r*sin(fai)).^2+(H-r*cos(fai)).^2);
gama=acos((b^2+J.^2-L^2)./(2*b*J));
pusai=atan((r*sin(fai))/(H-r*cos(fai)));
Theta=pi-gama-pusai;

dTheta = [0.002,diff(Theta)/dt];
dJ=w*r*H.*sin(fai)./J;
SA=a*cos(pi-Theta);
vA=a*dTheta;
aA=(a*(w^2*r*(H.*cos(fai)+b.*cos(fai-Theta))-2*b*w*r.*dTheta.*cos(fai-Theta)-dTheta.^2.*cos(Theta+pusai))./(J.*sin(Theta+pusai)))/2;
aE=fliplr(aA)';
hold on;
set(gca,'box','on')
set(gca,'linewidth',2);
plot(fai,SA,'r-',fai,vA,'black--',fai,fliplr(aA),'LineWidth',2)

xlabel('\phi / rad ','fontsize',16);
ylabel('变量','fontsize',16);
legend('位移 / m','速度 / ms^{-1}','加速度 / ms^{-2}');
a_jqjx=fliplr(aA);
save a_jqjx.dat a_jqjx -ascii
save v_jqjx.dat vA -ascii