function tempm=cofffun(xx,yy,zz,t)

x=xx(1,t+1);
vx=xx(2,t+1);
ax=xx(3,t+1);%%%t时刻的x方向目标状态向量

y=yy(1,t+1);
vy=yy(2,t+1);
ay=yy(3,t+1);

z=zz(1,t+1);
vz=zz(2,t+1);
az=zz(3,t+1);

Gm=3.986005e14;

r_abs=norm([x y z]);%%模
k1=ax+Gm*x/r_abs^3;
k2=ay+Gm*y/r_abs^3;
k3=az+Gm*z/r_abs^3;

tempm=[k1 -k1*t -vx 0 0;k2 -k2*t 0 -vy 0;k3 -k3*t 0 0 -vz];



