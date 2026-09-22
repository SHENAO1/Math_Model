%求空间飞行器轨迹和两垂足直线表示图
function xianduan3

load opt_ln6.mat;
load cuixianduan3.txt

xx=cuixianduan3(1,:);
yy=cuixianduan3(2,:);
zz=cuixianduan3(3,:);
subplot(2,2,1),plot3(xx,yy,zz,'b'),hold on
n1=length(xx)


x1=cuixianduan3(4,:);
y1=cuixianduan3(5,:);
z1=cuixianduan3(6,:);
plot3(x1,y1,z1,'k'),grid on,hold on
n2=length(x1)

ts=opt_ln6(:,1);
options=odeset('abstol',10^(-7));  
%y0=[-1112138.62556717,-702.450274290750,6200400.27673336,815.800858372822,1133222.51025844,941.009488978889];
%y0=[-1112138.62556717,-795.009000000000,6200400.27673336,736.338600000000,1133222.51025844, 945.0890];
y0=[-1120528.80725998, -773.6586,6178864.35550883,738.7275,1123644.39890016,920.6052];
[XX,YY]=ode45(@fun3,ts,y0,options);
n3=length(XX)

plot3(YY(:,1),YY(:,3),YY(:,5),'r')




subplot(2,2,2),plot(xx,yy,'b*'),hold on
plot(x1,y1,'k*'),hold on
plot(YY(:,1),YY(:,3),'r')


subplot(2,2,3),plot(yy,zz,'b*'),hold on
plot(y1,z1,'k*'),hold on
plot(YY(:,3),YY(:,5),'r')


subplot(2,2,4),plot(xx,zz,'b*'),hold on
plot(x1,z1,'k*'),hold on
plot(YY(:,1),YY(:,5),'r')





function z=fun3(x,y)
Gm=3.986005*10^14;
 k=  21.7000;
m0=0.0036;
z(1,:)=y(2);
z(2,:)=-Gm./(y(1).^2+y(3).^2+y(5).^2).^1.5.*y(1)+y(2)./((y(2).^2+y(4).^2+y(6)).^0.5).*(k/(1-m0*(x-50.1812189092689990)));
z(3,:)=y(4);
z(4,:)=-Gm./(y(1).^2+y(3).^2+y(5).^2).^1.5.*y(3)+y(4)./((y(2).^2+y(4).^2+y(6)).^0.5).*(k/(1-m0*(x-50.1812189092689990)));
z(5,:)=y(6);
z(6,:)=-Gm./(y(1).^2+y(3).^2+y(5).^2).^1.5.*y(5)+y(6)./((y(2).^2+y(4).^2+y(6)).^0.5).*(k/(1-m0*(x-50.1812189092689990)));
