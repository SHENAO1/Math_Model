%% 给定初始条件，经过数值计算返回末状态位置参数
function [X1,Y1,Z1,X2,Y2,Z2]= szqj(x0,y0,z0,v0)
x(1)=x0;                         
y(1)=y0;
z(1)=z0;
A(1)=v0(1);
B(1)=v0(2);
C(1)=v0(3);
Gm=3.986005*10^14;
t(1)=50;
h=0.1;
n=1;
while(t<170)
    r=norm([x(n),y(n),z(n)]);
    v=norm([A(n),B(n),C(n)]);
    x(n+1)=h*A(n)+x(n);
    A(n+1)=h*(-Gm/r^3*x(n)+7863/(308.6-t(n))*A(n)/v)+A(n);
    y(n+1)=h*B(n)+y(n);
    B(n+1)=h*(-Gm/r^3*y(n)+7863/(308.6-t(n))*B(n)/v)+B(n);
    z(n+1)=h*C(n)+z(n);
    C(n+1)=h*(-Gm/r^3*y(n)+7863/(308.6-t(n))*B(n)/v)+C(n);
    t(n+1)=t(n)+h;
    n=n+1;
end
n0=1;
for i=1:10:length(x)
    x0(n0)=x(i);y0(n0)=y(i);z0(n0)=z(i);
    n0=n0+1;
end
plot3(x0,y0,z0,'-^');
X1=x(n);Y1=y(n);Z1=z(n);X2=x(fix(n/2));Y2=y(fix(n/2));Z2=z(fix(n/2));
