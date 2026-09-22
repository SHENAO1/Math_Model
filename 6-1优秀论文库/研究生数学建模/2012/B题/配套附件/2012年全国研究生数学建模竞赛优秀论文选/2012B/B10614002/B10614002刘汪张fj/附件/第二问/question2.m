%Y4是60:10:170时刻的0号空间飞行器的参数，xx,yy,zz,dx,dy,dz是50时刻的0号空间飞行器的参数
function  [xx,yy,zz,dx,dy,dz,Y4]=question2()
load line06.txt
y0=[-1112138.62556717,-795.009000000000,6200400.27673336,736.338600000000,1133222.51025844, 945.0890];
ts=60:10:170;
ts5=line06(:,1);
options=odeset('abstol',10^(-7));  
[X,Y]=ode45(@fun4,[50.181218909269,60],y0,options);
[X4,Y4]=ode45(@fun4,ts,Y(end,:),options);
[X5,Y5]=ode45(@fun4,ts5,y0,options);
xx=spline(ts5,Y5(:,1),50)
dx=spline(ts5,Y5(:,2),50)
yy=spline(ts5,Y5(:,3),50)
dy=spline(ts5,Y5(:,4),50)
zz=spline(ts5,Y5(:,5),50)
dz=spline(ts5,Y5(:,6),50)


subplot(2,3,1),plot(ts5,Y5(:,1)),title('x-t')
subplot(2,3,2),plot(ts5,Y5(:,3)),axis([0 200 6.195*10^6 6.35*10^6]),title('y-t')
subplot(2,3,3),plot(ts5,Y5(:,5)),title('z-t')
subplot(2,3,4),plot(ts5,Y5(:,2)),title('Vx-t')
subplot(2,3,5),plot(ts5,Y5(:,4)),axis([0 200 650 1250]),title('Vy-t')
subplot(2,3,6),plot(ts5,Y5(:,6)),axis([0 200 0 5000]),title('Vz-t')
YY=Y5(:,4);


function z=fun4(x,y)
Gm=3.986005*10^14;
k=21.6000;
m0=0.0035;
z(1,:)=y(2);
z(2,:)=-Gm./(y(1).^2+y(3).^2+y(5).^2).^1.5.*y(1)+y(2)./((y(2).^2+y(4).^2+y(6)).^0.5).*(k/(1-m0*(x-50.1812189092689990)));
z(3,:)=y(4);
z(4,:)=-Gm./(y(1).^2+y(3).^2+y(5).^2).^1.5.*y(3)+y(4)./((y(2).^2+y(4).^2+y(6)).^0.5).*(k/(1-m0*(x-50.1812189092689990)));
z(5,:)=y(6);
z(6,:)=-Gm./(y(1).^2+y(3).^2+y(5).^2).^1.5.*y(5)+y(6)./((y(2).^2+y(4).^2+y(6)).^0.5).*(k/(1-m0*(x-50.1812189092689990)));