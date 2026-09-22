%求飞行器速度的二次多项式去噪
load fxq.txt
load line09.txt
x=line09(1:end-1,1)';
y1=fxq(1,1:end-1);
P1=polyfit(x,y1,2);
Y1=polyval(P1,x);
figure(1),plot(x,y1,'g','LineWidth',1),hold on
plot(x,Y1,'LineWidth',2)

y2=fxq(2,1:end-1);
P2=polyfit(x,y2,2);
Y2=polyval(P2,x);
figure(2),plot(x,y2,'g','LineWidth',1),hold on
plot(x,Y2,'LineWidth',2)

y3=fxq(3,1:end-1);
P3=polyfit(x,y3,2);
Y3=polyval(P3,x);
figure(3),plot(x,y3,'g','LineWidth',1),hold on
plot(x,Y3,'LineWidth',2)