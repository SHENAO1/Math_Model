%求0号飞行器的估计残差
function [x_cancha,y_cancha,z_cancha,dx_cancha,dy_cancha,dz_cancha]=cancha3()

load cuixianduan3.txt
load opt_ln6.mat
load jingquezhi3.txt
t=opt_ln6(:,1);
x=0.5*(cuixianduan3(1,:)+cuixianduan3(4,:));
y=0.5*(cuixianduan3(2,:)+cuixianduan3(5,:));
z=0.5*(cuixianduan3(3,:)+cuixianduan3(6,:));

xx=spline(t,x',50:10:170);
yy=spline(t,y',50:10:170);
zz=spline(t,z',50:10:170);
x_cancha=jingquezhi3(:,1)-xx';
y_cancha=jingquezhi3(:,2)-yy';
z_cancha=jingquezhi3(:,3)-zz';

load shudu3.txt


y1=shudu3(1,1:end-1)';
P1=polyfit(t(1:end-1),y1,2)
Y1=polyval(P1,t);
dx=polyval(P1,50:10:170);

y2=shudu3(2,1:end-1)';
P2=polyfit(t(1:end-1),y2,2)
Y2=polyval(P2,t);
dy=polyval(P2,50:10:170);


y3=shudu3(3,1:end-1)';
P3=polyfit(t(1:end-1),y3,2)
Y3=polyval(P3,t);
dz=polyval(P3,50:10:170);


dx_cancha=jingquezhi3(:,4)-dx';
dy_cancha=jingquezhi3(:,5)-dy';
dz_cancha=jingquezhi3(:,6)-dz';