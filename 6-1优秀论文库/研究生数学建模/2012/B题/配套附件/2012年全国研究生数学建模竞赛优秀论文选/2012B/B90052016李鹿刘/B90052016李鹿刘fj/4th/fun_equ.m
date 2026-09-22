function F=fun_equ(x,tempy9,deltat,tempalfa,tempbeta,stepnum)
%%%x(1):->x; x(2):->y;x(3):->z;x(4):->vx; x(5):->vy;x(6):->vz;x(7)->xs1;x(8)->xs2;x(9)->xs3;
F=[];
flag=1;

alfa09=tempalfa(flag);
beta09=tempbeta(flag);

x09=tempy9(1,flag);%%%%%%%%%对应于t时刻的坐标
y09=tempy9(2,flag);
z09=tempy9(3,flag);
r09=norm(tempy9(:,flag));
thou09=norm(tempy9(1:2,flag));

A=[x09/r09 -y09/thou09 -x09*z09/r09/thou09; y09/r09 x09/thou09 -y09*z09/r09/thou09;z09/r09 0 thou09/r09];
tempF=[x(1)-x09-A(1,:)*[x(7) x(7)*alfa09 x(7)*beta09]';...
       x(2)-y09-A(2,:)*[x(7) x(7)*alfa09 x(7)*beta09]';...
       x(3)-z09-A(3,:)*[x(7) x(7)*alfa09 x(7)*beta09]'];
F=[F tempF];

flag=flag+1;

alfa09=tempalfa(flag);
beta09=tempbeta(flag);

x09=tempy9(1,flag);%%%%%%%%%对应于t时刻的坐标
y09=tempy9(2,flag);
z09=tempy9(3,flag);
r09=norm(tempy9(:,flag));
thou09=norm(tempy9(1:2,flag));

A=[x09/r09 -y09/thou09 -x09*z09/r09/thou09; y09/r09 x09/thou09 -y09*z09/r09/thou09;z09/r09 0 thou09/r09];
tempF=[x(1)+x(4)*deltat-x09-A(1,:)*[x(8) x(8)*alfa09 x(8)*beta09]';...
       x(2)+x(5)*deltat-y09-A(2,:)*[x(8) x(8)*alfa09 x(8)*beta09]';...
       x(3)+x(6)*deltat-z09-A(3,:)*[x(8) x(8)*alfa09 x(8)*beta09]'];
F=[F tempF];


flag=flag+1;

alfa09=tempalfa(flag);
beta09=tempbeta(flag);

x09=tempy9(1,flag);%%%%%%%%%对应于t时刻的坐标
y09=tempy9(2,flag);
z09=tempy9(3,flag);
r09=norm(tempy9(:,flag));
thou09=norm(tempy9(1:2,flag));

A=[x09/r09 -y09/thou09 -x09*z09/r09/thou09; y09/r09 x09/thou09 -y09*z09/r09/thou09;z09/r09 0 thou09/r09];
tempF=[x(1)+x(4)*deltat*2-x09-A(1,:)*[x(9) x(9)*alfa09 x(9)*beta09]';...
       x(2)+x(5)*deltat*2-y09-A(2,:)*[x(9) x(9)*alfa09 x(9)*beta09]';...
       x(3)+x(6)*deltat*2-z09-A(3,:)*[x(9) x(9)*alfa09 x(9)*beta09]'];
F=[F tempF];