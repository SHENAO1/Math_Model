function [xx,yy,zz]=chafen(pos)
%%%%差分计算各点的运动状态
x=pos(1,:);
y=pos(2,:);
z=pos(3,:);%%
h=1;%默认步长为1
%单独计算x方向的速度
vx=zeros(1,length(x));
ax=zeros(1,length(x));
vy=zeros(1,length(y));
ay=zeros(1,length(y));
vz=zeros(1,length(z));
az=zeros(1,length(z));

for t=50:170
    vx(t+1)=(x(t+2)-x(t))/2/h;
    ax(t+1)=(x(t+2)-2*x(t+1)+x(t))/h^2;
    
    vy(t+1)=(y(t+2)-y(t))/2/h;
    ay(t+1)=(y(t+2)-2*y(t+1)+y(t))/h^2;
    
    vz(t+1)=(z(t+2)-z(t))/2/h;
    az(t+1)=(z(t+2)-2*z(t+1)+z(t))/h^2;
end
xx=[x;vx;ax];
yy=[y;vy;ay];
zz=[z;vz;az];