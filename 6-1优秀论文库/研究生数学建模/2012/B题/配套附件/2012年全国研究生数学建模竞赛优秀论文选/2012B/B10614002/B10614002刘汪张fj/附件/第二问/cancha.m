%求0号飞行器的估计残差
function [x_cancha,y_cancha,z_cancha,dx_cancha,dy_cancha,dz_cancha]=cancha()

load cuixianduan.txt
load line06.txt
load jingquezhi.txt
t=line06(:,1);
x=0.5*(cuixianduan(1,:)+cuixianduan(4,:));
y=0.5*(cuixianduan(2,:)+cuixianduan(5,:));
z=0.5*(cuixianduan(3,:)+cuixianduan(6,:));

xx=spline(t,x',50:10:170);
yy=spline(t,y',50:10:170);
zz=spline(t,z',50:10:170);
x_cancha=jingquezhi(:,1)-xx';
y_cancha=jingquezhi(:,2)-yy';
z_cancha=jingquezhi(:,3)-zz';

load fxq.txt


y1=fxq(1,1:end-1)';
P1=polyfit(t(1:end-1),y1,2)
Y1=polyval(P1,t);
dx=polyval(P1,50:10:170);

y2=fxq(2,1:end-1)';
P2=polyfit(t(1:end-1),y2,2)
Y2=polyval(P2,t);
dy=polyval(P2,50:10:170);


y3=fxq(3,1:end-1)';
P3=polyfit(t(1:end-1),y3,2)
Y3=polyval(P3,t);
dz=polyval(P3,50:10:170);


dx_cancha=jingquezhi(:,4)-dx';
dy_cancha=jingquezhi(:,5)-dy';
dz_cancha=jingquezhi(:,6)-dz';