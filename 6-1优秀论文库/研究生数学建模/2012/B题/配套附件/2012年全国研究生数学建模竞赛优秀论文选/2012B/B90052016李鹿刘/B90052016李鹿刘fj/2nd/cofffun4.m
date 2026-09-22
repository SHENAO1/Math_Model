function [tempA,tempb]=cofffun4(xx,yy,zz,t)
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
r_abs=norm([x y z]);
v_abs=norm([vx vy vz]);
% 
% kx=v_abs*(ax+Gm*x/r_abs^3)/vx;
% ky=v_abs*(ay+Gm*y/r_abs^3)/vy;
% kz=v_abs*(az+Gm*z/r_abs^3)/vz;
kx=(ax+Gm*x/r_abs^3)/vx;
ky=(ay+Gm*y/r_abs^3)/vy;
kz=(az+Gm*z/r_abs^3)/vz;
tempA=[1 t t^2 t^3   0 0 0 0 0 0 0 0;0 0 0 0 1 t t^2 t^3  0 0 0 0;0 0 0 0 0 0 0 0 1 t t^2 t^3 ];
tempb=[kx ky kz]';
