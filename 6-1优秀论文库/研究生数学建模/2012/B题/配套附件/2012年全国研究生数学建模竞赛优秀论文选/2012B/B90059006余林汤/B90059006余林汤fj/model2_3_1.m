%带入初值求解轨道r_1
[t r_1]=ode45(@myfun_2,time,[-1.11213E+06	6.20050E+06	1.13322E+06	-7.84450E+02	7.29458E+02	9.32456E+02]);
%估计值与测量值的离差
licha=r_1(:,1:3)-posi00_1(1:end,:);
%残差，即标准差
cancha=sqrt(sum(sum(licha.^2,2))/600);
[t guji_50]=ode45(@myfun_2,[time(1),50],[-1.11213E+06	6.20050E+06	1.13322E+06	-7.84450E+02	7.29458E+02	9.32456E+02]);
[t answer2_3]=ode45(@myfun_2,[time(1),60:10:170],[-1.11213E+06	6.20050E+06	1.13322E+06	-7.84450E+02	7.29458E+02	9.32456E+02]);
answer2_3(1,:)=guji_50(end,:);%answer2_3是50到170秒间隔10s取样的轨道参数
%做位置、速度示意图
close all
figure(1)
subplot(3,2,1)
plot(time,r_1(:,1))
xlabel('t(s)')
ylabel('x(m)')
subplot(3,2,3)
plot(time,r_1(:,2))
xlabel('t(s)')
ylabel('y(m)')
subplot(3,2,5)
plot(time,r_1(:,3))
xlabel('t(s)')
ylabel('z(m)')
subplot(3,2,2)
plot(time,r_1(:,4))
xlabel('t(s)')
ylabel('dx(m/s)')
subplot(3,2,4)
plot(time,r_1(:,5))
xlabel('t(s)')
ylabel('dy(m/s)')
subplot(3,2,6)
plot(time,r_1(:,6))
xlabel('t(s)')
ylabel('dz(m/s)')