sati=load('satinfo.txt');
mdata_60=load('meadata_06_00.txt');
mdata_90=load('meadata_09_00.txt');
mdata_91=load('meadata_09_01.txt');
%龙格库塔法求常微分方程数值解
[t r]=ode45(@myfun_1,[0:50:9000],sati(10,:));
%画地球
[fi,the]=meshgrid(0:pi/100:pi,0:pi/50:2*pi);
x=6375000.*sin(fi).*cos(the);
y=6375000.*sin(fi).*sin(the);
z=6375000.*cos(fi);
 surf(x,y,z)
 xlabel('x');ylabel('y');zlabel('z')
%画9号卫星轨道和初始点
hold on
plot3(r(:,1),r(:,2),r(:,3),'LineWidth',1.5)
plot3(sati(10,1),sati(10,2),sati(10,3),'r*', 'MarkerSize',10)
